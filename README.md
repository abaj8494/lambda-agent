<div align="center">

# λ

**Find the edge. Fix the miss.**

Agent skills that probe your understanding, teach only what you miss, and
drill toward the marks — from your own course PDFs.

[![GitHub stars](https://img.shields.io/github/stars/abaj8494/lambda-agent?style=flat)](https://github.com/abaj8494/lambda-agent/stargazers)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Agent Skills](https://img.shields.io/badge/agent-skills-blue.svg)](https://github.com/abaj8494/lambda-agent/tree/main/skills)
[![Method: Eero Alvar](https://img.shields.io/badge/method-Eero%20Alvar-red.svg)](https://youtu.be/kzcI5F4tGiU)

</div>

**λAMBDA** — Learner-Adaptive, Marks-Bound Drilling Agent. Works for high
school, undergrad, and graduate material alike: if it has a problem set
and an exam, λ can drill it.

## Quick install

```bash
git clone https://github.com/abaj8494/lambda-agent
cd lambda-agent && ./install.sh          # skills → ~/.claude/skills, vault → ~/lambda-vault
```

Then open the vault in [Obsidian](https://obsidian.md) (it's plain
markdown — any renderer per [SPEC.md](SPEC.md) works), start Claude Code,
and:

```
/lambda-map linear-algebra ~/uni/linalg/tutorials ~/uni/linalg/past-exams
/lambda eigenvalues
```

Answer questions by clicking checkboxes in Obsidian, or add `picker` for
the terminal. The `SKILL.md` format is portable — pi and Codex CLI load
the same files.

## The loop

Each letter is a stage:

- **L**ocate — binary-search MCQs to the edge of what you hold ("I don't
  know" is always an option, and never penalised)
- **A**sk — every question traces to a real assessed problem and its marks
- **M**iss — a miss is captured as an atom: what you knew, where you
  stalled, the one move that was missing
- **B**ridge — teach exactly that move, one reasoning step at a time, from
  your actual course material
- **D**rill — a variant (same move, new surface) before anything is called
  learned
- **A**dvance — the session's mermaid DAG updates live: done, current,
  remaining, with an ETA

Sessions are files. The vault renders them as they happen — plan graph,
LaTeX, verdicts, exit ticket — and git gives your mind a history.

## The mind image

λ maintains a persistent learner model in `mind/`:

```markdown
> [!warning] Stalled at
> Answered "how worried after a positive test?" with the sensitivity
> $P(+\mid \text{sick})$ instead of the posterior $P(\text{sick}\mid +)$.

> [!tip] Missing move
> Say aloud which way the conditional points, then check whether the
> question asks for the reverse.
```

Misconception atoms feed the next session's distractors — your own past
stalls become the wrong answers you must now see through. A mastery table
tracks every concept: `unprobed → probed → taught → locked`, and `locked`
is only reachable by passing a variant, never by having been taught.

## The marks map

`/lambda-map <course> <folders>` indexes your tutorial sheets and past
papers (questions only — it refuses to open solutions) into a routing
table: concept → drill → assessed question with marks. Sessions spend
minutes where marks are, and reveal the anchor only after you answer:
*"that was the 2019 Q3 move [5]."*

No assessment question is ever reused verbatim — the move is kept, the
surface is swapped. Open-book exams made memorised answers worthless; the
target is solving on the fly, at exam pace.

## What it is not

- **Not a summariser.** Probe-first, always: ask for a chapter summary
  mid-session and you'll get a probe instead.
- **Not a flashcard replacement.** MCQs locate and repair at acquisition;
  retention belongs to free recall. λ can hand *generation-demanding*
  cards to Anki (via AnkiConnect, opt-in) and deliberately refuses to
  write recognition-style ones.

A worked demo — completed session with live DAG, verdicts, and atoms — is
in [`docs/demo/`](docs/demo/).

## Credits

- **Method**: [Eero Alvar — *How I Use AI to Learn Things*](https://youtu.be/kzcI5F4tGiU)
  (2026-08-14). The probe → plan → teach → lock-in loop is his.
- **Sibling implementation**: [Alvarmethod](https://github.com/vasanthsreeram/Alvarmethod)
  implements the same loop as portable skills.
- **What this repo adds**: the persistent mind image (misconception atoms,
  mastery gating), the marks-bound course map, click-to-answer sessions
  rendered live in your vault, and a small [spec](SPEC.md) so any
  front-end can host the loop.

## License

[MIT](LICENSE) © 2026 FatFort
