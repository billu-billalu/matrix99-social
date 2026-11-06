# matrix99-social: EUEE study vault

Obsidian vault for the EUEE social-science stream. Curriculum = Ethiopian **new curriculum (2023 textbooks)**, Grades 9–12. Start at `00-home/dashboard.md`.

## Layout

| Folder | What lives there |
|---|---|
| `00-home/` | Dashboard, study plan |
| `curriculum/` | **Source of truth.** `unit-index.md` + one note per textbook unit (128) |
| `chapters/` | Exam-chapter guides (53): ordered reading paths built from unit notes |
| `bridges/` | Cross-subject concept notes (26) |
| `practice/` | Error log, past papers, timeline, formula sheet, book checks |
| `sources/books/` | Textbook PDFs, named `<subj>-g<grade>.pdf` (hist, geog, econ, math; g09–g12). `math-g11` and `math-g12` exceed GitHub's file limit, so they are attached to the repo's Releases |
| `sources/text/` | Page-tagged text of each book (`=== PAGE n` = PDF page). Search here. `math-g11` and `math-g12` are OCR'd (expect typos) |
| `tools/build-text.sh` | Regenerates `sources/text/`. Needs Poppler + Tesseract (winget) |

## Naming

- Unit note: `<Subj> <grade>.<unit> <Title>`, e.g. `Hist 9.3 ...`. Titles must match `unit-index.md` so wikilinks resolve.
- Chapter guide: `<Subj> Ch<n> <Title>`. History order is chronological; the others follow prerequisites.
- Section reference: `[[Note]] §4.5` (sections live in tables, not headings).

## Unit note format

Frontmatter: `subject, grade, unit, chapter, book, pages (printed book pages), pdf_pages, status, verified`.
- `status`: `mapped` → `linked` → `studied` → `mastered`
- `verified: true` means section numbers were checked against the book text. It does not mean tags were reviewed by reading each section.

Section tags:
- **CORE**: main treatment; study deeply here
- **SKIM**: taught again in more depth elsewhere; read quickly, study at the target
- **BUILDS**: extends an earlier section; read that first
- **CONTEXT**: useful background unlikely to need deep study; priority set by past-paper evidence. Ethiopian history and figures are core content here, not CONTEXT

How tags were set: History by comparing word counts of matched sections in Grades 9/11 and 10/12 (later ≥1.3× → later CORE, earlier SKIM; similar → earlier CORE, later BUILDS; earlier clearly longer → earlier CORE, later SKIM). Geography and Economics by comparing section coverage. Treat all tags as provisional until past papers are mapped.

## Study content

Unit notes have an objectives checklist, key terms and a review pointer, rewritten from each book's outcomes and terms. Chapter guides add Must know, Test yourself and, where useful, Timeline, Formulas, Answers and Book check. Every Must know line cites its unit and section.

## Rules

- Verify unit and section numbers against `sources/text/`. Where a contents page disagrees with the body, follow the body and record it in `unit-index.md`.
- Exam weighting comes from past papers mapped in `practice/`, not page counts.
- Every wrong practice answer goes in `practice/error-log.md`, tagged to a unit note.
- Text files are large: grep them, never read whole files into context.
