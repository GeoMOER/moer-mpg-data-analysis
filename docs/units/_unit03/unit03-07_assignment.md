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
We will use the file `hessen_holzeinschlag_1997-2014.csv` provided on ILIAS. Its figures were transcribed from the Hessian ministry's 2015 forestry report, which is also available on ILIAS. The CSV has introductory text above the table and a note below it. The note and report say that `Buntholz` is included in `Buche` from **2000**, and the CSV values change in 2000. The report states the unit as **1,000 m³ without bark**. The [data-file guide]({{ site.baseurl }}/unit03/unit03-01_look_at_your_data.html#data-files-on-ilias) translates the German headings.

Please write an R Markdown (.Rmd) document with HTML output for the following task and commit it to your GitHub-based learning log:

1. Read the supplied CSV into a data frame. Keep the annual observations from 1997 to 2014; do not treat the final note as a data row. Check that the year and harvest columns have useful data types.
1. Create a simple visualization which gives a quick, descriptive statistical overview of the harvest by tree type and as a total over all trees, without showing changes over time (i.e. a similar kind of information as provided by the summary function).
1. Create a 2 by 2 figure showing how beech harvest relates to oak, pine, spruce, and `Buntholz` over the available years. Choose suitable plot types yourself and briefly justify your choice. Account for the change in how `Buntholz` is reported from 2000 onward; a recorded zero in that category does not mean that no such wood was harvested.
1. Include your opinion on what could be the key message of these figures in at most two sentences.

Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.

This assignment will be marked.
{: .notice--info}
