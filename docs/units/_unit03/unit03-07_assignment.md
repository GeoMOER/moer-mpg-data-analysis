---
title: "Marked Assignment: Read and Plot"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This worksheet will guide you in getting a first overview of the wood harvest in Hessen between 1997 and 2014 using visual data exploration. After completing this worksheet you should be able to read CSV datasets and select appropriate visualization types for some key tasks in preliminary data exploration.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client.
  * Wood harvest data from Hessen provided by the course instructors on ILIAS.

## Harvest in Hessen
We will use data on the wood harvest in Hessen since 1997 for this worksheet. The data has been published by the Hessian Ministry of the Environment, Climate Protection, Agriculture, and Consumer Protection in 2015 in paper form but has been typed into an Excel sheet already. Unfortunately, the one who did this had never done it before.

Please write an R Markdown (.Rmd) document with HTML output for the following task and commit it to your GitHub-based learning log:

1. Read the data provided in the Excel file and "isolate" the tabulated information into a data.frame class.
1. Create a simple visualization which gives a quick, descriptive statistical overview of the harvest by tree type and as a total over all trees, without showing changes over time (i.e. a similar kind of information as provided by the summary function).
1. Create another visualization which - in the same figure panel - shows how beech harvest over the time span is related to oak, pine, spruce, and colored wood harvests in a 2 by 2 grid (i.e. arrange the figures in a layout with 2 columns and 2 rows).
1. Include your opinion on what could be the key message of these figures in at most two sentences.

Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.

This assignment will be marked.
{: .notice--info}
