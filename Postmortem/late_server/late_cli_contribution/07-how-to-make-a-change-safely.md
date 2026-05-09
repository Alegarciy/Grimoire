# 07. How To Make A Change Safely

Use this sequence:

1. identify whether the change is in SSH, audio, websocket, or config behavior
2. inspect the matching file/module first
3. check `late-cli/CONTEXT.md` for invariants
4. verify whether the change affects server contracts in `late-ssh`
5. keep platform-specific behavior in mind (WSL, Android, OpenSSH mode)

Fast rule:

- local client behavior -> `late-cli`
- session/pairing backend contract -> also `late-ssh`
