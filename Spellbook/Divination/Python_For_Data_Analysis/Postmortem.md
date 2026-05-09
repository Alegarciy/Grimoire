# Postmortem

## Neovim linter not resolving `numpy`

### Symptom
- `uv run 4.0.py` worked
- Neovim linter/LSP still reported the import as unresolved

### Cause
- The Python environment used by Neovim's linter/LSP was not the same environment used by `uv run`
- The desired virtual environment lives in:
  - `/home/gandalf/Documents/Chamber_of_Scretes/Intro_ML/.venv`

### Fix
Created `pyrightconfig.json` in this project:
- `/home/gandalf/Documents/Grimoire/Spellbook/Divination/Python_For_Data_Analysis/pyrightconfig.json`

Contents:

```json
{
  "include": ["."],
  "venvPath": "/home/gandalf/Documents/Chamber_of_Scretes/Intro_ML",
  "venv": ".venv"
}
```

### Follow-up
- Restart Neovim LSP with `:LspRestart`
- If diagnostics persist, inspect `:LspInfo` and the exact diagnostic source/message
