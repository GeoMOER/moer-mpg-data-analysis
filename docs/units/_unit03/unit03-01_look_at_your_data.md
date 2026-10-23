---
title: Look at Your Data
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics){:target="_blank"}'
---

Become familiar with reading and writing data, computing summary statistics, and exploring data visually as the basics of data analysis.

<!--more-->

## Learning objectives
At the end of this unit you should be able to
* read and write tabulated data,
* compute some summary statistics, 
* use R's basic plot functionality to quickly visualize your data.



Additional learning material can be found in the accompanying [Base R course](https://geomoer.github.io/moer-base-r/){:target="_blank"}, e.g.
[input and output of data](https://geomoer.github.io/moer-base-r/unit06/unit06-01_Intro.html){:target="_blank"} or
[simple visualizations](https://geomoer.github.io/moer-base-r/unit09/unit09-01_Intro.html){:target="_blank"}.

## Data files on ILIAS

The files provided on ILIAS cover different steps of the course workflow. Download the ones needed for an exercise, keep their original names, and put them in the folder from which you run your R Markdown document:

| File | What it contains | How to use it |
|---|---|---|
| `AI001_gebiet_flaeche.txt` | German regional land-use shares, 1996–2014 | Raw semicolon-separated text for practicing import and cleaning. |
| `115-46-4_feldfruechte.txt` | German regional crop yields, 1999–2015 | Raw text for the later cleaning assignment. |
| `lu_clean.rds` and `cp_clean.rds` | Prepared land-use and crop-yield data | R objects for examples that start after cleaning; use `readRDS()`. |
| `hessen_holzeinschlag_1997-2014.csv` | Annual timber harvest in Hesse, 1997–2014 | The CSV for Assignment 03; it includes introductory lines and a final note. |
| `wald_und_forstwirtschaft_barrierefrei.pdf` | The German source report for the timber data | Background and provenance; the key column names are translated below. |

In the filenames, *Gebiet und Fläche* means *region and area*, *Feldfrüchte* means *field crops*, and *Holzeinschlag* means *timber harvest*. In the timber CSV, `FWJ` is the reported forestry year, `Eiche` is oak, `Buche` is beech, `Fichte` is spruce, `Kiefer` is pine, and `Insgesamt` is the total. Keep the source label `Buntholz`. The CSV note and source report say that it is included with beech from **2000**; the values in that column become zero in 2000. A recorded zero in this category from 2000 onward does not mean that no such wood was harvested. The report gives the harvest unit as **1,000 m³ without bark** (*ohne Rinde*, `o.R.`). The land-use columns in `lu_clean.rds` are already named in English; values for `Settlement` (including transport area), `Recreation`, `Agriculture`, and `Forest` are percentages of total area. `cp_clean.rds` contains crop yields in decitonnes per hectare (`dt/ha`; 1 dt = 100 kg). German place names are identifiers, not terms you need to translate.

The prepared crop file retains two misspelled column names: `Potatos` means potatoes, and `Suggar_beets` means sugar beet. In the raw crop file, `Winterweizen` is winter wheat, `Roggen` is rye, `Wintergerste` is winter barley, `Sommergerste` is spring barley, `Hafer` is oats, `Winterraps` is winter rapeseed, and `Silomais` is silage maize.

These historical extracts remain the course exercise files so that the later assignments use the same data. For recent context, compare them with the Federal Statistical Office's [timber harvest by species group and federal state, 2024–2025 (English)](https://www.destatis.de/EN/Themes/Economic-Sectors-Enterprises/Agriculture-Forestry-Fisheries/Forestry-Wood/Tables/timber-cutting-according-to-types-of-timber.html), [land use by federal state in 2024 (English)](https://www.destatis.de/EN/Themes/Economic-Sectors-Enterprises/Agriculture-Forestry-Fisheries/Land-Use/Tables/areas-laender.html), and [crop yields in 2022–2024 (English)](https://www.destatis.de/EN/Themes/Economic-Sectors-Enterprises/Agriculture-Forestry-Fisheries/Field-Crops-Grassland/Tables/2-yield-hectare-of-selected-crops-in-a-time-comparison.html). These tables differ in geographic detail and category definitions, so do not append their rows to the course files.


## Comments?
You can leave comments below if you have questions or remarks about any of the text or code in this unit. 
Please copy the corresponding line into your comment to make it easier to answer your question.

<script src="https://utteranc.es/client.js" repo="GeoMOER/moer-mpg-data-analysis" issue-term="moer-mpg-data-analysis_unit03" theme="github-light" crossorigin="anonymous" async> </script> 
