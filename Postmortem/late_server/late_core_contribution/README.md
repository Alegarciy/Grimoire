# late_core Contribution

Step-by-step contributor path for working in `late-core`.

## Steps

- [01-what-late-core-owns.md](01-what-late-core-owns.md)
- [02-what-to-read-first.md](02-what-to-read-first.md)
- [03-important-files.md](03-important-files.md)
- [04-models-and-db-patterns.md](04-models-and-db-patterns.md)
- [05-migrations-and-persistence-boundaries.md](05-migrations-and-persistence-boundaries.md)
- [06-shared-contracts-and-telemetry.md](06-shared-contracts-and-telemetry.md)
- [07-how-to-make-a-change-safely.md](07-how-to-make-a-change-safely.md)
- [08-common-pitfalls.md](08-common-pitfalls.md)
- [09-good-first-contributions.md](09-good-first-contributions.md)

## Fast summary

`late-core` is the shared foundation crate.

It owns:
- DB configuration and pooling
- migrations
- shared models and schema contracts
- shared utility modules
- telemetry bootstrap
- shared API/data types
- test DB helpers
