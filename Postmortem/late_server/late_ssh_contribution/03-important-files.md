# 03. Important Files

Top-level files you should know:

- `late-ssh/src/main.rs` — process bootstrap and service wiring
- `late-ssh/src/ssh.rs` — SSH server and render loop
- `late-ssh/src/api.rs` — HTTP/WebSocket API
- `late-ssh/src/state.rs` — shared runtime state
- `late-ssh/src/session.rs` — session token routing and paired client registry
- `late-ssh/src/dartboard.rs` — shared artboard runtime/persistence bridge
- `late-ssh/src/web.rs` — browser chat support
- `late-ssh/src/web_tunnel.rs` — browser terminal tunnel support

Core app files:

- `late-ssh/src/app/state.rs`
- `late-ssh/src/app/input.rs`
- `late-ssh/src/app/tick.rs`
- `late-ssh/src/app/render.rs`
- `late-ssh/src/app/mod.rs`
