# 06. DB-Backed Pages Vs Realtime Pages

There are two broad kinds of `late-web` pages.

## DB-backed public pages

Examples:
- `/gallery`
- `/profiles`

These read persisted data through `late-core` models and DB access.

## Realtime bridge pages

Examples:
- pairing page
- browser chat page
- browser play/tunnel page

These are served by `late-web`, but much of the live behavior comes from websocket/API calls into `late-ssh`.

Before changing a page, decide which category it belongs to.
