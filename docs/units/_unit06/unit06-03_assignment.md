---
title: "Unmarked Assignment: Recreation vs. Settlement revisited"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/teaser/linear_5_1.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This worksheet revisits the settlement vs. recreation model and examines to what extent the results describing the performance of the model differ between the "internal" model evaluation and a test against independent samples.

After completing this worksheet you should have gained some experience in applying cross-validation for estimating the performance of a model.



## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client.
  * Data on percentage shares of land use at several administrative levels provided by the course instructors.


## Input from Unit 04

Reuse `Output/lu_clean.rds`, the wide land-use table from the [Unit 04 worked example]({{ site.baseurl }}/unit04/unit04-05_cleaning.html#handoff-to-later-units), as in Assignment 05. Load it with `readRDS("Output/lu_clean.rds")` from your course project. Keep its region/year identifiers when designing validation; the input contains several administrative levels and repeated regions across years.

## Prediction error of a linear model
Please write an R Markdown document,
which helps you to statistically evaluate the performance of a simple linear model that predicts the percentage recreation area from the respective settlement area. 
Therefore, please choose an appropriate cross-validation procedure.
The procedure should be implemented as a function. 
Include a plot in the end that provides information on the distribution of the root mean squared error across the different cross-validation runs.

Please write exactly one sentence as a summary of the reliability of the model.

Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.



