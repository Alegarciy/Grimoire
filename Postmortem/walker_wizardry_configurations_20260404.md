# Walker — Wizardry Configurations

## Context
Ideas for cool Walker (omarchy app launcher) configurations discovered while debugging stale file cache paths.

**Fix applied:** Deleted `/home/gandalf/.cache/elephant/files.db` (+ WAL/SHM sidecars) and restarted Walker to clear old cached file paths after directory moves.

---

## 🧙 1. Show App Descriptions (Subtexts)

Right now `desktopapplications` hides subtexts and actions. Enable them:

**`~/.config/elephant/desktopapplications.toml`**
```toml
show_actions = true        # shows actions like "New Window", "Incognito", etc.
only_search_title = false  # also searches app descriptions
history = true             # ranks frequently used apps to the top
```

And in `~/.config/walker/themes/omarchy-default/style.css` (copy from default first), make the subtext visible:
```css
.item-subtext {
  font-size: 13px;   /* change from 0px → visible */
  opacity: 0.5;
}
```

---

## 🧙 2. SSH Quick Connect

Create a script that reads your `~/.ssh/config` and pipes hosts into Walker:

**`~/.local/bin/walker-ssh`**
```bash
#!/bin/bash
host=$(grep "^Host " ~/.ssh/config | grep -v "\*" | awk '{print $2}' | \
  walker --dmenu -p "SSH to…" --width 400 --minheight 1 --maxheight 300)
[[ -n "$host" ]] && alacritty -e ssh "$host"
```

Then bind it in `~/.config/hypr/bindings.conf`:
```ini
bindd = SUPER CTRL, H, SSH connect, exec, walker-ssh
```

---

## 🧙 3. Kill a Process Picker

Pick and kill any running process interactively:

**`~/.local/bin/walker-kill`**
```bash
#!/bin/bash
proc=$(ps -eo pid,comm,args --no-headers | sort -k2 | \
  walker --dmenu -p "Kill process…" --width 700 --minheight 1 --maxheight 400)
[[ -n "$proc" ]] && kill -9 $(echo "$proc" | awk '{print $1}')
```

Bind it:
```ini
bindd = SUPER CTRL, K, Kill process, exec, walker-kill
```

---

## 🧙 4. Git Projects Launcher

Jump into any git repo in your `~/Documents/Github` folder directly in a terminal:

**`~/.local/bin/walker-projects`**
```bash
#!/bin/bash
project=$(find ~/Documents/Github -maxdepth 2 -name ".git" -type d | \
  sed 's|/.git||' | sed "s|$HOME/||" | sort | \
  walker --dmenu -p "Open project…" --width 600 --minheight 1 --maxheight 400)
[[ -n "$project" ]] && alacritty --working-directory "$HOME/$project"
```

Bind it:
```ini
bindd = SUPER CTRL, P, Open project, exec, walker-projects
```

---

## 🧙 5. More Smart Prefixes

Add these to `~/.config/walker/config.toml`:

```toml
[[providers.prefixes]]
prefix = ">"
provider = "runner"    # run shell commands directly

[[providers.prefixes]]
prefix = "?"
provider = "commands"  # search all system commands/binaries
```

So in Walker you can type `> ls -la ~/Documents` and run it instantly.

---

## 🧙 6. Quick Activate Shortcuts

Map the top results to number keys for instant launch (add to `[keybinds]`):

```toml
[keybinds]
quick_activate = ["1", "2", "3", "4", "5"]
```

Now pressing `1`–`5` in Walker instantly activates that numbered result — no Enter needed.

---

## 🧙 7. Snippets / Text Expander

A clipboard snippet launcher — pick a snippet, it gets pasted:

**`~/.local/bin/walker-snippets`**
```bash
#!/bin/bash
snippets="
📧 my@email.com
🔑 ssh-ed25519 AAAA...yourkey
🌐 https://github.com/yourusername
📍 Your Address Here
📞 +1 (555) 000-0000
"
chosen=$(echo "$snippets" | grep -v '^$' | \
  walker --dmenu -p "Paste snippet…" --width 500 --minheight 1 --maxheight 300)
[[ -n "$chosen" ]] && echo "$chosen" | sed 's/^[^ ]* //' | wl-copy
```

Bind it:
```ini
bindd = SUPER CTRL, T, Text snippets, exec, walker-snippets
```

---

## 🧙 8. Expand Emergency Commands

You already have 1 emergency. Add more panic-button fixes in `~/.config/walker/config.toml`:

```toml
[[emergencies]]
text = "Restart Walker"
command = "omarchy-restart-walker"

[[emergencies]]
text = "Restart Waybar"
command = "omarchy-restart-waybar"

[[emergencies]]
text = "Reload Hyprland"
command = "hyprctl reload"

[[emergencies]]
text = "Kill all notifications"
command = "makoctl dismiss --all"
```
