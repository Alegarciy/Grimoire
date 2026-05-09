#!/bin/bash
# =============================================================================
# download.sh — Download a Panopto lecture from DTU
# =============================================================================
# Usage:
#   bash download.sh <camera_url> <screen_url> <output_name>
#
# Example:
#   bash download.sh \
#     "https://dtu.cache.panopto.nordu.net/.../721733/fragmented.mp4" \
#     "https://dtu.cache.panopto.nordu.net/.../223974/fragmented.mp4" \
#     "week01_lecture01"
#
# Output:
#   <output_name>_camera.mp4
#   <output_name>_screen.mp4
#
# How to get the URLs:
#   1. Open the lecture on panopto.dtu.dk
#   2. Open DevTools (F12) → Network tab
#   3. Filter by "fragmented.mp4"
#   4. Copy the two request URLs (one for camera, one for screen)
#   5. Get the file sizes from the "content-length" response header
#      and set CAMERA_SIZE and SCREEN_SIZE below (or pass as args)
# =============================================================================

set -e  # Exit immediately on error

# --- Arguments ---------------------------------------------------------------
CAMERA_URL="$1"
SCREEN_URL="$2"
OUTPUT_NAME="${3:-lecture}"  # Default name if not provided

if [[ -z "$CAMERA_URL" || -z "$SCREEN_URL" ]]; then
    echo "Usage: bash download.sh <camera_url> <screen_url> <output_name>"
    exit 1
fi

# --- Shared headers (mimics browser request from panopto.dtu.dk) -------------
HEADERS=(
    -H "Origin: https://panopto.dtu.dk"
    -H "Referer: https://panopto.dtu.dk/"
    -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36"
    -H "Accept: */*"
)

# --- Helper: get file size from Content-Length header ------------------------
get_size() {
    curl -sI "${HEADERS[@]}" "$1" | grep -i "content-length" | awk '{print $2}' | tr -d '\r'
}

# --- Download camera ---------------------------------------------------------
echo "[1/2] Getting camera file size..."
CAMERA_SIZE=$(get_size "$CAMERA_URL")
echo "      Camera size: $CAMERA_SIZE bytes"
echo "[1/2] Downloading camera → ${OUTPUT_NAME}_camera.mp4"
curl -L "${HEADERS[@]}" \
    --range "0-$((CAMERA_SIZE - 1))" \
    -o "${OUTPUT_NAME}_camera.mp4" \
    "$CAMERA_URL"

# --- Download screen recording -----------------------------------------------
echo "[2/2] Getting screen file size..."
SCREEN_SIZE=$(get_size "$SCREEN_URL")
echo "      Screen size: $SCREEN_SIZE bytes"
echo "[2/2] Downloading screen → ${OUTPUT_NAME}_screen.mp4"
curl -L "${HEADERS[@]}" \
    --range "0-$((SCREEN_SIZE - 1))" \
    -o "${OUTPUT_NAME}_screen.mp4" \
    "$SCREEN_URL"

echo ""
echo "Done! Files saved:"
echo "  ${OUTPUT_NAME}_camera.mp4"
echo "  ${OUTPUT_NAME}_screen.mp4"
echo ""
echo "Run combine.sh to merge them:"
echo "  bash combine.sh ${OUTPUT_NAME}_camera.mp4 ${OUTPUT_NAME}_screen.mp4 ${OUTPUT_NAME}_combined"
