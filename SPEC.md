# λambda vault spec — schema: 1

The vault is the API. The λambda skill only reads and writes plain
markdown in a vault directory; any program that satisfies the three
contracts below is a valid front-end. Obsidian satisfies all three out of
the box, which is why it is the reference renderer — but nothing in the
protocol names it.

## Vault layout

```
<vault>/
├── mind/
│   ├── profile.md          # stable facts about the learner
│   ├── misconceptions.md   # misconception atoms, newest first
│   ├── mastery.md          # per-concept state tables (course-bound)
│   └── substrate.md        # cross-course atoms: the learner's basement
├── courses/<name>/map.md   # marks-bound routing (built by /lambda-map)
├── sessions/<date>-<target>.md      # one live UI file per session
└── sessions/<date>-<target>.dag.md  # optional adjacent living DAG
```

The session DAG may live in the adjacent `.dag.md` file (one mermaid
fence plus a one-line `**Progress:**` bar ending at the ETA); the
session file then points to it with a `DAG: [[<name>.dag]]` line.
Front-ends with a dedicated DAG surface prefer the adjacent file; the
in-file `## Session DAG` section remains valid for single-pane
renderers. Never put checkboxes in a `.dag.md` file.

## Contract 1 — render

A front-end must render, inside standard markdown:

1. Inline `$...$` and display `$$...$$` math (KaTeX-level LaTeX).
2. `mermaid` fenced code blocks (the living session DAG, with `classDef`
   styling and `:::class` node annotations).
3. Callout blockquotes: `> [!success]`, `> [!warning]`, `> [!tip]`,
   `> [!info]`, `> [!important]`, `> [!question]` — every line prefixed
   with `> `. A renderer without callout support degrades to plain
   blockquotes, which is acceptable but not conformant.
4. Task-list checkboxes: `- [ ]` / `- [x]`.

## Contract 2 — input

- An MCQ is a checkbox block in the session file; options are labelled
  `**(a)**`–`**(d)**`.
- **A ticked checkbox is an answer**, regardless of what ticked it — a
  human click in Obsidian, a button handler writing `- [x]`, an `echo`
  from a script.
- The skill detects answers by re-reading the file (reference
  implementation: 2-second polling with a ~5-minute cap). A front-end may
  instead push the write and rely on the same detection; server
  deployments should replace polling with file-watching. Semantics are
  identical.
- More than one ticked box: the last one wins. No tick within the cap:
  the skill falls back to its native picker.
- The checkbox is not the only channel: an answer typed directly to the
  agent while a poll is open is equally valid and takes effect
  immediately. Front-ends must not assume exclusivity.
- **Watching must never block the conversation.** The reference
  implementation polls from a background task and yields the turn, so
  typed input always lands immediately; a front-end or agent that blocks
  its input channel while waiting on a checkbox is non-conformant.
- **Ticks are durable state, not poll events.** An answer ticked while no
  agent was running is honored the next time any agent opens the file
  (reconcile-on-open): the skill grades existing ticks before asking
  anything new, and never re-poses a question that already has one.
- Writers must append; never rewrite regions another writer authored.

## Contract 3 — integrations (optional)

- **Spaced free recall**: if the vault README contains a line
  `anki-deck: <name>`, the session may *offer* cards (generation-demanding
  fronts only) and, on explicit approval, push via AnkiConnect
  (`POST localhost:8765`, action `addNotes`). Non-local deployments may
  substitute any SRS sink that preserves the free-recall card rules.
- Absence of the config line = the integration is off. No other network
  calls are part of this spec.

## State machine

Mastery states, per concept block:

```
unprobed → probed-pass            (skipped; evidence it is already held)
unprobed → probed-miss → taught → locked
```

`locked` is reachable only through a correct **variant** answer after
teaching — never by having been taught. `probed-pass` rows are not
re-probed within 7 days.

**Evidence provenance:** states advance only on evidence the skill
observed itself, in-session. External results — grades, submitted
assignments, LMS-marked answers, prior write-ups — are routing signals
(things worth verifying) and never move a state: they may not be the
learner's own work, and the mind image exists to be accurate, not
flattering.

Misconception atom statuses: `open → taught → drilled → closed`.

## The substrate

`mind/substrate.md` holds atoms that belong to no single course:
assumed prerequisites and transferable moves (matrix multiplication,
Bayes' rule, a language idiom). One atom per concept — a concept two
courses touch is one atom with two evidence lines, never two entries:

```
## matmul — matrix multiplication
- **State:** locked
- **Verified:** 2026-08-22 · comp9418 (variant: GCN matrix form)
- **Leaned on by:** comp9418 (s45 update rule)
- **Domain:** linear-algebra
- **Notes:** rows-times-columns as dot products; shape discipline n×d·d×k
```

**Admission is evidence-gated, and the course map is the fence.** The
map is the course's claimed territory: anything the course itself
teaches is a map row and is filed course-side, however load-bearing —
a course cannot leak into the substrate through door 1. Nothing enters
for being true or general either: the learner's probed edge defines the
floor, so trivia the descent never visits does not exist to the
substrate. Three doors:

1. **Prerequisite descent** — a probe or teach step that lands on a
   concept **absent from the course's own map** (assumed, never taught,
   carrying no marks) files its evidence here, not in the course's
   mastery table. Works from the first course onward; membership in the
   map is the test, not judgment.
2. **Second-context promotion** — an atom observed load-bearing in a
   second course moves here, leaving a pointer in the course table.
3. **End-of-course harvest** — a retiring course's mastery table is
   reviewed once, asking only "what will OTHER studies lean on?"; the
   learner approves each promotion. The harvest is a selection, never a
   bulk move — most of a course stays in its grave.

A course map may declare its known dependencies with a top-of-file
`assumes: <slug>, <slug>` line; descent events grow it lazily. It is
never populated by a placement test.

**Provenance over time.** Substrate states never transfer into a new
course: evidence about last year's mind is a routing hypothesis about
this year's — the same demotion external results get. A new course
leaning on a substrate atom starts it `unprobed`, annotated with the old
verification, and re-verifies by **fast lane**: one variant question —
pass → re-locked with no teaching; fail → the normal miss path.

**Context discipline.** Courses never read each other's files. A session
loads its own course's map and mastery rows, plus only the substrate
atoms named by that map's `assumes:` register (or hit by live descent).
The atom is the interchange format between courses.

These additions are backward-compatible within schema 1: a vault without
`substrate.md` or `assumes:` registers remains fully conformant.

## Versioning

This is **schema: 1**. Files written by the skills carry the schema in
their header line. Session files carry it in YAML frontmatter, which also
records the presiding model(s) as an append-only list:

```
---
schema: 1
model: [Opus 5]
---
```

A session resumed under a different model appends to `model` rather than
overwriting — the file is a record of who taught what. Front-ends should
surface the frontmatter but must not write to it except by this rule. Breaking changes to the layout, contracts, or state
machine increment the major schema and are documented here.
