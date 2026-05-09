# DTU Panopto Video Downloader

Scripts to download and combine lecture recordings from [panopto.dtu.dk](https://panopto.dtu.dk).

---

## Scripts

| Script | Purpose |
|--------|---------|
| `download.sh` | Downloads camera + screen recordings from Panopto |
| `combine.sh` | Merges both into a single `.mkv` (no re-encoding) |

---

## Workflow

### Step 1 — Get the URLs from your browser

1. Open the lecture on [panopto.dtu.dk](https://panopto.dtu.dk)
2. Open **DevTools** → `F12` → **Network** tab
3. Play the video, then filter requests by `fragmented.mp4`
4. You'll see two requests:
   - One ending in `...hls/XXXXXX/fragmented.mp4` → **camera**
   - One ending in `...screen.hls/XXXXXX/fragmented.mp4` → **screen**
5. Copy both full request URLs

### Step 2 — Download

```bash
bash download.sh \
  "https://dtu.cache.panopto.nordu.net/.../XXXXXX/fragmented.mp4" \
  "https://dtu.cache.panopto.nordu.net/.../screen.hls/XXXXXX/fragmented.mp4" \
  "week01_lecture01"
```

This saves:
- `week01_lecture01_camera.mp4`
- `week01_lecture01_screen.mp4`

### Step 3 — Combine

```bash
bash combine.sh \
  week01_lecture01_camera.mp4 \
  week01_lecture01_screen.mp4 \
  week01_lecture01
```

This saves `week01_lecture01.mkv` — instant, no re-encoding.

---

## Suggested folder structure for your courses

```
~/Videos/DTU/
├── course_A/
│   ├── week01_lecture01.mkv
│   ├── week01_lecture02.mkv
│   └── week02_lecture01.mkv
├── course_B/
│   └── ...
```

---

## Notes

- The `.mkv` contains **two video tracks** (screen + camera) and one audio track
- Open in **VLC** and switch via `Video → Track`
- The two recordings may differ slightly in length — that's normal, Panopto stops them independently
- The URLs expire or may require the session to still be accessible — download promptly
