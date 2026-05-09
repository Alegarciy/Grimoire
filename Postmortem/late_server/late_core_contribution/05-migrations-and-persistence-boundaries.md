# 05. Migrations And Persistence Boundaries

`late-core/src/db.rs` owns migration execution.

Important mental model:

- `late-core` defines durable persistence boundaries
- `late-ssh` often defines live in-memory runtime behavior on top of them

Before adding a field or table, ask:

- does this need to survive restart?
- is this canonical truth or just live session state?
- will other crates consume this contract?

If the answer is yes, it likely belongs in `late-core`.
