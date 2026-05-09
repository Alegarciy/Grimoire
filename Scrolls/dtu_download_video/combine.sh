#!/bin/bash
# =============================================================================
# combine.sh — Merge camera and screen recordings into one MKV
# =============================================================================
# Usage:
#   bash combine.sh <camera.mp4> <screen.mp4> <output_name>
#
# Example:
#   bash combine.sh week01_lecture01_camera.mp4 week01_lecture01_screen.mp4 week01_lecture01
#
# Output:
#   <output_name>.mkv
#
# Notes:
#   - Uses stream copy (no re-encoding) — runs almost instantly
#   - MKV contains two video tracks (screen + camera) and one audio track
#   - Audio is taken from the camera file (screen recordings have no audio)
#   - In VLC: switch tracks via Video → Track
#   - The two recordings may differ slightly in length — that's normal
# =============================================================================

set -e  # Exit immediately on error

# --- Arguments ---------------------------------------------------------------
CAMERA="$1"
SCREEN="$2"
OUTPUT_NAME="${3:-combined}"

if [[ -z "$CAMERA" || -z "$SCREEN" ]]; then
    echo "Usage: bash combine.sh <camera.mp4> <screen.mp4> <output_name>"
    exit 1
fi

OUTPUT="${OUTPUT_NAME}.mkv"

# --- Merge -------------------------------------------------------------------
echo "Merging into ${OUTPUT}..."
echo "  Screen track:  $SCREEN"
echo "  Camera track:  $CAMERA"
echo "  Audio source:  $CAMERA"
echo ""

# -map 0:v  → Video track 1: screen
# -map 1:v  → Video track 2: camera
# -map 1:a  → Audio from camera (screen has none)
# -c copy   → No re-encoding, instant mux
ffmpeg -i "$SCREEN" -i "$CAMERA" \
    -map 0:v \
    -map 1:v \
    -map 1:a \
    -c copy \
    "$OUTPUT"

echo ""
echo "Done! Combined file: ${OUTPUT}"
echo "Open in VLC and switch video tracks via: Video → Track"
