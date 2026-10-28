---
title: "Marked Assignment: Wheat vs. Everything Else"
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

Use `Output/cp_clean.rds`, the wide crop-yield table created in the [Unit 04 cleaning assignment]({{ site.baseurl }}/unit04/unit04-07_assignment.html#output-schema). Load it with `readRDS("Output/cp_clean.rds")` from your existing course project. `Winter_wheat` is the response; the ten crop columns contain yields in `dt/ha`. The linked schema explains full crop meanings and retained legacy column spellings. Use the other nine numerical crop columns as candidate predictors, excluding `Winter_wheat` itself; region identifiers and source-symbol records are not additional crop yields. A prepared instructor checkpoint must match the current workflow before substituting for your output.

## Prepare comparable observations

Use **2014** records whose explicitly recorded `Admin_unit` is **`District` or `Urban district`**. Omit other levels and unresolved types. Retain IDs, check that each region occurs once, and report exclusions for metadata and missing measurements.

Prepare **one common complete-case dataset across all ten crop columns**: the response and all nine candidates. Use these same observations for every candidate model in both selection modes. Do not let each formula silently select different complete rows. Discuss that excluding incomplete records can limit representativeness. Random validation within this cohort does not remove spatial dependence or test prediction in future years.

## Forward feature selection in multiple linear regression models
Please write an R function which implements a forward feature selection approach for a multiple linear regression model. The function should have two options for the performance measure: (i) the Akaike information criterion (AIC) and (ii) four-fold cross-validation scored by **pooled held-out RMSE**, as shown in the [candidate-scoring example]({{ site.baseurl }}/unit07/unit07-02_variable_selection.html#compare-candidates-with-four-fold-validation).

Create one approximately balanced four-fold partition before selection and use it for every candidate and every forward step. Each observation is held out once across the four folds. Set and report a seed and your R version. Compare additions against the current model, starting from an intercept-only baseline; stop when no candidate improves the criterion. Document how ties are resolved. Smaller AIC and smaller RMSE are preferred; AIC is not an error in yield units.

Test the function by predicting winter wheat yield from the other crop yields in your prepared cohort.

Write an R Markdown (.Rmd) document with HTML output which tests the functionality of the function above and graphically shows the performance of the individual models computed during the feature selection as the number of predictors increases. The R Markdown (.Rmd) document should also print the selected variables and final selection criterion for each mode. Label AIC and four-fold RMSE separately. These scores were used to select the model and are not independent final prediction assessments; a separate final-test submission is not required.


Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.

This assignment will be marked.
{: .notice--info}


