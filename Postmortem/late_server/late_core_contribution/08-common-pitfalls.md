# 08. Common Pitfalls

- making a persistence change without checking all consumers
- confusing durable DB state with live runtime state
- changing ordering/filtering assumptions silently
- forgetting that model/API changes can impact both `late-ssh` and `late-web`
- treating shared utility code like it is crate-local only
