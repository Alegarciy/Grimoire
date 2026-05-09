# 07. How To Make A Change Safely

Use this sequence:

1. identify the feature directory in `late-ssh/src/app/`
2. identify whether persistence also lives in `late-core`
3. inspect the feature's `svc.rs`
4. inspect its `state.rs`
5. inspect its `input.rs` and `ui.rs`
6. check whether browser or CLI pairing is affected
7. check for a local `CONTEXT.md`

Fast ownership rule:

- persisted domain truth -> usually starts in `late-core`
- live SSH behavior -> usually starts in `late-ssh`
