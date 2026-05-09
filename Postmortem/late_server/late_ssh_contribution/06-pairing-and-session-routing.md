# 06. Pairing And Session Routing

Two important runtime pieces live in `late-ssh/src/session.rs`.

## `SessionRegistry`

Maps:
- `token -> session sender`

Used for routing messages into a specific SSH session.

Examples:
- visualizer frames
- heartbeats
- targeted session events

## `PairedClientRegistry`

Maps:
- `token -> paired client control sender + latest audio state`

Used for routing control messages out to the current browser/CLI client.

Examples:
- mute toggle
- volume up/down

If you touch pairing, visualizer behavior, or remote audio controls, read `session.rs` first.
