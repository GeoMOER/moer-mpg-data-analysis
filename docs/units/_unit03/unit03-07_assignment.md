---
title: "Marked Assignment: Read and Plot"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This worksheet will guide you in getting a first overview of the wood harvest in Hessen between 2003 and 2025 using visual data exploration. After completing this worksheet you should be able to read CSV datasets and select appropriate visualization types for some key tasks in preliminary data exploration.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client.
  * Wood harvest data from Hessen provided by the course instructors on ILIAS.

## Harvest in Hessen
We will use the file `hessen_holzeinschlag_2003-2025.csv` provided on ILIAS. It is prepared from the Federal Statistical Office's [GENESIS-Online table 41261-0010](https://genesis.destatis.de/datenbank/online/statistic/41261/table/41261-0010), exported on October 23, 2026. It contains 23 calendar years and four wood type groups, plus the official total, in **1,000 m³ without bark**. We start in 2003 because the earlier observations use forestry years or, for Hessen in 2002, a mixture of forestry years and calendar years.

The CSV has four introductory lines, a header in line 5, semicolon separators, decimal points, and notes below the annual observations. The [data-file guide]({{ site.baseurl }}/unit03/unit03-01_look_at_your_data.html#data-files-on-ilias) explains the English column names. Each harvest column represents a group of tree species; for example, `Beech_other_deciduous` includes beech and other deciduous trees. The total is supplied by the statistical office; small differences from the sum of the rounded group values are possible.

The official [Destatis quality report (PDF, German)](https://www.destatis.de/DE/Methoden/Qualitaet/Qualitaetsberichte/Land-Forstwirtschaft-Fischerei/holzeinschlagsstatistik.pdf?__blob=publicationFile) describes the statistics. Start with the overview on pages 3–4. Section 6.2 on page 15 explains changes to collection methods and timber assortment definitions; our calendar-year selection does not remove every methodological change in the series.

Please write an R Markdown (.Rmd) document with HTML output for the following task and commit it to your GitHub-based learning log:

1. Read the supplied CSV into a data frame. Keep the 23 annual observations from 2003 to 2025; exclude the introductory lines and final notes from the data. Check that the year and harvest columns have useful data types.
1. Create a simple visualization which gives a quick, descriptive statistical overview of the harvest by wood type group and as a total over all groups, without showing changes over time (i.e. a similar kind of information as provided by the summary function).
1. Create a 2 by 2 figure. In three panels, show how `Beech_other_deciduous` harvest relates to each of the other three wood type groups over the available years. Choose suitable plot types yourself and briefly justify your choices. In the fourth panel, show how `Beech_other_deciduous` harvest changes over time. Use labels that identify the groups and the harvest unit.
1. Include your opinion on what could be the key message of these figures in at most two sentences.

Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.

This assignment will be marked.
{: .notice--info}
