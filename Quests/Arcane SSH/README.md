# 🧙‍♂️ The Arcane Study of `late-ssh`

A wizard academy research quest for understanding how a single Rust application can act as an SSH server, HTTP server, WebSocket server, terminal UI runtime, and shared application-state engine.

---

## Table of Contents

- [Campaign Premise](#campaign-premise)
- [Character Sheet](#character-sheet)
- [Main Campaign: The Tower of Many Doors](#main-campaign-the-tower-of-many-doors)
- [Chapter I — The Candle of Concurrency](#chapter-i--the-candle-of-concurrency)
- [Chapter II — The False Door of SSH](#chapter-ii--the-false-door-of-ssh)
- [Chapter III — The Rune Screen](#chapter-iii--the-rune-screen)
- [Chapter IV — The Crystal of Shared State](#chapter-iv--the-crystal-of-shared-state)
- [Chapter V — The Familiar Bridge](#chapter-v--the-familiar-bridge)
- [Chapter VI — The Session Familiar Registry](#chapter-vi--the-session-familiar-registry)
- [Final Boss — The B[[RESEARCH]]alrog of Abstraction](#final-boss--the-balrog-of-abstraction)
- [Tomorrow Morning Quest Log Template](#tomorrow-morning-quest-log-template)
- [Recommended First Quest Tomorrow](#recommended-first-quest-tomorrow)

---

## Campaign Premise

You are an apprentice systems wizard studying an ancient machine-spell called:

```text
late-ssh
```

At first, villagers think it is merely an SSH daemon.

But the old scrolls reveal the truth:

```text
late-ssh is not a door into the kingdom.
late-ssh is the kingdom pretending to be a door.
```

It speaks SSH to terminal travelers, HTTP to browser messengers, and WebSocket to real-time familiars.

Your mission is to understand how this arcane engine works.

---

## Character Sheet

### Class

```text
Async Systems Wizard
```

### Main Stats

```text
INT  — Understanding protocols
WIS  — Knowing what abstraction matters
DEX  — Navigating Rust docs
CON  — Surviving confusing async examples
CHA  — Explaining the architecture clearly
```

### Inventory[[Quests/Arcane SSH/LOGS]]

```text
Tokio spellbook
russh grimoire
axum scrolls
Ratatui runes
ANSI escape glyphs
Arc<Mutex<T>> amulet
Tokio channel pouch
```

---

## Main Campaign: The Tower of Many Doors

### Final Objective

Understand how one Rust application can become:

```text
an SSH server
an HTTP server
a WebSocket server
a terminal UI runtime
a shared application-state engine
```

### Ancient Diagram

```text
                 ┌────────────────────────┐
SSH traveler ───▶│ Gate of Secure Shell   │
                 │ custom SSH listener    │
                 └───────────┬────────────┘
                             │
                             ▼
                 ┌────────────────────────┐
                 │ The Shared Arcane Core │
                 │ rooms, chat, sessions  │
                 │ pairing, games, state  │
                 └───────────┬────────────┘
                             ▲
                             │
Browser familiar ───────────▶│
HTTP/WebSocket portal
```

---

## Chapter I — The Candle of Concurrency

### Quest Name

**The One Process with Many Doors**

### Lore

A novice believes one program can guard only one gate.

A wizard knows a single tower can have many doors, each watched by a different summoned task.

### Research Spells

Study:

```text
Tokio runtime
tokio::spawn
async functions
TcpListener
joining tasks
```

### Question to Answer in Your Grimoire

```text
How can one Rust binary listen on both an SSH port and an HTTP port?
```

### Victory Condition

You can explain this:

```text
late-ssh is one Rust process running multiple async server loops.
```

### XP

```text
+100 Arcane XP
```

### Loot

```text
Spell unlocked: tokio::spawn
```

---

## Chapter II — The False Door of SSH

### Quest Name

**The Gate That Does Not Lead to Bash**

### Lore

Many travelers believe SSH always opens a shell.

But SSH is only the ritual of entrance.

After the ritual, the gatekeeper decides what realm the traveler sees.

OpenSSH says:

```text
Enter the shell.
```

A custom Rust SSH server may say:

```text
Enter my terminal application.
```

### Research Spells

Study:

```text
SSH protocol
SSH channels
authentication
PTY request
shell request
session channel
```

### Question to Answer

```text
At what point does an SSH server decide whether to spawn bash or run its own app?
```

### Victory Condition

You can explain:

```text
SSH is the transport.
The shell is just one possible thing the server can start.
```

### XP

```text
+150 Arcane XP
```

### Loot

```text
Spell unlocked: shell_request != actual_shell
```

---

## Chapter III — The Rune Screen

### Quest Name

**The Terminal Is a Spell Canvas**

### Lore

The terminal is not a dumb black box.

It is a rune surface.

When you write special glyphs to it, it clears, moves the cursor, hides the cursor, draws boxes, and pretends to be an interface.

### Research Spells

Study:

```text
ANSI escape codes
terminal raw mode
PTY
alternate screen
Ratatui rendering model
```

### Important Runes

```text
\x1b[2J     clear screen
\x1b[H      move cursor home
\x1b[?25l   hide cursor
\x1b[?25h   show cursor
```

### Question to Answer

```text
What does a TUI actually send to the terminal?
```

### Victory Condition

You can explain:

```text
A TUI is text plus escape sequences.
If the SSH server can write bytes to the SSH channel,
it can render a terminal app.
```

### XP

```text
+200 Arcane XP
```

### Loot

```text
Item found: ANSI Wand
```

---

## Chapter IV — The Crystal of Shared State

### Quest Name

**The Core That Remembers All Sessions**

### Lore

The SSH traveler and the browser familiar appear through different portals.

But both must speak to the same crystal.

That crystal remembers:

```text
who is connected
who is paired
which room exists
which messages were sent
which game is active
```

### Research Spells

Study:

```text
Arc
Mutex
RwLock
HashMap
Tokio mpsc channels
Tokio broadcast channels
session registries
```

### Question to Answer

```text
How does the browser know which SSH session it belongs to?
```

### Mental Model

```text
pairing_code       -> ssh_session_id
browser_session_id -> ssh_session_id
ssh_session_id     -> browser_session_id
```

### Victory Condition

You can explain:

```text
The SSH side and WebSocket side are different adapters over the same app state.
```

### XP

```text
+250 Arcane XP
```

### Loot

```text
Item found: Arc<Mutex<AppState>> Amulet
```

---

## Chapter V — The Familiar Bridge

### Quest Name

**The WebSocket Familiar Carries Messages**

### Lore

The browser familiar does not knock once and leave.

It keeps a magical thread open.

Through this thread, messages fly both ways.

### Research Spells

Study:

```text
axum Router
State extractor
WebSocketUpgrade
WebSocket message loop
tokio::select!
mpsc sender/receiver
```

### Question to Answer

```text
How does a browser message reach the SSH terminal session?
```

### Victory Condition

You can explain this flow:

```text
browser sends WebSocket message
→ axum receives it
→ registry finds paired SSH session
→ message goes through a channel
→ SSH task writes it into the terminal
```

### XP

```text
+300 Arcane XP
```

### Loot

```text
Spell unlocked: WebSocket Bridge
```

---

## Chapter VI — The Session Familiar Registry

### Quest Name

**The Hall of Names**

### Lore

Every traveler receives a name.

Every familiar receives a name.

Every pairing code is a temporary rune binding one to the other.

The registry is the hall where these names are recorded.

### Research Targets

```text
HashMap<String, SessionHandle>
HashMap<String, PairingCode>
HashMap<SshSessionId, BrowserSessionId>
HashMap<BrowserSessionId, SshSessionId>
```

### Question to Answer

```text
What data structures would let me pair one browser with one SSH session?
```

### Victory Condition

You can sketch:

```text
SSH session starts
→ creates pairing code
→ browser submits code
→ registry links both sessions
→ code is consumed
```

### XP

```text
+200 Arcane XP
```

### Loot

```text
Item found: Pairing Rune
```

---

## Final Boss — The Balrog of Abstraction

### Boss Name

**But Is It SSH or Is It an App?**

### Boss Attack

The Balrog whispers:

```text
SSH means shell access.
HTTP means web app.
TUI means local terminal.
These things cannot be one creature.
```

### Counterspell

You answer:

```text
SSH, HTTP, and WebSocket are just protocols.

late-ssh is the application core.

SSH is one adapter.
HTTP is another adapter.
WebSocket is another adapter.

The app state lives behind them.
```

### Final Diagram Spell

```text
                           ┌─────────────────────┐
Terminal user ── SSH ─────▶│ SSH Adapter         │
                           │ russh session task  │
                           └──────────┬──────────┘
                                      │
                                      ▼
                           ┌─────────────────────┐
                           │ Application Core    │
                           │ chat, rooms, games  │
                           │ pairing, profiles   │
                           └──────────┬──────────┘
                                      ▲
                                      │
Browser user ── HTTP/WS ─────────────▶│
                           ┌──────────┴──────────┐
                           │ HTTP/WebSocket      │
                           │ axum adapter        │
                           └─────────────────────┘
```

### Victory Condition

You can explain `late-ssh` without saying:

```text
magic
black box
normal SSH
```

### Reward

```text
+500 Arcane XP
Title unlocked: Protocol Conjurer
```

---

## Tomorrow Morning Quest Log Template

````markdown
# 🧙 late-ssh Wizard Research Log

## Character
Class: Async Systems Wizard
Current level:

## Quest attempted
Chapter:

## Scrolls consulted
- 

## Spell learned
Today I understood that:

## Diagram from memory

```text

```

## Enemy encountered

The confusing part was:

## Current hypothesis

I think late-ssh works like this:

## Next spell to study

Tomorrow / next session I should research:
````

---

## Recommended First Quest Tomorrow

Start with **Chapter II — The False Door of SSH**.

Your first boss question should be:

```text
When an SSH client asks for a shell, where does a custom Rust SSH server intercept that request and decide to run an app instead?
```

That is the **You shall not pass... to Bash** moment.
