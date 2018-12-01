---
title: "Marked Assignment: Wheat vs. everything else"
toc: true
toc_label: In this worksheet
---

This worksheet uses the crop dataset cleaned previously to extend the prediction of winter wheat to multiple variables using a forward feature selection approach.

After completing this worksheet you should have gained some experience in designing a forward feature selection strategy with internal or cross-validation performance measures.


## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operation system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend to use R Studio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} environment for your operating system. For Windows users with little experience on the command line we recommend [GitHub Desktop](https://desktop.github.com/){:target="_blank"}.
  * Data on crop yield on an administrative community level provided by the course instructors.


## Forward feature selection in multiple linear regression models
Please write an R function which implements a forward feature selection approach for a multiple linear regression model. The function should have two options for the performance measure: (i) the Akaike information criteria (AIC) and (ii) a leave-many-out cross-validation strategy which uses three folds.

Test the function by predicting the winter wheat yield on the basis of any other yield included in your crop dataset.

Write an Rmd file with html output which tests the functionality of the above functions and graphically shows the performance of the individual models computed during the feature selection with an increasing order of variables used for the prediction. The Rmd file should also print the performance and the variables used within the final model in the end.


Save your Rmd file in your course repository, knitr it, update (i.e. commit) your local repository and publish (i.e. push) it to the GitHub classroom. Make sure that the created html file is also part of your GitHub repository.

This assignment will be marked.
{: .notice--info}


