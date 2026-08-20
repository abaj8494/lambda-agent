---
name: lambda-map
description: Build or incrementally update a λambda course map — the marks-bound routing table that makes /lambda sessions target assessed problems. Use as "/lambda-map <course-name> <folder(s)>" when materials first arrive and again each week as new sheets drop. Indexes question files (solutions are consulted as grounding only, never copied) and writes courses/<name>/map.md into the vault.
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
past exam papers, quiz exports, notebooks, **lecture transcripts**
(`.txt`/`.md`/`.vtt` dumps of what was actually said).

Transcripts are an emphasis signal, not a question source: past papers
show what an earlier offering examined, but the transcript shows what
*this* offering's lecturer stressed, skipped, or hinted at ("this will be
on the exam", "we won't cover the proof"). When transcripts are present,
weight the map's marks-bound routing toward the current offering's
emphasis and note explicit verbal exam hints in the relevant map rows.
File transcripts in the `## Sources` ledger like any other input.

## Procedure

1. **Inventory and classify.** List candidate files; classify each as
   questions or solutions (`*solution*`, `*answers*`, `*marking*`, keys).
   Solutions are **grounding, not content**: read them to confirm marks,
   intended method, and concept labels — never copy solution text, steps,
   or final answers into the map. The map must read cleanly as if built
   from questions alone.
2. **Index per assessment surface.** For each question file, extract a
   per-question index: question number, marks (if stated), one line on
   what it asks (the task, not the topic label), and the concept(s) it
   exercises. For large collections, fan out subagents per file/folder and
   merge.
2b. **Extract the notation register.** While indexing, record the course's
   own symbol conventions: what each recurring symbol denotes *in this
   course's materials* (e.g. which letter the course uses for a parameter,
   an ordering, a message, a mean), and any known clash with common
   textbook conventions. The map gains a `## Notation` section:

   ```markdown
   ## Notation (course register — teach and quiz in THIS)

   | Symbol | Course meaning | Clash warning |
   |---|---|---|
   | $\mu$ | Poisson mean (this course) | many texts write $\lambda$ |
   ```

   Only record symbols actually observed in the materials — never infer a
   convention from a textbook. Weekly updates extend this table as new
   sheets introduce symbols.

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

   End the map with a `## Sources` ledger: one line per indexed file with
   the date it was indexed. This is what makes weekly updates cheap.

6. Report: units mapped, questions indexed, the top-3 marks
   concentrations, and any blind spots (concepts with no drill or no
   assessed exemplar).

## Weekly updates — courses arrive incrementally

A real student does not hold the full term's corpus on day one; tutorial
sheets and solutions land week by week. Design for that:

- **Re-running the command is the update mechanism.** If
  `courses/<name>/map.md` already exists, read it and its `## Sources`
  ledger first; index only files not in the ledger; append the new
  questions to the right unit tables; recompute the marks-at-stake
  callout; add the new files to the ledger. Never rebuild from scratch —
  existing rows and their wording stay put.
- **Thin early-term coverage degrades gracefully.** When few or no
  assessed surfaces exist yet, weight rows by lecture emphasis instead of
  marks and tag them `no assessed exemplar yet` — sessions then anchor to
  drills alone, and the tags disappear as past papers and quizzes enter
  the ledger.
- In the update report, call out which previous blind spots the new week's
  material just covered.

## Conventions

- Marks in brackets everywhere: `Q3 [5]`.
- One-line descriptions state the *task* ("derive the conditional of a
  bivariate Gaussian given evidence"), not a topic label.
- Callout hygiene: every callout line, including the `[!type]` line,
  starts with `> `.
- If the vault is a git repo, commit: `λ-map: <course> — <n> questions`.
