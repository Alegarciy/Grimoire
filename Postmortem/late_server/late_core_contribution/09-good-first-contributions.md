# 09. Good First Contributions

Safer early contribution targets:

- small model/query cleanups
- shared utility improvements
- docs/context improvements around persistence contracts
- telemetry or helper polish with limited surface area

Higher-risk areas:

- schema shape changes
- broad model/API contract changes
- anything used by multiple crates with hidden assumptions

Start with a focused domain model or helper before changing broad cross-crate contracts.
