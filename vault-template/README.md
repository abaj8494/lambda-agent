# λambda vault (schema: 1)

This directory is your learner model plus session history. Open it in
Obsidian (or any SPEC-conforming renderer) and leave it open while
sessions run — session files update live.

| Path | Role |
|---|---|
| `mind/profile.md` | Stable facts: courses, exam formats, strengths |
| `mind/misconceptions.md` | The atoms: Known / Stalled-at / Missing move / Exercised-by / Status |
| `mind/mastery.md` | Per-concept state: unprobed → probed → taught → locked |
| `courses/<name>/map.md` | Marks-bound routing table (build with `/lambda-map`) |
| `sessions/` | One file per session — the live UI |

Recommended: `git init` here. Sessions commit themselves, and your mind
image gets a history.

## Config

Optional integrations are enabled by lines in this file:

<!-- anki-deck: MyDeck -->

Uncomment (remove the HTML comment markers) and set a deck name to let
sessions offer free-recall cards via AnkiConnect.
