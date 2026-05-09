# 01. What `late-ssh` Owns

`late-ssh` is the main application runtime.

It owns:

- the SSH server
- per-session TUI app creation
- the render/input/tick loop
- the pairing API
- browser real-time integrations
- most domain services
- active session registries
- presence/activity state
- live room game runtime state
- live artboard runtime state

If you are changing the actual product experience after a user connects over SSH, you are probably working in `late-ssh`.
