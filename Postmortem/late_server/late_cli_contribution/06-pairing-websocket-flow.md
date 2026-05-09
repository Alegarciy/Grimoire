# 06. Pairing WebSocket Flow

After token acquisition, the CLI connects to the pairing websocket.

It sends:
- `client_state`
- `viz`
- `heartbeat`

It receives:
- `toggle_mute`
- `volume_up`
- `volume_down`

If you change pairing behavior, inspect both:
- `late-cli/src/ws.rs`
- `late-ssh/src/session.rs` and related API handlers
