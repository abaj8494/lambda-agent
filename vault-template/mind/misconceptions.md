# Misconceptions

The atoms of the mind image. One entry per genuine reasoning stall — not
"got it wrong", but *where* the chain broke and *which move* was missing.
Newest first. Sessions read this file to build MCQ distractors and to bias
probing; they append an entry for every miss they teach through.

Schema per entry: **Known** (what was already in hand) / **Stalled at**
(the exact gap) / **Missing move** (the one step that unblocks it) /
**Exercised by** (real problems that drill it) / **Status**
(`open` → `taught` → `drilled` → `closed`).

---

## 2026-01-01 — Inverted conditional (example — replace with your own)

*Course: any intro probability, textbook exercise.*

> [!warning] Stalled at
> Read $P(\text{positive} \mid \text{disease}) = 0.99$ and reported it as
> the probability of disease given a positive test.

**Known**: the test's sensitivity; that a definition of conditional
probability exists.
**Stalled at**: treating $P(A \mid B)$ and $P(B \mid A)$ as the same
number.

> [!tip] Missing move
> They are linked only through Bayes' rule, and the prior does the work:
> $$P(B \mid A) = \frac{P(A \mid B)\,P(B)}{P(A)}$$
> The reflex: **the moment you see a conditional, say aloud which way it
> points — then check whether the question asks for the reverse.**

**Exercised by**: any base-rate / diagnostic-test problem.
**Status**: `open`
