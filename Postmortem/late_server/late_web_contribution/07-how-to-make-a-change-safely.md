# 07. How To Make A Change Safely

Use this sequence:

1. identify the page/route owner under `late-web/src/pages/`
2. inspect its handler code and template
3. check whether it is DB-backed or realtime-backed
4. if realtime-backed, inspect the matching `late-ssh` contract
5. if DB-backed, inspect the relevant `late-core` model(s)
6. verify config/env assumptions if URLs or routing behavior change

Fast rule:

- page rendering/layout -> `late-web`
- realtime session protocol -> probably `late-ssh`
- persistent data schema -> `late-core`
