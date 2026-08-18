---
name: lambda-map
description: Build a λambda course map — the marks-bound routing table that makes /lambda sessions target assessed problems. Use as "/lambda-map <course-name> <folder(s) of question PDFs/notebooks>". Indexes tutorial/exam QUESTION files (never solutions), extracts per-question topics and marks, and writes courses/<name>/map.md into the vault.
---

# λambda map builder (schema: 1)

The map is what separates λambda from a generic AI tutor: every MCQ a
session asks traces to a real assessed problem and the marks it carries.
This skill builds that map from the learner's **own** course materials —
the map derives from their institution's copyrighted content, so it lives
in their private vault and is never redistributed.

## Usage

`/lambda-map <course-name> <path> [more paths...]`

Paths may be folders or files: lecture PDFs, tutorial/problem-set PDFs,
past exam papers, quiz exports, notebooks.

## Procedure

1. **Inventory, and refuse solutions.** List candidate files. Exclude
   anything matching `*solution*`, `*answers*`, `*marking*`, answer keys.
   You index *questions only* — the map must never require having read a
   solution, and λ sessions are forbidden from opening them.
2. **Index per assessment surface.** For each question file, extract a
   per-question index: question number, marks (if stated), one line on
   what it asks (the task, not the topic label), and the concept(s) it
   exercises. For large collections, fan out subagents per file/folder and
   merge.
3. **Reverse-index by concept.** For each lecture/chapter-level concept,
   list every drill (tutorial/problem-set question) and every assessed
   target (exam/quiz question with marks) that exercises it.
4. **Weight it.** Open the map with a `> [!important] Marks at stake`
   callout: which concepts carry the most assessed marks, which appear in
   the most recent / most format-relevant papers, and any concept that
   appears in exactly one exemplar (flag it — thin coverage means the
   drills are precious).
5. **Write `courses/<course-name>/map.md`** in the vault:

```markdown
# <course> routing map (schema: 1)

Built <date> from question files only; no solutions opened.
Source roots: <paths>

> [!important] Marks at stake
> <the weighting summary>

## <Unit / lecture / chapter>

| Concept | Drill | Assessed target |
|---|---|---|
| <concept> | <Tut X Qy — one-line task> | <Exam year Qz [marks]> |
```

6. Report: units mapped, questions indexed, the top-3 marks
   concentrations, and any blind spots (concepts with no drill or no
   assessed exemplar).

## Conventions

- Marks in brackets everywhere: `Q3 [5]`.
- One-line descriptions state the *task* ("derive the conditional of a
  bivariate Gaussian given evidence"), not a topic label.
- Callout hygiene: every callout line, including the `[!type]` line,
  starts with `> `.
- If the vault is a git repo, commit: `λ-map: <course> — <n> questions`.
