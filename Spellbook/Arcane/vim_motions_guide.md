# The LazyVim Motions Survival Guide

> For the brave souls who decided `Ctrl+C`, `Ctrl+V` was too mainstream.
> Welcome, young padawan of the terminal. Grab your keyboard — the mouse is dead to us now.
> You chose **LazyVim**, which means you're lazy in the *good* way — you automate everything.

---

## 1. Multi-Cursor Editing

*Because why edit one thing at a time when you can be an octopus?*

### Basics — "Baby's First Multi-Cursor"

Okay so technically, Neovim doesn't have native multi-cursors like VS Code. But Vim said:
*"I don't need multi-cursors, I have **the dot command**."*

| Command | What It Does |
|---------|-------------|
| `.` | Repeats your last change. THE most powerful single key in Vim. Think of it as `Ctrl+D` but galaxy-brained. |
| `*` | Searches for the word under your cursor. Now every instance is highlighted and ready to be hunted. |
| `n` | Jump to the **next** match after `*`. |
| `N` | Jump to the **previous** match. Because sometimes you overshoot. |

**The Baby Combo:**

```
* → cw → type replacement → Esc → n → . → n → . → ...
```

You just did multi-cursor editing. One word at a time. With *precision*.
Think of it like a `for` loop where YOU are the iterator. `n` is `i++`, `.` is the loop body.

---

### Medium — "I Can See the Matrix"

Time to level up. LazyVim gives you some extra toys here.

| Command | What It Does |
|---------|-------------|
| `gn` | Jump to the next match AND select it in visual mode. It's `n` + `v` fused like a DBZ character. |
| `cgn` | Change the next match. This is THE combo. Change it, then just press `.` to repeat on the next one. |
| `dgn` | Delete the next match. Same energy, destructive flavor. |
| `qa ... q` → `@a` | Record a macro into register `a`, then replay it. This is your ACTUAL multi-cursor — a recording of you. |
| `@@` | Replay the last macro. Spam this like it owes you money. |
| `Q` | In LazyVim, this replays the last recorded macro. Even lazier than `@@`. |

**The Medium Combo (selective multi-cursor via `cgn`):**

```
/searchTerm → cgn → type replacement → Esc → . → . → . ...
```

Each `.` finds AND replaces the next occurrence automatically. Skip one? Press `n` then `.`.
It's like `git add -p` but for editing — you choose what gets changed.

**Macro multi-edit (the real deal):**

```
qa           → start recording into register 'a'
0            → go to beginning of line
f"           → jump to first quote
ci"          → change inside quotes
newValue     → type your new text
Esc          → back to normal mode
j            → move down one line
q            → stop recording
10@a         → replay 10 times
```

You just automated yourself. You are now a `cron` job.

---

### Advanced — "I Am Become Vim, Destroyer of Mice"

LazyVim comes with **mini.operators** and you can install **vim-visual-multi** if you truly want VS Code-style multi-cursors. But the Vim Way is more powerful:

| Command | What It Does |
|---------|-------------|
| `:g/pattern/normal @a` | Run macro `a` on EVERY line matching `pattern`. This is `grep \| xargs` energy. |
| `:g/pattern/normal A;` | Append `;` to every line matching `pattern`. Batch editing. Surgical. |
| `:%normal A;` | Append `;` to EVERY line in the file. No survivors. |
| `:%normal I// ` | Comment out the entire file. (Though in LazyVim, just use `gc` for toggling comments — it's mapped via **mini.comment**.) |
| `:g/TODO/d` | Delete every line containing `TODO`. Spring cleaning. |
| `qA ... q` | Append to macro `a` (capital A = append). Build macros incrementally like a linked list. |

**LazyVim bonus — `gc` for commenting:**

| Command | What It Does |
|---------|-------------|
| `gcc` | Toggle comment on current line. No more `:%normal I//` like a caveman. |
| `gc` (visual) | Toggle comment on selection. Select with `V`, then `gc`. Done. |
| `gco` | Add comment on the line below. |
| `gcO` | Add comment on the line above. |

**Recursive macros (danger zone):**

```
qqq          → clear register q
qq           → start recording into q
n            → jump to next match
cgn          → change it
replacement  → type new text
Esc          → done editing
@q           → call yourself recursively (yes, really)
q            → stop recording
@q           → light the fuse
```

This macro calls itself. It's a recursive function with the base case being "no more matches found."
Neovim will stop when `n` fails. Elegant? Yes. Terrifying? Also yes.

---

## 2. Select and Jump Through Parts of the Code

*Teleportation is real and it lives in Normal mode. And LazyVim gave it rocket fuel.*

### Basics — "Learning to Walk (Really Fast)"

| Command | What It Does |
|---------|-------------|
| `w` / `b` | Jump forward/backward by **word**. Like skipping stones across a river of code. |
| `e` | Jump to the **end** of the current word. |
| `0` / `$` | Jump to **start/end** of the line. `0` is home. `$` is the end of the road (regex people, you already knew this). |
| `gg` / `G` | Jump to **top/bottom** of file. `gg` = reboot. `G` = EOF. |
| `{` / `}` | Jump by **paragraph** (empty-line-separated blocks). Perfect for hopping between functions. |
| `%` | Jump to **matching bracket** `()`, `{}`, `[]`. It's like a balanced parentheses checker but for your cursor. |
| `v` | Enter **Visual mode** — select character by character. |
| `V` | Enter **Visual Line mode** — selects full lines. Grab entire blocks like a claw machine that actually works. |
| `Ctrl+v` | Enter **Visual Block mode** — column selection. Select a rectangle of text. Spreadsheet vibes. |

**LazyVim file navigation basics:**

| Command | What It Does |
|---------|-------------|
| `<leader>ff` | **Find files** with Telescope/fzf. Fuzzy search your project like `fzf` on steroids. |
| `<leader>fb` | **Find open buffers**. Switch between files without `:ls` like a boomer. |
| `<leader>e` | Toggle **neo-tree** (file explorer). When you need that comforting sidebar. |

**The Baby Combo:**

```
V → } → y → p
```

Select from current line to end of paragraph, yank (copy), paste. You just moved a function.

---

### Medium — "Parkour!" (feat. flash.nvim)

LazyVim ships with **flash.nvim** — which makes `f`, `t`, and `/` even more insane.

**Classic Vim motions (still work, still fire):**

| Command | What It Does |
|---------|-------------|
| `f{char}` / `F{char}` | **Find** character forward/backward on the line. `fa` teleports to the next `a`. |
| `t{char}` / `T{char}` | Jump **till** (just before) the character. Perfect for `dt)` (delete till closing paren). |
| `;` / `,` | Repeat the last `f`/`t` jump forward/backward. It's the `n`/`N` of character search. |
| `/{pattern}` | Search forward. You know regex? Congrats, you have a teleporter. |

**flash.nvim — LazyVim's teleportation upgrade:**

| Command | What It Does |
|---------|-------------|
| `s` | **Flash jump** — type 1-2 chars, then labels appear on every match on screen. Press the label to teleport there. It's like `EasyMotion` but faster. Think of it as O(1) cursor placement. |
| `S` | **Flash Treesitter** — labels appear on AST nodes (functions, blocks, statements). You're jumping to *semantic* code structures, not just characters. You're navigating the parse tree. |
| `r` (in operator-pending) | **Remote flash** — `yr{label}iw` = yank a word from somewhere else WITHOUT moving your cursor. It's `git cherry-pick` for text. |
| `gs` | **Flash in visual/operator mode**. Use it mid-combo: `d` then `s` to flash-delete to a target. |

**Text objects — LazyVim supercharges these via mini.ai:**

| Command | What It Does |
|---------|-------------|
| `vi{` / `va{` | Select **inside/around** curly braces. Also works with `(`, `[`, `"`, `'`, `` ` ``. |
| `vif` / `vaf` | Select **inside/around function call** (mini.ai). LazyVim exclusive! |
| `vic` / `vac` | Select **inside/around class** (mini.ai). |
| `via` / `vaa` | Select **inside/around argument** (mini.ai). Grab one function arg without the others. |
| `vip` / `vap` | Select **inside/around** paragraph. |

**mini.ai text objects are the real superpower.** Think of them as CSS selectors but for your AST:

```
cif    → change inside function call    (rewrite the function body)
daa    → delete around argument         (delete an arg AND the trailing comma)
yic    → yank inside class              (copy the class body)
```

**mini.surround — wrapping & unwrapping:**

| Command | What It Does |
|---------|-------------|
| `gsa{motion}{char}` | **Add** surround. `gsaiw"` = surround word with `"`. |
| `gsd{char}` | **Delete** surround. `gsd"` = remove surrounding quotes. |
| `gsr{old}{new}` | **Replace** surround. `gsr"'` = swap `"` for `'`. |

**The Medium Combo:**

```
vaf → y → /otherFunction → n → p
```

Select around function → copy → search for another function → paste. You just transplanted code.

Or with flash:

```
s → type "re" → hit the label for "return" → V → } → d
```

Flash-jump to a return statement, select the block, delete it. Three seconds. Done.

---

### Advanced — "I Navigate by Landmarks"

| Command | What It Does |
|---------|-------------|
| `Ctrl+o` / `Ctrl+i` | Jump to **older/newer** cursor positions. It's `cd -` but for your cursor. Undo your jumps. |
| `m{a-z}` | Set a **local mark**. `ma` = "I'll be back." |
| `'{a-z}` | Jump to a mark. `'a` = "I'm back." |
| `m{A-Z}` | Set a **global mark** (works across files). `mA` in `main.py`, then `'A` from anywhere. Fast travel unlocked. |
| `]m` / `[m` | Jump to the **next/previous method**. Hop between functions like a debugger stepping through a call stack. |
| `]d` / `[d` | Jump to **next/previous diagnostic**. LazyVim LSP integration — jump between errors and warnings. |
| `]t` / `[t` | Jump to **next/previous TODO** comment (via todo-comments.nvim). |
| `zz` / `zt` / `zb` | Center/Top/Bottom the screen on your cursor. Cinematography for coders. |
| `Ctrl+d` / `Ctrl+u` | Scroll **half page** down/up. Smooth scrolling without the scroll wheel. |

**LazyVim LSP navigation (the real endgame):**

| Command | What It Does |
|---------|-------------|
| `gd` | **Go to definition**. Powered by LSP. Jump into the source of any symbol. |
| `gr` | **Go to references**. Find every file that calls this function. It's `grep` but it actually understands your code. |
| `gI` | **Go to implementation**. Interface → concrete class. |
| `gy` | **Go to type definition**. What *type* is this thing? |
| `K` | **Hover docs**. See the signature and docs without leaving your file. |
| `<leader>ss` | **Search symbols** in current file via Telescope. Jump to any function, class, or variable. |
| `<leader>sS` | **Search symbols** in the entire workspace. |

**The Advanced Combo (surgical code navigation):**

```
mM → <leader>ss → type "handleSubmit" → Enter → vaf → y → 'M → p
```

Mark your spot → search for a symbol → jump to it → select the whole function → copy → jump back → paste.

You just read a function definition and came back without losing your place. That's `git stash` / `git stash pop` energy but for your eyeballs.

**Flash Treesitter combo:**

```
S → select the function node → y
```

Flash Treesitter labels actual AST nodes. You can select an entire `if` block, a `for` loop, or a function — semantically. No need to count braces. The parser already knows where they end.

---

## 3. Select && Replace

*`sed` walked so LazyVim could fly.*

### Basics — "Find and Replace: Home Edition"

| Command | What It Does |
|---------|-------------|
| `r{char}` | **Replace** the character under cursor. One shot, one kill. |
| `R` | Enter **Replace mode** — overwrite as you type, like INSERT on old keyboards. |
| `~` | Toggle case of the character under cursor. `a` → `A`, `A` → `a`. |
| `cw` | **Change word** — delete word and drop into insert mode. Two birds, one keystroke. |
| `cc` | **Change entire line**. Nuke it and start fresh. |
| `C` | **Change from cursor to end of line**. Like `cc` but spares the beginning. |
| `s` | (When flash.nvim is not in normal mode) **Substitute** character — delete it, enter insert mode. |
| `S` | (When flash.nvim is not in normal mode) **Substitute** entire line. |

> **Note:** In LazyVim, `s` and `S` are remapped to flash.nvim in normal mode.
> The classic substitute behavior still works in operator-pending and visual modes.
> Use `cl` as a drop-in replacement for old `s` behavior if you need it.

**The Baby Combo:**

```
/oldName → cw → newName → Esc → n → . → n → .
```

Manual find-and-replace. You're the human in the loop. This is *supervised learning*.

---

### Medium — "The Substitution Command" (+ LazyVim extras)

Welcome to `:s` — Vim's built-in `sed`. If you've ever piped `sed 's/old/new/g'`, you already speak this language.

| Command | What It Does |
|---------|-------------|
| `:s/old/new/` | Replace **first** occurrence of `old` on current line. |
| `:s/old/new/g` | Replace **all** occurrences on current line. The `g` = global (on this line). |
| `:%s/old/new/g` | Replace **all** occurrences in the **entire file**. `%` = every line. This is your bread and butter. |
| `:%s/old/new/gc` | Same but with **confirmation** for each match. `y/n/a/q/l` — it's interactive `sed`! |
| `:%s/old/new/gi` | Case **insensitive** replace. |
| `:5,20s/old/new/g` | Replace only on **lines 5 through 20**. Scoped destruction. |
| `:'<,'>s/old/new/g` | Replace within your **visual selection**. Select first, then type `:s/...`. |

**Confirmation options when using `gc`:**

| Key | Meaning |
|-----|---------|
| `y` | Yes, replace this one |
| `n` | No, skip it |
| `a` | All — replace this and all remaining (YOLO mode) |
| `q` | Quit — stop replacing |
| `l` | Last — replace this one and then quit |

**LazyVim search & replace superpowers:**

| Command | What It Does |
|---------|-------------|
| `<leader>sr` | **Search and replace** across project using [spectre.nvim](https://github.com/nvim-pack/nvim-pack/nvim-spectre). A full UI for find-and-replace across your entire codebase. It's like `sed -i` met a GUI and had a beautiful baby. |
| `<leader>cr` | **Rename symbol** via LSP (inc-rename.nvim). Rename a variable/function everywhere — definition AND all references. The LSP knows your code's semantics. This is not string matching. This is *understanding*. |

**The Medium Combo:**

```
<leader>cr → type new name → Enter
```

You just renamed a function across your ENTIRE project — every import, every call site, every reference. The LSP did the graph traversal for you. O(1) refactor time.

Or the classic:

```
:%s/console\.log/logger.info/gc
```

Upgrade every `console.log` to `logger.info` with confirmation. Your tech lead will be proud.

---

### Advanced — "Regular Expressions Go Brrr"

This is where Vim becomes a full-blown refactoring engine. You have the power of regex capture groups, special atoms, and even expressions.

| Command | What It Does |
|---------|-------------|
| `:%s/\v(\w+)_(\w+)/\1\u\2/g` | Convert `snake_case` to `camelCase`. `\v` = "very magic" mode (sane regex). `\u` = uppercase next char. |
| `:%s/\vfoo(Bar\|Baz)/qux\1/g` | Replace `fooBar` → `quxBar` AND `fooBaz` → `quxBaz`. Alternation with capture groups. |
| `:%s/\v"([^"]+)"/'\1'/g` | Replace double quotes with single quotes, preserving content. |
| `:%s/\v(\w+): (\w+)/\2: \1/g` | Swap key-value pairs: `name: string` → `string: name`. |
| `:%s//replacement/g` | Replace the **last searched pattern**. Empty pattern = reuse. Combine with `/` search for previewing matches before replacing. |

**Vim regex special sauce:**

| Atom | What It Means |
|------|--------------|
| `\v` | **Very magic** — `+`, `(`, `\|` work without escaping. Use this. Always. Trust me. |
| `\1`, `\2` | Back-references to capture groups. Like `$1` in JavaScript regex. |
| `\u` / `\l` | Uppercase / lowercase the **next** character in replacement. |
| `\U` / `\L` | Uppercase / lowercase **everything** that follows until `\E` or end. |
| `\zs` / `\ze` | Set match **start/end** (like lookbehind/lookahead but simpler). |
| `\{-}` | Non-greedy match. Vim's version of `*?`. |

**The `:g` command — SQL WHERE clause for text:**

```
:g/class.*Component/s/render/display/g
```

"Only on lines containing `class.*Component`, replace `render` with `display`."

```
:g/TODO/d
```

"Delete every line containing `TODO`." Spring cleaning.

```
:v/function/d
```

"Delete every line NOT containing `function`." `v` is the inverse of `g`. It's `grep -v` energy.

**LazyVim Advanced Replace — combining all the tools:**

1. **LSP rename** (`<leader>cr`) for semantic renames — when you need the computer to *understand* what you're renaming.
2. **Spectre** (`<leader>sr`) for project-wide regex search-and-replace — when it's a string pattern across many files.
3. **`:s` with regex** for surgical in-file transforms — when you're doing something too weird for an LSP.
4. **`cgn` + `.`** for interactive, selective edits — when you need human judgment on each match.

**The Advanced Combo (real-world refactor):**

Convert an object's string values to template literals:

```
:%s/\v"(\w+) (\w+)"/`\1 $\{\2\}`/g
```

Before: `"hello world"` → After: `` `hello ${world}` ``

Or combine `:g` with macros for maximum chaos:

```
:g/async function/normal 0f(a: Promise<void>
```

"On every line with `async function`, go to the opening `(` and insert `: Promise<void>` after it."

You just added return types to every async function in the file. Your TypeScript compiler is crying tears of joy.

---

## Quick Reference Cheat Sheet

| Goal | Beginner | Medium | Advanced |
|------|----------|--------|----------|
| **Multi-edit** | `*` → `cw` → `.` | `cgn` → `.` → `.` | `:g/pat/normal @a` |
| **Navigate** | `w`, `b`, `gg`, `G` | `s` (flash), `vif`, `f/t` | LSP `gd`/`gr`, marks, `S` treesitter |
| **Replace** | `cw`, `r` | `:%s/old/new/gc`, `<leader>cr` | `\v` regex, `:g` + `:s` combos |

## LazyVim-Specific Keys to Remember

| Key | What | Plugin |
|-----|------|--------|
| `s` | Flash jump | flash.nvim |
| `S` | Flash Treesitter select | flash.nvim |
| `gcc` | Toggle line comment | mini.comment |
| `gsa`/`gsd`/`gsr` | Add/Delete/Replace surround | mini.surround |
| `<leader>cr` | LSP rename | inc-rename.nvim |
| `<leader>sr` | Project search & replace | spectre.nvim / grug-far.nvim |
| `<leader>ss` | Search symbols in file | Telescope |
| `<leader>ff` | Find files | Telescope |
| `]d` / `[d` | Next/prev diagnostic | LSP |
| `]t` / `[t` | Next/prev TODO | todo-comments.nvim |

---

> *"The best code editor is the one you never have to leave."*
> *— Probably someone who uses Neovim and won't shut up about it.*

Happy Vimming! Now go forth and `:wq` your way to glory.
Or `:qa!` if things went really wrong. No judgment.
