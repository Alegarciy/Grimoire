# 08. Common Pitfalls

- putting expensive work on the render path
- forgetting that some state is process-local only
- changing browser-facing behavior without checking `late-ssh` WS/API contracts
- missing local context docs for chat/rooms/artboard
- assuming a feature is purely DB-backed when it also has in-memory runtime state
- forgetting that `late-web` may only be the shell while `late-ssh` owns the real behavior
