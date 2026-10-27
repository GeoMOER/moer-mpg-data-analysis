---
title: Cleaning 101
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

## Cleaning starts with a question {#cleaning-101}

Before changing a table, ask what one row represents and which analysis it should support. A successful import is not evidence that identifiers, values or units are correct.

A useful starting point is one variable per column, one observation per row, and a separate table for each kind of observation. [Wickham (2014)](https://www.jstatsoft.org/article/view/v059i10) explains this approach. The appropriate arrangement also depends on the task: a wide table can be useful for regression, while a long table can be useful for grouped summaries.

## Example: Measurements with a source symbol {#a-small-example}

Consider these invented measurements:

| ID | Year | Height as reported |
|---|---|---|
| `01` | 2024 | `18,5` |
| `02` | 2024 | `.` |
| `03` | 2024 | `16,2` |

Each row is one site in one year. `ID` must remain text so that the leading zero survives. The height column contains decimal commas and a source symbol. Before converting it, establish the unit and what `.` means. Retain the original entries so that the decisions remain traceable.

## A cleaning workflow

1. **Keep the source.** Download it into `Data/`; never edit the original in a spreadsheet to make an import succeed.
2. **Inspect.** Read the source notes, inspect `head()`, `str()`, names, dimensions, distinct IDs and source symbols.
3. **Define the intended table.** Name its observation, key, columns, units and types. A regional ID alone is not unique in a table containing several years.
4. **Change deliberately.** Select, rename, convert, split, reshape or merge only where the intended table requires it.
5. **Validate.** Check keys, counts, values, unmatched records and missingness. Record unresolved cases instead of guessing.
6. **Save and explain.** Keep source codes and processing decisions, save the analysis table, and check its structure after reloading.

A missing optional descriptor can be legitimate. Zero missing cells is not a cleaning objective.

## From Unit 03 to Unit 04

Unit 03 prepared a small state-level table. Here we use historical regional exports with mixed administrative levels, several years, embedded descriptions and missing-value symbols. The instructor first introduces individual operations with general examples. You then apply them individually to the land-use data in class and discuss questions together. The expandable worked example supports that practice; the crop assignment transfers those operations to a second table.

All teaching explanations and regional descriptors are in English. Place names remain in their source spelling; they identify regions rather than instructions you need to translate.
