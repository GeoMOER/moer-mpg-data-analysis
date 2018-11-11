---
title: "Unmarked Assignment: Cleaning Crops"
toc: true
toc_label: In this worksheet
---

This assignment is the first in a series which use regional statistical data. While the wood harvest data from Hessen was (i) quite small and (ii) quite tidy already, this is not the case for this data set even though it is distributed by the federal statistical offices.

After completing this worksheet you should be able to notice some common data set problems and know how to clean them up using little functions, too.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operation system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend to use R Studio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} environment for your operating system. For Windows users with little experience on the command line we recommend [GitHub Desktop](https://desktop.github.com/){:target="_blank"}.
  * Data on crop yield on an administrative community level provided by the course instructors.

## Cleaning crop data
The above data set provides information on crop yield. 

Please have look at the data and create a list of tasks you have to cope with  in order to clean the data.

Please write an R markdown script which cleans the data set according to your list. The markdown script should roughly describe what you are doing and show the major code structure in addition to some actual data wherever appropriate. After cleaning, all your id variables should be in the left, your data variables in the right columns of the data frame. 

Since the cleaning of the administrative area information requires quite a few lines of code, write a function for this takes and save this function in a separate R file (not R markdown) in order to keep the main markdown script clear.

Save your R functions and Rmd file in your course repository, knitr it, update (i.e. commit) your local repository and publish (i.e. push) it to the GitHub classroom. Make sure that the created html file is also part of your GitHub repository.

Make sure you keep the cleaned dataset. You will need it in the next unit.

