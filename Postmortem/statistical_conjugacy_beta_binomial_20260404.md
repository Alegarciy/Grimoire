# Statistical Conjugacy — Why the Denominator Becomes a Gamma Fraction

## Status
🔮 **Unexplored territory** — the derivation below is understood, but the deeper magic of conjugacy (why certain distribution families are closed under Bayesian updating, the exponential family connection, natural parameters) remains uncharted.

---

## The Core Derivation

Starting from Bayes' theorem applied to a Binomial likelihood with a Jeffreys prior `Beta(½, ½)`:

**Step 1 — Bayes' theorem:**

$$p(\theta \mid m, n) = \frac{\overbrace{\text{Binom}(m \mid \theta, n)}^{\text{likelihood}} \cdot \overbrace{\text{Beta}(\theta \mid \frac{1}{2}, \frac{1}{2})}^{\text{prior}}}{\underbrace{\int_0^1 \text{Binom}(m \mid \theta', n) \cdot \text{Beta}(\theta' \mid \frac{1}{2}, \frac{1}{2})\, d\theta'}_{\text{normalizing constant}}}$$

**Step 2 — Extract the kernel (drop constants that don't depend on θ):**

$$\text{Binom} \cdot \text{Beta} \propto \theta^{m - \frac{1}{2}}(1-\theta)^{n - m - \frac{1}{2}}$$

**Step 3 — Recognise the Beta distribution shape:**

$$\theta^{a-1}(1-\theta)^{b-1} \quad \text{with} \quad a = m + \tfrac{1}{2}, \quad b = n - m + \tfrac{1}{2}$$

**Step 4 — The denominator IS the Beta normalizing constant:**

$$\int_0^1 \theta^{a-1}(1-\theta)^{b-1}\, d\theta = B(a,b) = \frac{\Gamma(a)\,\Gamma(b)}{\Gamma(a+b)}$$

**Step 5 — Final posterior:**

$$p(\theta \mid m, n) = \frac{\Gamma(n+1)}{\Gamma\!\left(\tfrac{1}{2}+m\right)\,\Gamma\!\left(\tfrac{1}{2}+n-m\right)}\;\theta^{\frac{1}{2}+m-1}(1-\theta)^{\frac{1}{2}+n-m-1} = \text{Beta}(\theta \mid a, b)$$

---

## Why This Works — Conjugacy

The reason the integral has a clean closed form instead of needing numerical computation is **conjugacy**: the Beta prior and the Binomial likelihood share the same kernel shape in θ. Their product is again a Beta kernel, so the integral is just a known Beta normalizing constant — which itself is a ratio of Gamma functions via the Beta function identity.

> **The prior and posterior live in the same distributional family.** Observing data just updates the parameters `(α, β) → (α + m, β + n − m)`.

---

## What Remains Unexplored 🔮

- **Why** do Beta and Binomial form a conjugate pair in the first place? (Exponential family structure, natural parameters)
- Which other conjugate pairs exist and follow the same algebra? (Gamma–Poisson, Normal–Normal, Dirichlet–Multinomial…)
- What breaks conjugacy? When are posteriors intractable and how do MCMC / variational inference step in?
- The connection between the Beta function `B(a,b)` and the Gamma function `Γ` more broadly

---

## Key Takeaway

The Gamma fraction in the normalizing constant is not magic — it is the Beta function `B(a, b)`, which is always the normalizing constant of a Beta-shaped kernel. Conjugacy guarantees the kernel stays Beta after multiplying prior × likelihood, so the denominator always resolves analytically.
