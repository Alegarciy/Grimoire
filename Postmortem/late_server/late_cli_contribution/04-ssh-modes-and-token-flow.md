# 04. SSH Modes And Token Flow

`late-cli` supports three transport modes:

- `native`
- `openssh`
- `old`

Important idea:

- the CLI must get a session token from the server
- that token is then used for pairing over websocket

If you change SSH launch logic, understand:

- how the token is fetched
- when stdin/raw mode is owned by the CLI vs OpenSSH
- which mode supports which auth flow

This is one of the highest-risk parts of the CLI.
