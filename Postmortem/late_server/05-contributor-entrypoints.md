# 05. Contributor Entrypoints

## If you want to add a new persisted feature

Start with:
- `late-core/src/models/`
- `late-core/src/db.rs`
- related migration definitions/build pipeline

Then move into:
- a `svc.rs` in `late-ssh`
- UI state/input/render modules in `late-ssh/src/app/`
- `late-web` pages if the feature has a browser/public face

## If you want to add a new SSH/TUI feature

Start with:
- `late-ssh/src/app/mod.rs`
- `late-ssh/src/app/state.rs`
- the nearest existing feature directory

Follow the house style:
- `state.rs`
- `input.rs`
- `ui.rs`
- `svc.rs` when async work exists

## If you want to add or modify chat behavior

Read first:
- `late-ssh/src/app/chat/CONTEXT.md`

Main code areas:
- `late-ssh/src/app/chat/`
- `late-core/src/models/chat_*`
- `late-core/src/models/notification.rs`

## If you want to add or modify room-based multiplayer

Read first:
- `late-ssh/src/app/rooms/CONTEXT.md`

Main code areas:
- `late-ssh/src/app/rooms/`
- `late-core/src/models/game_room.rs`
- `late-core/src/models/blackjack.rs`
- linked chat room models

## If you want to work on the Artboard

Read first:
- `late-ssh/src/app/artboard/CONTEXT.md`

Main code areas:
- `late-ssh/src/app/artboard/`
- `late-ssh/src/dartboard.rs`
- `late-core/src/models/artboard.rs`
- `late-web/src/pages/gallery/`

## If you want to improve the website

Read first:
- `late-web/CONTEXT.md`

Main code areas:
- `late-web/src/pages/`
- `late-web/src/lib.rs`
- `late-web/src/pages/shared/now_playing.rs`
- `late-web/src/pages/stream.rs`

## If you want to improve the CLI

Read first:
- `late-cli/CONTEXT.md`

Main code areas:
- `late-cli/src/main.rs`
- `late-cli/src/ssh.rs`
- `late-cli/src/ws.rs`
- `late-cli/src/audio/`

## If you want to add a new game

Look at existing examples:
- `late-ssh/src/app/games/twenty_forty_eight/`
- `late-ssh/src/app/games/tetris/`
- `late-ssh/src/app/games/sudoku/`
- `late-ssh/src/app/games/nonogram/`
- `late-ssh/src/app/games/minesweeper/`
- `late-ssh/src/app/games/solitaire/`

Typical moving parts:
- persistence model in `late-core`
- game state machine in `late-ssh`
- input handling
- rendering
- save/load service methods
- leaderboard/chips integration if relevant

## Recommended reading order for almost any contribution

1. `README.md`
2. `CONTEXT.md`
3. crate-level context doc for the area
4. top-level crate entrypoint (`main.rs`/`lib.rs`)
5. feature-specific module tree

## Fast rule of thumb

- if it is **persisted/shared domain truth** -> start in `late-core`
- if it is **live SSH app behavior** -> start in `late-ssh`
- if it is **public/browser page behavior** -> start in `late-web`
- if it is **local playback or SSH launch behavior** -> start in `late-cli`
