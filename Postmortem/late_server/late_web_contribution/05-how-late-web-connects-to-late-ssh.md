# 05. How `late-web` Connects To `late-ssh`

A lot of browser functionality is delegated to `late-ssh`.

Examples:

- pairing page -> `late-ssh /api/ws/pair`
- browser chat -> `late-ssh` chat websocket
- browser TUI demo -> `late-ssh` tunnel websocket
- now playing/status fragments -> `late-ssh /api/now-playing`

Important mental model:

- `late-web` often owns the browser page shell
- `late-ssh` often owns the realtime state/protocol behind it

If a page feels "web-only," verify whether it also depends on an SSH-side contract.
