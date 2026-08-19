# Changelog

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
