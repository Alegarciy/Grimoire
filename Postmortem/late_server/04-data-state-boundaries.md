# 04. Data and State Boundaries

## The central distinction

This repo only makes full sense if you separate:

- **durable data in Postgres**
- **live runtime state in `late-ssh` memory**

## 1. Durable data

Examples of data that survives restarts:

- users and SSH fingerprint identity
- roles/permissions stored on user records
- profile and theme/settings data
- chat rooms, memberships, and messages
- notifications and feed read checkpoints
- article/showcase/work profile data
- votes
- game saves and daily win tables
- chip balances
- bonsai trees and care logs
- room directory metadata
- artboard snapshots and provenance archives
- moderation and ban records

These are mostly represented under `late-core/src/models/`.

## 2. Live in-memory state

Examples of data that exists only while the process is running:

- `SessionRegistry` token routing
- `PairedClientRegistry` state/control routing
- active SSH app instances
- active user presence map
- activity broadcast feed
- service watch/broadcast channels
- browser visualizer frame buffers
- live room table state
- live artboard server state
- some background task state

These mostly live in `late-ssh`.

## 3. Why contributors need this mental model

When adding a feature, ask:

1. does this need to survive restart?
2. does this need to be shared across users?
3. is this the latest snapshot or just a transient event?
4. does this belong in DB, a watch channel, a broadcast channel, or a token registry?

## 4. Communication primitives used in the repo

### Database
Use for durable records and canonical history.

### `watch` channels
Use for latest-value snapshot state.

Examples:
- vote snapshot
- leaderboard snapshot
- per-user profile snapshot
- rooms snapshot

### `broadcast` channels
Use for transient fan-out events.

Examples:
- activity feed
- service success/failure events
- notification/event banners

### `mpsc`
Use for targeted point-to-point delivery.

Examples:
- routing pairing messages into one SSH session

## 5. Service pattern

A lot of features follow this shape:

- service owns DB access and/or task orchestration
- service exposes `watch` snapshot subscriptions and/or `broadcast` events
- per-session UI state subscribes on startup
- `tick()` drains those channels into plain local state
- render reads local state synchronously

This pattern is core to how the SSH UI stays responsive.

## 6. Multi-replica caution

Anything stored only in memory is a warning sign for horizontal scaling.

Especially important examples:
- session token registries
- paired client registries
- active user presence
- room game managers
- artboard live server

Those are process-local, not automatically cluster-shared.

## 7. Good feature-design questions

Before changing architecture, ask:

- Should this be the canonical truth in Postgres?
- Is it acceptable for this to reset on deploy/restart?
- Does another session need to subscribe to it live?
- Is this a per-user snapshot or a global snapshot?
- Is this a durable state transition or a transient UI event?
