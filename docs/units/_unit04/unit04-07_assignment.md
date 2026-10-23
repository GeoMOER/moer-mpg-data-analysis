---
title: "Unmarked Assignment: Cleaning Crops"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This assignment is the first in a series which uses regional statistical data. While the wood harvest data from Hessen was (i) quite small and (ii) quite tidy already, this is not the case for this data set even though it is distributed by the federal statistical offices.

After completing this worksheet you should be able to notice some common data set problems and know how to clean them up using little functions, too.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client.
  * Data on crop yield for German reporting areas, including rural districts and independent cities (*Kreise und kreisfreie Städte*), provided by the course instructors.

## Cleaning crop data
The above data set provides information on crop yield. 

Please have a look at the data and create a list of tasks you have to cope with in order to clean the data.

Please write an R Markdown document which cleans the data set according to your list. The R Markdown document should roughly describe what you are doing and show the major code structure in addition to some actual data wherever appropriate. After cleaning, put identifier variables in the leftmost columns and data variables in the remaining columns of the data frame.

Since the cleaning of the administrative area information requires quite a few lines of code, write a function for this task and save this function in a separate R script (.R file) in order to keep the main R Markdown document clear.

Save your R functions and R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.

Make sure you keep the cleaned dataset. You will need it in the next unit.
{: .notice--info}
