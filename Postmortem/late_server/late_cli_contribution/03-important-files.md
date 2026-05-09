# 03. Important Files

Key files:

- `late-cli/src/main.rs` — top-level orchestration
- `late-cli/src/config.rs` — flags, env vars, defaults, logging
- `late-cli/src/identity.rs` — identity discovery/generation
- `late-cli/src/ssh.rs` — SSH transport modes and token fetch flow
- `late-cli/src/ws.rs` — pairing websocket client behavior
- `late-cli/src/raw_mode.rs` — terminal raw mode handling
- `late-cli/src/pty.rs` — terminal size helpers
- `late-cli/src/audio/decoder.rs` — stream decoding
- `late-cli/src/audio/output.rs` — audio output runtime
- `late-cli/src/audio/resampler.rs` — sample-rate adaptation
- `late-cli/src/audio/analyzer.rs` — visualizer data generation
