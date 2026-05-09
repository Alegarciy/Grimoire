# 09. Good First Contributions

Safer early contribution targets:

- UI polish in existing screens
- small state/input cleanup in one feature module
- focused service fixes in chat/profile/vote
- docs/context improvements
- small browser/CLI consistency fixes that do not change core protocol shapes

Higher-risk areas:

- `late-ssh/src/ssh.rs`
- session registries
- room game managers
- live artboard runtime behavior
- cross-cutting protocol changes

If you're new to the repo, start with a focused feature subtree before touching the render loop or shared registries.
