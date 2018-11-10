---
title: "Marked Assignment: Read and Plot"
toc: true
toc_label: In this worksheet
---

This worksheet will guide you in getting a first overview of the wood harvest in Hessen between 1997 and 2014 using a visual data exploration. After completing this worksheet you should be able read CSV datasets and select appropriate visualization types for some key tasks in preliminary data exploration.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operation system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend to use R Studio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} environment for your operating system. For Windows users with little experience on the command line we recommend [GitHub Desktop](https://desktop.github.com/){:target="_blank"}.
  * Wood harvest data from Hessen provided by the course instructors.

## Harvest in Hessen
We will use data on the wood harvest in Hessen since 1997 for this worksheet. The data has been published by the Hessische Ministerium für Umwelt, Klimaschutz, Landwirtschaft und Verbraucherschutz in 2015 in paper form but been typed into an Excel sheet already. Unfortunately, the one who did had never done it before.

Please write an R script as an Rmd file with html output for the following task and commit it to your GitHub-based learning log:

1. Read the data provided in the Excel file and "isolate" the tabulated information into a data.frame class.
1. Create a simple visualization which gives a quick, temporally non explicit and descriptive statistical overview of the harvest by tree type and as a total over all trees (i.e. a similar kind of information as provided by the summary function).
1. Create another visualization which - in the same figure panel - shows how each beech harvest over the time span is related to each of the oak, pine, spruce and colored wood harvests in a 2 by 2 grid (i.e. arrange the figures in a 2 columns and 2 rows layout).
1. Include your opinion on what could be the key message of these figures in two sentence max.

Save your Rmd file in your course repository, knitr it, update (i.e. commit) your local repository and publish (i.e. push) it to the GitHub classroom. Make sure that the created html file is also part of your GitHub repository.

This assignment will be marked.
{: .notice--info}
