# late_ssh Contribution

Step-by-step contributor path for working in `late-ssh`.

## Steps

- [01-what-late-ssh-owns.md](01-what-late-ssh-owns.md)
- [02-what-to-read-first.md](02-what-to-read-first.md)
- [03-important-files.md](03-important-files.md)
- [04-app-module-pattern.md](04-app-module-pattern.md)
- [05-how-state-and-services-work.md](05-how-state-and-services-work.md)
- [06-pairing-and-session-routing.md](06-pairing-and-session-routing.md)
- [07-how-to-make-a-change-safely.md](07-how-to-make-a-change-safely.md)
- [08-common-pitfalls.md](08-common-pitfalls.md)
- [09-good-first-contributions.md](09-good-first-contributions.md)

## Fast summary

`late-ssh` is the main live runtime of `late.sh`.

It owns:
- SSH sessions
- the TUI app
- most live feature services
- session/pairing routing
- multiplayer/runtime memory state
- the HTTP API used by browser/CLI integrations
