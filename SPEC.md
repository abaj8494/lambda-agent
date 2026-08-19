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
│   └── mastery.md          # per-concept state tables
├── courses/<name>/map.md   # marks-bound routing (built by /lambda-map)
└── sessions/<date>-<target>.md   # one live UI file per session
```

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

Misconception atom statuses: `open → taught → drilled → closed`.

## Versioning

This is **schema: 1**. Files written by the skills carry the schema in
their header line. Breaking changes to the layout, contracts, or state
machine increment the major schema and are documented here.
