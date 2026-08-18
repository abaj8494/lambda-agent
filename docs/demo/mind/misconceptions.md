# Misconceptions (demo)

## 2026-08-18 — Inverted conditional

*Course: bayes-basics, λ session Unit 1.*

> [!warning] Stalled at
> Answered "how worried after a positive test?" with the sensitivity
> $P(+\mid \text{sick})$ instead of the posterior $P(\text{sick}\mid +)$.

**Known**: sensitivity and false-positive rate as given quantities.
**Stalled at**: the two conditionals felt interchangeable.

> [!tip] Missing move
> Say aloud which way the conditional points, then check whether the
> question asks for the reverse. If it does, Bayes' rule — and the prior
> does the heavy lifting:
> $$P(\text{sick}\mid +) = \frac{P(+\mid \text{sick})\,P(\text{sick})}{P(+)} \approx 0.17 \;\text{at a}\; 1\% \;\text{base rate}$$

**Exercised by**: Problem set A Q2; sample final Q2 [8].
**Status**: `drilled`
