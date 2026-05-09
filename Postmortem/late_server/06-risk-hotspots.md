# 06. Risk Hotspots

## 1. `late-ssh` is the system nexus

This crate owns a lot:
- SSH
- API
- session routing
- app state
- feature services
- background loops

That makes it productive to work in, but also easy to introduce cross-cutting regressions.

## 2. Single-process assumptions

Several important systems are process-local:

- session token registry
- paired client registry
- active presence map
- live room managers
- live artboard server

These are fine for the current architecture, but they are scaling constraints.

## 3. Persistent-vs-live boundary confusion

Some features are hybrids.

Examples:
- room metadata persists, active table logic does not
- artboard snapshots persist, live board state does not
- chat history persists, unread/event state may also have transient layers

When editing these systems, be explicit about which layer you are changing.

## 4. TUI responsiveness hazards

The render model depends on keeping paint synchronous and short.

Risky changes include:
- blocking DB calls in render paths
- heavy work inside input handlers
- introducing lock contention around the app state
- expanding per-frame allocations unnecessarily

## 5. Browser ownership can be misleading

A page being served by `late-web` does not mean `late-web` owns the real feature logic.

Often:
- `late-web` owns HTML/template shell
- `late-ssh` owns real-time protocol and state

## 6. Audio control is split across components

The audio system spans multiple layers:
- vote state in `late-ssh`
- playback infra in Liquidsoap/Icecast
- playback client in browser or CLI
- visualizer data returned to `late-ssh`

So audio bugs are often cross-component bugs.

## 7. Local context docs matter

Some subdomains are too detailed to understand from top-level files alone.

Especially:
- chat
- rooms / blackjack
- artboard
- CLI
- web

Read the local `CONTEXT.md` before making big changes in those areas.

## 8. Safe contributor strategy

When changing a feature:

1. identify the owning crate
2. identify the persistent model, if any
3. identify the live runtime/service layer
4. identify whether the feature has browser and/or CLI surfaces too
5. make sure you are not accidentally breaking a cross-surface contract
