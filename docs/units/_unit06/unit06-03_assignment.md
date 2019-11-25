---
title: "Unmarked Assignment: Recreation vs. Settlement revisited"
toc: true
toc_label: In this worksheet
---

This worksheet revisits the settlement vs. recreation model and compares to which degree the results describing the performance of the model differ between the "internal" model evaluation and a test against independent samples.

After completing this worksheet you should have gained some experience in applying cross-validation for estimating the performance of a model.



## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operation system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend to use R Studio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} environment for your operating system. For Windows users with little experience on the command line we recommend [GitHub Desktop](https://desktop.github.com/){:target="_blank"}.
  * Data on percentage fraction of land use on a community level provided by the course instructors.


## Prediction error of a linear model
Please write an R markdown script which helps you to statistically evaluate the performance of a simple linear model that predicts the percentage recreation area from the respective settlement area. Therefore, please choose an appropriate cross-validation procedure. The procedure should be implemented as a function. 
Include a plot in the end that provides information on the distribution of the root mean squared error across the different cross-validation runs.

Please write exactly one sentence which summarizes the reliability of the model.

Save your Rmd file in your course repository, knitr it, update (i.e. commit) your local repository and publish (i.e. push) it to the GitHub classroom. Make sure that the created html file is also part of your GitHub repository.



