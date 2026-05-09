# Grimoire Postmotem

Architecture notes for contributors exploring `late.sh`.

## Documents

- [late_server/01-system-overview.md](late_server/01-system-overview.md) — big-picture architecture and deployment shape
- [late_server/02-crate-breakdown.md](late_server/02-crate-breakdown.md) — what each Rust crate owns
- [late_server/03-runtime-flows.md](late_server/03-runtime-flows.md) — SSH, pairing, web, and audio/runtime flows
- [late_server/04-data-state-boundaries.md](late_server/04-data-state-boundaries.md) — persistent vs in-memory state and service contracts
- [late_server/05-contributor-entrypoints.md](late_server/05-contributor-entrypoints.md) — where to start depending on what you want to build
- [late_server/06-risk-hotspots.md](late_server/06-risk-hotspots.md) — architectural risks, tradeoffs, and sharp edges
- [late_server/00-full-architecture-breakdown.md](late_server/00-full-architecture-breakdown.md) — original full single-file architecture breakdown
- [late_server/late_ssh_contribution.md](late_server/late_ssh_contribution.md) — focused contributor guide for `late-ssh`

## Fast mental model

`late.sh` is a terminal-first social app where:

- `late-core` provides shared persistence/infrastructure
- `late-ssh` is the main live application runtime
- `late-web` is the public/browser-facing shell
- `late-cli` is the local audio + pairing companion

The most important distinction in the system is:

> PostgreSQL stores durable history, while `late-ssh` owns most live session state in memory.
