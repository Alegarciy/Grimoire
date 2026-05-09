# 04. Models And DB Patterns

`late-core/src/models/` is the persistent domain map of the project.

Typical work here includes:

- defining model methods
- shaping query behavior
- enforcing persistence invariants
- representing table-backed entities

When changing a domain model, consider:
- who reads it (`late-ssh`, `late-web`, tests)
- whether query shape or ordering assumptions exist
- whether a schema change is also required
