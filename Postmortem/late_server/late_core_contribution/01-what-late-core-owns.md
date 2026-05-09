# 01. What `late-core` Owns

`late-core` is the shared foundation crate.

It owns:

- DB config and pooling
- migrations
- shared persistence models
- shared schema contracts
- shared utility modules
- telemetry bootstrap
- rate limiting utilities
- shared nonogram contracts
- test DB helpers

If a change affects durable data or a cross-crate contract, it often starts in `late-core`.
