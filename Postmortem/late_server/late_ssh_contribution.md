# late_ssh Contribution Guide

This note is a focused contributor guide for the `late-ssh` crate, which is the main live runtime of `late.sh`.

## What `late-ssh` owns

`late-ssh` is the biggest architectural center of the project. It owns:

- the SSH server
- the terminal UI app
- the per-session render/input/tick loop
- the HTTP API used for pairing and browser integrations
- most domain services
- active session registries
- live multiplayer/runtime state
- presence/activity tracking

If you are contributing to the core app experience, you will probably touch `late-ssh`.

---

## Start reading here

Recommended order:

1. `README.md`
2. `CONTEXT.md`
3. `late-ssh/src/main.rs`
4. `late-ssh/src/state.rs`
5. `late-ssh/src/app/state.rs`
6. the feature subtree you want to change

Also read local context docs when relevant:

- `late-ssh/src/app/chat/CONTEXT.md`
- `late-ssh/src/app/rooms/CONTEXT.md`
- `late-ssh/src/app/artboard/CONTEXT.md`

---

## Important top-level files

- `late-ssh/src/main.rs` — process bootstrap, shared service wiring, background tasks
- `late-ssh/src/ssh.rs` — SSH session handling and render loop
- `late-ssh/src/api.rs` — HTTP/WebSocket API
- `late-ssh/src/state.rs` — shared global runtime state
- `late-ssh/src/session.rs` — session token routing and paired client registry
- `late-ssh/src/dartboard.rs` — shared artboard runtime/persistence wrapper
- `late-ssh/src/web.rs` — browser chat registry support
- `late-ssh/src/web_tunnel.rs` — browser terminal tunnel support

---

## App module layout

Inside `late-ssh/src/app/`, most features follow a predictable shape:

- `state.rs` — local UI state and transitions
- `input.rs` — key handling
- `ui.rs` — rendering
- `svc.rs` — async service work

You can see this pattern in:

- `chat/`
- `vote/`
- `profile/`
- many `games/*`
- `rooms/blackjack/`
- `artboard/`

When adding a new feature, following this structure will make your contribution fit the codebase naturally.

---

## Mental model: sync UI, async services

A key design rule in `late-ssh` is:

- rendering should stay synchronous and fast
- DB/network/business logic should stay async and off the hot render path

Typical flow:

1. a service performs async work
2. it publishes updates through `watch` or `broadcast`
3. app state drains those updates during `tick()`
4. render reads already-local state only

### Contributor rule
Do **not** put blocking DB or network work into render logic.

---

## Where feature state lives

### Persistent state
Usually in Postgres through `late-core` models.

Examples:
- chat messages
- room metadata
- votes
- game saves
- profiles
- artboard snapshots

### Live state
Usually in `late-ssh` memory.

Examples:
- active sessions
- session token routing
- paired client state
- activity feed
- live room tables
- live artboard runtime

Before changing a feature, ask whether you are changing:
- durable truth
- live runtime behavior
- or both

---

## High-impact directories

### `late-ssh/src/app/chat/`
Use for:
- room/message UX
- notifications
- feed behavior
- browser chat-related integration

### `late-ssh/src/app/games/`
Use for:
- single-player game logic
- save/load behavior
- leaderboard/chips integration

### `late-ssh/src/app/rooms/`
Use for:
- multiplayer room directory
- room creation/filtering
- room-based games like Blackjack

### `late-ssh/src/app/artboard/`
Use for:
- shared ASCII board behavior
- editing/view modes
- provenance/snapshot interactions

### `late-ssh/src/app/vote/`
Use for:
- music voting
- Liquidsoap control integration

### `late-ssh/src/app/profile/`
Use for:
- user settings
- profile editing
- theme/user preference surfaces

---

## Pairing architecture you should understand

`late-ssh` bridges the SSH session with browser/CLI clients using session tokens.

### `SessionRegistry`
Routes messages into a specific SSH session.

### `PairedClientRegistry`
Routes control messages to the currently paired browser/CLI client and stores latest client audio state.

If you touch:
- visualizer behavior
- mute/volume controls
- browser pairing
- CLI pairing

then read `late-ssh/src/session.rs` first.

---

## Safe contribution workflow

When changing `late-ssh`, a good sequence is:

1. identify the feature owner directory
2. identify whether persistence lives in `late-core`
3. inspect the service layer for async entrypoints
4. inspect `state.rs` for local UI state
5. inspect `input.rs` and `ui.rs`
6. check whether browser/CLI pairing is also affected

---

## Common pitfalls

- putting expensive work on the render path
- changing in-memory runtime state without considering restart behavior
- assuming `late-web` owns a browser feature when `late-ssh` owns the protocol/state
- forgetting a feature may also affect pairing, rooms, or activity feed behavior
- missing a local `CONTEXT.md` with invariants for a subsystem

---

## Best contribution targets for a first pass

Good first areas:

- UI polish in existing screens
- pure state/input cleanup in a focused feature module
- small service fixes in chat/profile/vote
- web/pairing copy or UX consistency changes that map to existing contracts
- docs/context improvements where behavior is already clear in code

Higher-risk areas:

- `ssh.rs` render loop changes
- session/pairing registries
- room game managers
- artboard live runtime behavior
- cross-cutting chat/protocol changes

---

## Bottom line

If `late-core` is the persistent foundation, `late-ssh` is the living organism of the app.

Contributing successfully here usually means understanding:

- which state is durable
- which state is live and process-local
- how async services feed sync UI
- which other surfaces depend on the same runtime contracts
