---
title: "Unmarked Assignment: Cleaning Crops"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

The crop file provides a second historical regional dataset with real import and cleaning problems. Transfer the workflow from the land-use exercise while checking the crop-specific columns, units and source symbols. This assignment is **unmarked**.

## Things you need for this worksheet

- Your existing RStudio course project, R Markdown workflow and personal course repository.
- <a href="{{ site.baseurl }}/assets/data/unit04/regional-crop-yields-1999-2015.txt" download="regional-crop-yields-1999-2015.txt">regional-crop-yields-1999-2015.txt</a>, the English teaching copy (also available on ILIAS), saved in `Data/`.
- The [Unit 04 file guide]({{ site.baseurl }}/unit04/unit04-01a_introduction.html#data-for-units-04-07) and the focused text, reshaping and merging examples.

## Inspect and plan

Open the text file before importing it. Identify the introductory lines, column header, observations and footer. The file contains 8,925 region-year observations for 1999–2015, ten crop yields in `dt/ha`, decimal commas and several source symbols. It is not the same layout as the land-use input.

Write a short list of cleaning tasks and explain what one output row should represent. Preserve identifiers as text, including leading zeros. Do not let copyright/footer lines become observations or factor levels.

## Clean and document {#cleaning-crop-data}

Write an R Markdown document that implements your plan, explains the main decisions and shows selected intermediate results. Keep your Rmd beside the `.Rproj` file.

- Preserve the original source tokens before converting yields. Count `-`, `.` and `/` separately. For this exercise, retain these non-numeric tokens in a source-cell table and represent their yields as `NA` in the numerical analysis table; this policy does not establish that all symbols have the same official meaning. Do not invent zero yields. Keep an explicit `0,0` as zero.
- Separate a place name, an explicitly reported administrative type and any additional descriptors. Do not assign a type solely because a label lacks one; document unresolved cases. Optional descriptors may legitimately be absent.
- Put identifiers and metadata first, followed by numerical yield columns. Keep a **wide** table for later modeling.
- Develop a reusable function for the regional-label work and save it in `Scripts/region_helpers.R`. Load it using `source()` from your Rmd. The [text example]({{ site.baseurl }}/unit04/unit04-04a_text.html#package-a-repeated-operation) introduces this pattern; create the `Scripts/` folder before saving your function.

### Output schema

Use these metadata columns: `ID` (character), `Year` (integer), `Place` (character), `Admin_unit` (character) and `Admin_misc` (character). Each `ID`–`Year` pair should identify one observation.

For compatibility with the existing later assignment, retain the following analysis names. The English source headings give their full meaning:

| English source heading | Analysis column | Meaning |
|---|---|---|
| `Winter_wheat` | `Winter_wheat` | Winter wheat yield. |
| `Rye_and_winter_mixed_cereals` | `Rye` | Rye and winter mixed cereals, not rye alone. |
| `Winter_barley` | `Winter_barley` | Winter barley yield. |
| `Spring_barley` | `Spring_barley` | Spring barley yield. |
| `Oats` | `Oat` | Oat yield. |
| `Triticale` | `Triticale` | Triticale yield. |
| `Potatoes` | `Potatos` | Potato yield; legacy analysis-column spelling. |
| `Sugar_beet` | `Suggar_beets` | Sugar beet yield; legacy analysis-column spelling. |
| `Winter_rapeseed` | `Rapeseed` | Winter rapeseed yield. |
| `Silage_maize` | `Silage_maize` | Silage maize yield. |

All ten measurements are numerical yields in `dt/ha`. Preserve source codes separately rather than adding them to numerical predictor columns.

## Validate and retain your results

Check and report dimensions, key uniqueness, types, years, source-symbol counts and numerical missingness. Compare selected values with the source by ID, year and crop; check that joins do not multiply or discard observations.

Save the wide table as `Output/cp_clean.rds` and preserve the original-token table separately, for example as `Output/crop-source-cells.rds`. Reload your analysis output with `readRDS()` and compare it with the object you saved.

Keep the cleaned crop dataset: it is reused in **[Unit 07's feature-selection assignment]({{ site.baseurl }}/unit07/unit07-03_assignment.html)**. Units 05–06 instead use the land-use output from the exercise.
{: .notice--info}

## Submit your work

Save your function script and Rmd in your personal course repository, knit the Rmd to HTML, and commit/push the script, Rmd and HTML. Include enough explanation to recover your cleaning decisions and unresolved cases. The assignment's unmarked status and existing submission workflow are unchanged.
