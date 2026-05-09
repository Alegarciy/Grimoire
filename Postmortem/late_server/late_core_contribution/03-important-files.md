# 03. Important Files

Key files:

- `late-core/src/lib.rs` — public module surface
- `late-core/src/db.rs` — DB config, pool creation, migrations
- `late-core/src/model.rs` — model macro utilities
- `late-core/src/models/` — persistent domain models
- `late-core/src/api_types.rs` — shared API types
- `late-core/src/nonogram.rs` — shared nonogram schema and helpers
- `late-core/src/rate_limit.rs` — rate limiting utility
- `late-core/src/telemetry.rs` — telemetry setup
- `late-core/src/shutdown.rs` — shared shutdown helpers
- `late-core/src/test_utils.rs` — integration-test DB helpers
