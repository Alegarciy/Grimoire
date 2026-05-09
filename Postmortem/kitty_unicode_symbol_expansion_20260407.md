# Kitty — Unicode Symbol Expansion for the Wizard Theme

## Context

The wizard theme (Arcane dotfiles) lacked sufficient unicode/icon coverage in the terminal.
The ASCII wizard symbols available by default in JetBrainsMono Nerd Font were not enough —
emoji like 🧙 🔮 🪄 🐉 and richer unicode glyphs needed to be reliably available across
every omarchy theme switch.

---

## 🔍 Investigation

### How omarchy font config is layered

| File | Role |
|---|---|
| `/home/gandalf/.local/share/omarchy/config/fontconfig/fonts.conf` | System-wide font fallback chain |
| `/home/gandalf/.local/share/omarchy/config/kitty/kitty.conf` | Base kitty config — sets `font_family`, includes theme |
| `~/.config/omarchy/current/theme/kitty.conf` | **Generated per theme** — colors only, regenerated on every theme switch |

The key insight: `Noto Color Emoji` was already in the fontconfig fallback chain (`fonts.conf`),
meaning emoji were technically available — but not explicitly mapped in kitty.

### Why you cannot just edit the installed TTF

`/usr/share/fonts/TTF/JetBrainsMonoNerdFont-Regular.ttf` is a system package file managed by
pacman. Editing it would be overwritten on the next `pacman -Syu`. Not the wizard's way.

### Themes vs Templates — a critical distinction

```
Themes  (~/.config/omarchy/themes/<name>/)      ← color palettes, backgrounds
Templates (~/.config/omarchy/themed/*.tpl)      ← blueprints that GENERATE configs
```

On every `omarchy-theme-set <name>`:
1. Theme files are copied to `~/.config/omarchy/current/next-theme/`
2. `omarchy-theme-set-templates` processes every `.tpl` file, filling in `{{ color0 }}` etc.
3. **User templates in `~/.config/omarchy/themed/` take precedence over built-in ones**
4. The result lands in `~/.config/omarchy/current/theme/`
5. Kitty is restarted and includes the freshly generated `kitty.conf`

This means anything added to a user-owned `kitty.conf.tpl` survives every theme switch permanently.

---

## ✅ Solution

### What was done

Created a user override template managed through the Arcane dotfiles (stow):

**File:** `~/Documents/Storm/Arcane/kitty/.config/omarchy/themed/kitty.conf.tpl`

The template is identical to the built-in default (all `{{ color }}` placeholders intact),
with the following appended at the bottom:

```
# ─── Wizard / Arcane symbol mappings ──────────────────────────────────────────
# Emoji (color) — routed to Noto Color Emoji
symbol_map U+1F300-U+1FAFF Noto Color Emoji

# Monochrome Unicode symbols already in JetBrainsMono Nerd Font
# (stars, suits, chess, Greek, math — no extra font needed)
# U+2600-U+27FF  ★ ☆ ♔ ♦ ✠ ✡ ✶ ⚔ ⚡ ∞ Ω Ψ …
```

### Deployed via stow

```bash
cd ~/Documents/Storm/Arcane
stow --target=/home/gandalf kitty
```

**Resulting symlink:**
```
~/.config/omarchy/themed/kitty.conf.tpl
  → ~/Documents/Storm/Arcane/kitty/.config/omarchy/themed/kitty.conf.tpl
```

### Apply without switching themes

```bash
omarchy-theme-set $(omarchy-theme-current)
```

---

## 🧙 Unicode Reference — Wizard Symbols Available

### Already in JetBrainsMono Nerd Font (no extra mapping needed)

| Codepoint | Glyph | Name |
|---|---|---|
| U+2605 | ★ | Black Star |
| U+2606 | ☆ | White Star |
| U+269D | ⚝ | Outlined White Star |
| U+2720 | ✠ | Maltese Cross |
| U+2721 | ✡ | Star of David |
| U+2736 | ✶ | Six Pointed Black Star |
| U+25C6 | ◆ | Black Diamond |
| U+2654 | ♔ | White Chess King |
| U+26A1 | ⚡ | High Voltage |
| U+03A9 | Ω | Greek Omega |
| U+03A8 | Ψ | Greek Psi |
| U+221E | ∞ | Infinity |

### Now available via `symbol_map` → Noto Color Emoji

| Codepoint | Glyph | Name |
|---|---|---|
| U+1F9D9 | 🧙 | Mage / Wizard |
| U+1F52E | 🔮 | Crystal Ball |
| U+1FA84 | 🪄 | Magic Wand |
| U+2728 | ✨ | Sparkles |
| U+1F409 | 🐉 | Dragon |
| U+1F4DC | 📜 | Scroll |
| U+1F319 | 🌙 | Crescent Moon |
| U+1F56F | 🕯️ | Candle |
| U+2694 | ⚔️ | Crossed Swords |

---

## 📁 Files Changed

| File | Action |
|---|---|
| `~/Documents/Storm/Arcane/kitty/.config/omarchy/themed/kitty.conf.tpl` | Created (new stow package) |
| `~/.config/omarchy/themed/kitty.conf.tpl` | Symlink created by stow |

---

## Lessons

- **Never edit system font TTFs** — they are pacman-managed and will be overwritten.
- **Omarchy's template system is the right extension point** — user templates in `~/.config/omarchy/themed/` survive all theme switches and omarchy updates.
- **Kitty `symbol_map` is powerful** — it lets you mix fonts per Unicode range without touching the primary font at all.
- **Stow is the law** — any persistent config change goes through Arcane first.
