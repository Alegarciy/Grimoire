# 01. What `late-cli` Owns

`late-cli` is the local companion client.

It owns:

- SSH launch behavior
- local key/identity handling
- SSH mode selection (`native`, `openssh`, `old`)
- local audio playback
- audio decoding/resampling/output
- analyzer/visualizer frame production
- pairing websocket client behavior

It does not own the backend session runtime; it connects to and cooperates with `late-ssh`.
