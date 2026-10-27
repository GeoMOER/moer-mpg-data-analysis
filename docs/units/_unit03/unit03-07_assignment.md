---
title: "Marked Assignment: Read and Plot"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This worksheet will guide you in getting a first overview of the wood harvest in Hesse between 2003 and 2025 using visual data exploration. After completing this worksheet you should be able to read CSV datasets and select appropriate visualization types for some key tasks in preliminary data exploration.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client.
  * Wood harvest data from Hesse provided by the course instructors on ILIAS.

## Harvest in Hesse {#harvest-in-hessen}
We will use the file `hessen_holzeinschlag_2003-2025.csv` provided on ILIAS. It is prepared from the Federal Statistical Office's [GENESIS-Online table 41261-0010](https://genesis.destatis.de/datenbank/online/statistic/41261/table/41261-0010), exported on October 23, 2026. It contains 23 calendar years and four wood type groups, plus the official total, in **1,000 m³ without bark**. We start in 2003 because the earlier observations use forestry years or, for Hesse in 2002, a mixture of forestry years and calendar years.

Download the file into the same project `Data/` folder used for the examples. Keep the original filename and use a relative path when importing it.

The CSV has four introductory lines, a header in line 5, semicolon separators, decimal points, Latin-1 encoding, and notes below the annual observations. Each harvest column represents a wood type group, rather than an individual species:

| Column | Meaning |
|---|---|
| `Year` | Calendar year, 2003–2025. |
| `Oak_red_oak` | Oak and red oak. |
| `Beech_other_deciduous` | Beech and other deciduous trees. |
| `Spruce_fir_Douglas_fir_other_conifers` | Spruce, fir, Douglas fir, and other coniferous trees. |
| `Pine_larch` | Pine and larch. |
| `Total` | Official total harvest over all four groups. |

The total is supplied by the statistical office; small differences from the sum of the rounded group values are possible. The original quality codes are retained in the notes below the data. Keep only the 23 annual observations when importing the file.

The official [Destatis quality report (PDF, German)](https://www.destatis.de/DE/Methoden/Qualitaet/Qualitaetsberichte/Land-Forstwirtschaft-Fischerei/holzeinschlagsstatistik.pdf?__blob=publicationFile) describes the statistics. Start with the overview on pages 3–4. Section 6.2 on page 15 explains changes to collection methods and timber assortment definitions; our calendar-year selection does not remove every methodological change in the series.

Use the [R Syntax and Help page]({{ site.baseurl }}/unit03/unit03-02a_r_syntax_and_help.html#try-reading-the-help-yourself) to look up how to skip introductory lines and limit the number of rows read. The [four-panel layout template]({{ site.baseurl }}/unit03/unit03-06_exploration.html#arrange-four-plots-in-one-figure) supports task 3.


Please write an R Markdown (.Rmd) document with HTML output for the following task. Save it alongside your project's `.Rproj` file so that the `Data/` paths also work when knitting, and commit it to your GitHub-based learning log:

1. Read the supplied CSV into a data frame. Keep the 23 annual observations from 2003 to 2025; exclude the introductory lines and final notes from the data. Check that the year and harvest columns have useful data types.
1. Create a simple visualization which gives a quick, descriptive statistical overview of the harvest by wood type group and as a total over all groups, without showing changes over time (i.e. a similar kind of information as provided by the summary function).
1. Create a 2 by 2 figure. In three panels, show how `Beech_other_deciduous` harvest relates to each of the other three wood type groups over the available years. Choose suitable plot types yourself and briefly justify your choices. In the fourth panel, show how `Beech_other_deciduous` harvest changes over time. Use labels that identify the groups and the harvest unit.
1. Include your opinion on what could be the key message of these figures in at most two sentences.

Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.

This assignment will be marked.
{: .notice--info}
