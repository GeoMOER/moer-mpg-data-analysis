---
title: "Unmarked Assignment: Recreation vs. Settlement Revisited"
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

Reuse `Output/lu_clean.rds`, the wide land-use table from the [Unit 04 land-use exercise]({{ site.baseurl }}/unit04/unit04-05_cleaning.html#handoff-to-later-units), as in Assignment 05. Load it with `readRDS("Output/lu_clean.rds")` from your course project. Keep its region/year identifiers when designing validation; the input contains several administrative levels and repeated regions across years.

## Prepare comparable observations

Carry forward the **same cohort as Assignment 05**: **2014**, explicitly recorded `Admin_unit` of **`District` or `Urban district`**, and complete `Settlement`–`Recreation` pairs. Omit other levels and unresolved types, retain region IDs, report exclusions, and check that each region occurs once. Split this prepared cohort rather than the full mixed-year, mixed-level input.

Random splits assess prediction for held-out records within this historical district cohort. Nearby districts can still be related; this design does not establish transfer to an unseen geographic area or a future year.

## Prediction error of a linear model
Please write an R Markdown document,
which helps you to statistically evaluate the performance of a simple linear model that predicts the percentage recreation area from the respective settlement area. 
Choose and explain a repeated validation procedure: repeated random holdout or repeated complete fold partitions, as introduced in the [cross-validation example]({{ site.baseurl }}/unit06/unit06-02_cross_validation.html#leave-many-out-cross-validation). Implement it as a function. Set the seed once before random splitting, retain run and region IDs, and record your seed and R version.

Calculate **one RMSE per run** from that run's held-out predictions. For a fold-based design, pool the predictions from all folds within each complete run before calculating RMSE. Plot the resulting distribution across runs and report its mean and standard deviation. Label any additional pooled prediction metric separately. Overlapping runs are not independent replications; their SD describes split sensitivity rather than a standard error or confidence interval.

Please write exactly one sentence as a summary of the reliability of the model.

Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.



