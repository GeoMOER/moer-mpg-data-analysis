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
* import and export tabulated data while checking types, identifiers, and units,
* explain how a prepared RDS file relates to its source data,
* compute and interpret basic summary statistics,
* choose and justify a plot for a distribution, category comparison, time course, or relationship.

Additional material is available in the accompanying [Base R course](https://geomoer.github.io/moer-base-r/), particularly [data input/output](https://geomoer.github.io/moer-base-r/unit06/unit06-01_Intro.html) and [simple visualizations](https://geomoer.github.io/moer-base-r/unit09/unit09-01_Intro.html).

## Data files {#data-files-on-ilias}

For the Unit 03 land-use examples, create a `Data/` folder in your RStudio project and download the files linked below into it. Keep their original names. The [CSV I/O example]({{ site.baseurl }}/unit03/unit03-04_csv_io.html) shows the complete preparation; the [exploration example]({{ site.baseurl }}/unit03/unit03-06_exploration.html) then uses its saved result.

| File | What it contains | How to use it |
|---|---|---|
| [destatis-land-use-2024.csv]({{ site.baseurl }}/assets/data/destatis-land-use-2024.csv) | Official table exported as UTF-8 CSV: Germany and 16 states, 64 source columns | Import semicolon-separated text with decimal commas; the first line is the header. |
| [destatis-land-use-2024-states.rds]({{ site.baseurl }}/assets/data/destatis-land-use-2024-states.rds) | Prepared 2024 data for the 16 federal states; ten documented columns | Use `readRDS()` for visual exploration; this is generated from the CSV above. |
| [prepare-land-use-2024.R]({{ site.baseurl }}/assets/data/prepare-land-use-2024.R) | Reproducible CSV-to-RDS preparation | Run the script or follow the steps in the CSV I/O example. |
| [Original workbook]({{ site.baseurl }}/assets/data/destatis-land-use-2024.xlsx), [dictionary]({{ site.baseurl }}/assets/data/destatis-land-use-2024-dictionary.csv), [source notes]({{ site.baseurl }}/assets/data/destatis-land-use-2024-source.txt) | Original tables and definitions, bilingual column explanations, and export/preparation details | Consult these when interpreting the English names, units, unavailable cells, and categories. |

Destatis is Germany's Federal Statistical Office. The land-use observations refer to **December 31, 2024**, and the report was published on **November 21, 2025**. We use its worksheet `csv-33111-03`. Germany's aggregate is excluded from the prepared RDS so that each row represents one state. State identifiers remain text, including leading zeros. `Area_ha` is total area in hectares; `Settlement`, `Transport`, `Vegetation`, `Agriculture`, `Forest`, and `Water` are percentages of each state's total area. Agriculture and forest are components of vegetation, so these columns must not all be summed together. The [official publication page](https://www.destatis.de/DE/Themen/Branchen-Unternehmen/Landwirtschaft-Forstwirtschaft-Fischerei/Flaechennutzung/_inhalt.html) and [methods report](https://www.destatis.de/DE/Methoden/Qualitaet/Qualitaetsberichte/Land-Forstwirtschaft-Fischerei/flaechenerhebung.pdf?__blob=publicationFile) explain the statistics.

The `pressure` and `Orange` datasets used for plotting practice are included with R; no additional download is needed.

### Timber data on ILIAS

Download `hessen_holzeinschlag_2003-2025.csv` from ILIAS for Assignments 03 and 08. Keep it beside your assignment's R Markdown document, or supply its folder in your import command.

The timber CSV is prepared from [GENESIS-Online table 41261-0010](https://genesis.destatis.de/datenbank/online/statistic/41261/table/41261-0010), exported on October 23, 2026. Its values cover all forest ownership types in Hessen and are measured in **1,000 m³ without bark**. The file uses semicolon separators, decimal points, and Latin-1 encoding. The header is in line 5; the next 23 lines contain the observations. Read only these annual rows, so that the final notes do not become data rows. The selection starts in 2003 to use calendar years throughout: earlier observations refer to forestry years or, for Hessen in 2002, a mixture of reporting periods.

| Column | Meaning |
|---|---|
| `Year` | Calendar year, 2003–2025. |
| `Oak_red_oak` | Oak and red oak. |
| `Beech_other_deciduous` | Beech and other deciduous trees. |
| `Spruce_fir_Douglas_fir_other_conifers` | Spruce, fir, Douglas fir, and other coniferous trees. |
| `Pine_larch` | Pine and larch. |
| `Total` | Official total harvest over all four groups. |

The harvest columns represent **wood type groups**, not individual species. Values and official totals retain the precision of the export; small differences between a total and the sum of the rounded group values are possible. The original quality codes are retained in the notes below the data.

For the official data description, read the [Destatis quality report (PDF, German)](https://www.destatis.de/DE/Methoden/Qualitaet/Qualitaetsberichte/Land-Forstwirtschaft-Fischerei/holzeinschlagsstatistik.pdf?__blob=publicationFile). Its overview is on pages 3–4; section 6.2 on page 15 explains changes in survey frequency and timber assortment definitions before 2007. The course uses annual totals by wood type group, rather than the individual timber assortments discussed there. Starting in 2003 gives a consistent calendar-year window; it does not mean that every aspect of the survey method remained unchanged.


### Data for later units

The 2024 state table above is the Unit 03 example. Later cleaning and regression exercises use separate regional datasets with different observation counts and category definitions. Their [file guide is in Unit 04]({{ site.baseurl }}/unit04/unit04-01a_introduction.html#data-for-units-04-07); use the file specified by each exercise. Do not combine these datasets merely because some column names resemble each other.


## Comments?
You can leave comments below if you have questions or remarks about any of the text or code in this unit. 
Please copy the corresponding line into your comment to make it easier to answer your question.

<script src="https://utteranc.es/client.js" repo="GeoMOER/moer-mpg-data-analysis" issue-term="moer-mpg-data-analysis_unit03" theme="github-light" crossorigin="anonymous" async> </script> 
