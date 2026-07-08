# MetaEcon — Systematic Review & Meta-Analysis Workbench

A single-file web app (`index.html`, zero dependencies, no build step, no server)
that walks an applied economist from protocol to meta-analysis:

1. **Protocol** — research question, effect-size metric, identification
   strategies (RCT / DiD / RDD / IV / shift-share / …), year, journal, and
   publication-type criteria. Everything downstream is generated from these choices.
2. **Search & screen** — OpenAlex keyword search with multi-select JEL-style
   field chips and a study region → country cascade; citation snowballing from
   seed DOIs or one click from any record; title/abstract screening with PRISMA
   exclusion reasons and optional AI-suggested verdicts (a human confirms every
   one). Or skip screening: paste DOIs / BibTeX / add manually.
3. **Retrieve** — open-access check per DOI; the app fetches what it can for
   free and asks you to fill the gaps (upload the PDF from your library access,
   or paste text).
4. **Extract** — one Claude API call per paper (bring your own key; the call
   goes browser → Anthropic directly, no server sees your key or your papers)
   against a fixed JSON schema: every reported estimate with coefficient/SE as
   printed, spec, table reference, and a high/low confidence flag.
5. **Adjudicate** — low-confidence and missing-SE rows queue first; verify,
   correct, or drop. Only verified estimates enter the analysis by default.
6. **Analyze** — fixed effect / random effects (DerSimonian–Laird), I², τ²,
   forest and funnel plots, FAT-PET publication-bias regression, subgroups by
   identification strategy. All computed client-side.
7. **Report & export** — estimates CSV, BibTeX, live PRISMA flow (SVG),
   project JSON, and a provenance log of every automated action.

## Validation

The extraction approach was benchmarked against the open hand-coded dataset of
Havránek (2015, JEEA; meta-analysis.cz): 271 ground-truth estimates across 9
primary studies, 5 of them scanned images requiring vision. Blind extraction,
pre-registered scorer:

| Metric | Value |
|---|---|
| Recall | 99.3% |
| Coefficient+SE accuracy (all rows) | 98.2% |
| **Coefficient+SE accuracy (high-confidence rows)** | **98.9%** |

The product thesis this validates: the model does the laborious majority and
tells you which rows to double-check; you adjudicate the flagged minority
instead of re-reading every paper. It is not unattended extraction.

## Run it

- **Hosted:** the GitHub Pages URL of this repo — live OpenAlex search and
  Claude extraction both work there.
- **Local:** double-click `start-metaecon.bat` (Windows) or run
  `python -m http.server` in this folder and open http://127.0.0.1:8877.

Your API key stays in the browser (session storage unless you tick "remember");
projects live in localStorage and in the JSON file you export.

## Notes

- OpenAlex has no "country studied" field (its country filters mean author
  affiliation), so region/country choices are matched inside the boolean search
  query — expect some off-topic hits; that is what screening is for.
- Developed as part of a living-literature-database project; extraction schema
  and confidence-flag design come from its benchmarked ingest pipeline.
