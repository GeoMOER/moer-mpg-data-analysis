---
title: "Marked Assignment: Wheat vs. everything else"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/teaser/ffs_beta2.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics){:target="_blank"}'
---

This worksheet uses the crop dataset cleaned previously to extend the prediction of winter wheat to multiple variables using a forward feature selection approach.

After completing this worksheet you should have gained some experience in designing a forward feature selection strategy with internal or cross-validation performance measures.


## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client.
  * Data on crop yield for German reporting areas, including rural districts and independent cities (*Kreise und kreisfreie Städte*), provided by the course instructors.


## Input from Unit 04

Use `Output/cp_clean.rds`, the wide crop-yield table created in the [Unit 04 cleaning assignment]({{ site.baseurl }}/unit04/unit04-07_assignment.html#output-schema). Load it with `readRDS("Output/cp_clean.rds")` from your existing course project. `Winter_wheat` is the response; the ten crop columns contain yields in `dt/ha`. The linked schema explains full crop meanings and retained legacy column spellings. Use the numerical crop columns as predictors; region identifiers and source-symbol records are not additional crop yields. A prepared instructor checkpoint must match the current workflow before substituting for your output.

## Forward feature selection in multiple linear regression models
Please write an R function which implements a forward feature selection approach for a multiple linear regression model. The function should have two options for the performance measure: (i) the Akaike information criterion (AIC) and (ii) a leave-many-out cross-validation strategy which uses four folds.

Test the function by predicting the winter wheat yield on the basis of any other yield included in your crop dataset.

Write an R Markdown (.Rmd) document with HTML output which tests the functionality of the function above and graphically shows the performance of the individual models computed during the feature selection as the number of predictors increases. The R Markdown (.Rmd) document should also print the performance and the variables used within the final model in the end.


Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.

This assignment will be marked.
{: .notice--info}


