# 04. Route And Page Structure

`late-web` is organized mostly by page owner.

Common pattern:

- `mod.rs` — route handlers and template structs
- `*.html` — Askama templates

Main route families:

- `connect/` — `/`, `/{token}`, `/status`
- `chat/` — `/chat/{token}`
- `play/` — `/play`
- `gallery/` — `/gallery`
- `profiles/` — `/profiles`, `/profiles/{slug}`
- `stream.rs` — `/stream`

When adding a page, you usually touch both route wiring and an Askama template.
