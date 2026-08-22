# Changelog

## 0.2.0 — 2026-08-23

- **The substrate** (`mind/substrate.md`): cross-course atoms for what
  courses assume but never teach. Admission is evidence-gated and the
  course map is the fence — three doors: prerequisite descent off the
  map, second-context promotion, approved end-of-course harvest. One
  atom per concept; `Verified:` lines append as provenance.
- **Provenance over time**: substrate states never transfer into a new
  course — old evidence routes, never credits. Re-verification is a
  fast lane: one variant question, pass → re-locked in seconds.
- **Context discipline**: courses never read each other; sessions load
  only the substrate atoms their map's `assumes:` register names.
- `/lambda-map` may open a map with an `assumes: <slug>, …` register
  (declared, lazily grown — never a placement test).
- Session DAG standardised into the adjacent `<name>.dag.md` file with
  a `DAG: [[…]]` pointer line (in-file section stays valid for
  single-pane renderers); pedagogy rules from 0.1.x line: drawn
  diagrams for structural material, occasional primary-source routing,
  acronyms expanded on first use.
- All additive — vaults without the new file or registers remain
  conformant; schema stays 1.

## 0.1.3 — 2026-08-21

- Reconcile-on-open: checkbox answers now survive agent restarts. Ticks
  made while no agent was polling are graded the next time a session
  opens the file; questions with a tick are never re-posed, and a target
  with an unfinished session file is continued, never duplicated.
- Non-blocking watching: the checkbox watcher runs as a background task
  and the agent yields its turn, so typed messages land immediately
  instead of queueing behind a foreground poll (SPEC now requires this).
- Word budgets: zero words after posting a question; capped verdicts and
  teach steps, every teach step ending with work for the learner.
- Model attribution: session files open with YAML frontmatter recording
  the presiding model as an append-only list (`model: [Opus 5]`), so
  sessions taught by different models are distinguishable in the vault.
- `/lambda-map` accepts lecture transcripts as an emphasis signal: the
  map's routing weights toward what the current offering's lecturer
  actually stressed, and verbal exam hints are noted on map rows.

## 0.1.2 — 2026-08-19

- Course notation is now binding: `/lambda-map` extracts a notation
  register (the course's own symbol conventions, with textbook-clash
  warnings) into the map, and sessions teach, quiz, and file atoms in that
  register. Deliberate digressions to textbook/external notation must be
  explicitly flagged and translated back.

## 0.1.1 — 2026-08-19

- Teaching steps can now embed the cited source page as an image
  (`pdftoppm` extraction into `sessions/assets/`) instead of only citing
  the page number.

## 0.1.0 — 2026-08-19

- Initial release: `/lambda` session skill (probe → teach → drill,
  click-mode answers, living mermaid DAG with ETA), `/lambda-map` course
  map builder, SPEC schema 1, vault template, worked Bayes demo.
- First field fixes rolled in before tagging: solutions used as grounding
  but never revealed; incremental weekly map updates with a source ledger;
  free-recall anki mode; typed answers first-class during checkbox polls.
