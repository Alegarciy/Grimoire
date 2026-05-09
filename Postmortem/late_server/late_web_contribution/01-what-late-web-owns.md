# 01. What `late-web` Owns

`late-web` is the public browser-facing frontend.

It owns:

- landing page
- pairing page shell
- browser chat page shell
- browser TUI demo page shell
- profiles pages
- artboard gallery page
- `/stream` proxy
- some HTMX fragments and public presentation logic

It usually does **not** own the main live session runtime. For realtime browser behavior, it often connects back to `late-ssh`.
