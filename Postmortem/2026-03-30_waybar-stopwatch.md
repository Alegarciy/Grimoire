# Waybar Stopwatch Module

A custom Waybar module that displays a clickable stopwatch timer in the center of the status bar. Click to start, click again to reset.

## Architecture

The feature uses two bash scripts and a Waybar custom module definition:

```
~/.config/omarchy/scripts/stopwatch        # Display script (polled by Waybar every 1s)
~/.config/omarchy/scripts/stopwatch-toggle  # Toggle script (called on click)
~/.config/waybar/config.jsonc              # Module registration
```

State is stored in `/tmp/stopwatch.state`. When the file exists and contains a Unix timestamp, the stopwatch is running. When absent, the stopwatch is idle and shows `00:00:00`.

## Step 1: Create the display script

Create `~/.config/omarchy/scripts/stopwatch`:

```bash
#!/bin/bash
# Waybar stopwatch display — outputs current elapsed time every second.
# State is stored in /tmp/stopwatch.state

STATE_FILE="/tmp/stopwatch.state"

if [[ -f "$STATE_FILE" ]]; then
    start_time=$(cat "$STATE_FILE")
    now=$(date +%s)
    elapsed=$((now - start_time))
    h=$((elapsed / 3600))
    m=$(((elapsed % 3600) / 60))
    s=$((elapsed % 60))
    printf "%02d:%02d:%02d" "$h" "$m" "$s"
else
    echo "00:00:00"
fi
```

Waybar calls this script every second (`"interval": 1`) and displays its stdout as the module text.

## Step 2: Create the toggle script

Create `~/.config/omarchy/scripts/stopwatch-toggle`:

```bash
#!/bin/bash
# Toggle stopwatch: if stopped, start. If running, reset.

STATE_FILE="/tmp/stopwatch.state"

if [[ -f "$STATE_FILE" ]]; then
    rm "$STATE_FILE"
else
    date +%s > "$STATE_FILE"
fi
```

This is called when the module is clicked. It writes the current Unix timestamp to start, or removes the file to reset.

## Step 3: Make both scripts executable

```bash
chmod +x ~/.config/omarchy/scripts/stopwatch
chmod +x ~/.config/omarchy/scripts/stopwatch-toggle
```

## Step 4: Register the module in Waybar config

In `~/.config/waybar/config.jsonc`, add `"custom/stopwatch"` to the `modules-center` array:

```jsonc
"modules-center": ["custom/stopwatch"],
```

Then add the module definition alongside the other custom modules:

```jsonc
"custom/stopwatch": {
    "exec": "~/.config/omarchy/scripts/stopwatch",
    "on-click": "~/.config/omarchy/scripts/stopwatch-toggle",
    "interval": 1,
    "tooltip-format": "Stopwatch\n\nClick to start/reset"
},
```

Key properties:
- `exec` — the script Waybar polls for display text
- `on-click` — the script Waybar runs when the module is clicked
- `interval` — poll frequency in seconds (1s for a responsive timer)

## Step 5: Restart Waybar

Waybar does not auto-reload config changes. Restart it:

```bash
omarchy-restart-waybar
```

## Usage

- The stopwatch appears centered in the Waybar as `00:00:00`
- Click to start — it begins counting up
- Click again to reset back to `00:00:00`
- State survives Waybar restarts (persisted in `/tmp/stopwatch.state`)
- State clears on reboot (`/tmp` is ephemeral)

## Notes

- Custom scripts live in `~/.config/omarchy/scripts/` to keep them tracked in the `~/.config` git repo
- An earlier approach using a standalone GTK4 floating window with Hyprland window rules was abandoned in favor of a native Waybar module — simpler and more integrated with the desktop
- Hyprland v0.53+ uses `match:title` syntax for window rules with explicit `on`/`off` values (e.g., `float on, match:title foo`) — learned during the initial floating-window attempt
