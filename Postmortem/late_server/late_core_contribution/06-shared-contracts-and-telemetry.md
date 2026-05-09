# 06. Shared Contracts And Telemetry

`late-core` is where shared contracts often live.

Examples:
- shared API/data types
- telemetry initialization
- shutdown helpers
- rate-limiting utilities

Changes here can affect multiple crates at once.

If you touch `api_types.rs`, `telemetry.rs`, or shared DB/model contracts, think cross-crate, not crate-local.
