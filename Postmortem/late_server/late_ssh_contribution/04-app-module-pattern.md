# 04. App Module Pattern

Most `late-ssh` features follow a repeatable structure:

- `state.rs` — local UI state and transitions
- `input.rs` — key handling
- `ui.rs` — render logic
- `svc.rs` — async service work

You can see this in:

- `chat/`
- `vote/`
- `profile/`
- many `games/*`
- `rooms/blackjack/`
- `artboard/`

When adding a new feature, following this pattern keeps the codebase consistent.
