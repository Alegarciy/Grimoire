# Postmortem: Pyright noise in LazyVim

Date: 2026-05-01

## Summary
A recurring Pyright-related message appeared in Neovim during editing/saving. Initial suspicion was diagnostics or format-on-save behavior. Root cause was Noice displaying LSP progress messages, not Pyright diagnostic virtual text.

## Symptoms
- Pyright message kept appearing repeatedly
- It seemed tied to save at first
- User later clarified it was happening while typing as well

## Investigation
Checked user config in `~/.config/nvim`:
- `lua/plugins/python.lua` only configured Pyright `pythonPath`
- `lua/config/autocmds.lua` had no custom diagnostic popup hooks
- No custom `vim.diagnostic.open_float()` on save

Checked LazyVim defaults in installed plugins:
- LazyVim enables format on save via `BufWritePre`
- LazyVim enables diagnostic virtual text by default
- LazyVim includes Noice UI integration
- Noice enables `lsp.progress` by default

## False lead
Disabled diagnostic virtual text with:
- `~/.config/nvim/lua/plugins/lsp.lua`

This did not solve the issue, which confirmed the visible message was not inline diagnostics.

## Root cause
`folke/noice.nvim` was showing LSP progress updates from Pyright (background checking/progress notifications).

## Fix
Added LazyVim override:

File:
- `~/.config/nvim/lua/plugins/noice.lua`

```lua
return {
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
      },
    },
  },
}
```

## Outcome
- Format on save remains enabled
- Pyright remains enabled
- Noice LSP progress/checking noise is suppressed

## Lesson learned
When a message appears repeatedly in LazyVim, distinguish between:
- diagnostics
- formatting side effects
- linting
- LSP progress UI from Noice

Typing-frequency messages are a strong clue that the source is progress/status UI rather than save-only formatting or diagnostic virtual text.
