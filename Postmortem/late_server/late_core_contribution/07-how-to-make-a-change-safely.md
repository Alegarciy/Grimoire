# 07. How To Make A Change Safely

Use this sequence:

1. identify the domain model or utility you need to change
2. inspect all likely consumers (`late-ssh`, `late-web`, tests)
3. decide whether the change is schema, query, or helper behavior
4. update model/query code carefully
5. if schema changes, make sure the migration boundary is respected
6. check whether context/docs should also be updated

Fast rule:

- durable shared truth -> `late-core`
