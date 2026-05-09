# 05. How State And Services Work

A core design rule in `late-ssh` is:

- keep rendering synchronous
- keep business logic asynchronous

Typical flow:

1. a service does DB/network/background work
2. it publishes updates through `watch` or `broadcast`
3. app/UI state drains those updates in `tick()`
4. `render()` reads already-local state only

Why this matters:

- the SSH UI stays responsive
- paint logic stays simple
- service work can happen off the hot path

Contributor rule:

> Do not put blocking DB or network work into render code.
