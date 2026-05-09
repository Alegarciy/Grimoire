# late_web Contribution

Step-by-step contributor path for working in `late-web`.

## Steps

- [01-what-late-web-owns.md](01-what-late-web-owns.md)
- [02-what-to-read-first.md](02-what-to-read-first.md)
- [03-important-files.md](03-important-files.md)
- [04-route-and-page-structure.md](04-route-and-page-structure.md)
- [05-how-late-web-connects-to-late-ssh.md](05-how-late-web-connects-to-late-ssh.md)
- [06-db-backed-pages-vs-realtime-pages.md](06-db-backed-pages-vs-realtime-pages.md)
- [07-how-to-make-a-change-safely.md](07-how-to-make-a-change-safely.md)
- [08-common-pitfalls.md](08-common-pitfalls.md)
- [09-good-first-contributions.md](09-good-first-contributions.md)

## Fast summary

`late-web` is the browser/public shell of `late.sh`.

It owns:
- public pages
- pairing page HTML/JS
- browser chat page shell
- browser TUI demo shell
- profiles pages
- gallery page
- `/stream` proxy

It often renders the page, while `late-ssh` owns the realtime protocol/state behind it.
