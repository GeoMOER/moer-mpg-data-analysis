---
title: "Marked Assignment: Forest vs. Agriculture"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/teaser/linear_5_1.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Do districts with more agricultural land tend to have less forest? Use the land-use data to fit a regression, check its residuals and investigate how the normality-test result changes when you use smaller samples.

## Things you need for this worksheet

Use your existing course project with [R](https://cran.r-project.org/){:target="_blank"}, [RStudio](https://www.rstudio.com/){:target="_blank"} and [Git](https://git-scm.com/downloads){:target="_blank"} ([GitHub Desktop](https://desktop.github.com/){:target="_blank"} optional).

## Input from Unit 04

Read `Output/lu_clean.rds` from the [Unit 04 land-use exercise]({{ site.baseurl }}/unit04/unit04-05_cleaning.html#handoff-to-later-units) with `readRDS("Output/lu_clean.rds")`. Use **`Agriculture` as the predictor (x)** and **`Forest` as the response (y)**. Both columns give percentages of a district's total area.

<span id="prepare-comparable-observations"></span>

Keep only **2014** records labeled **`District` or `Urban district`** in `Admin_unit`, with values in both columns. Exclude other or unresolved types. Keep the region IDs, check that each district occurs once and that at least 50 districts remain. Report exclusions due to metadata or missing values. Use this selection throughout the assignment.

## Linear modeling and normal distribution of the residuals {#linear-modeling-and-normal-distribution-of-the-residuals}

Please write an R Markdown document that fits a linear regression of **forest share against agricultural share**. Show the observations in a scatterplot, with agriculture on the x-axis, forest on the y-axis and the fitted line added.

Following the [assumptions walkthrough]({{ site.baseurl }}/unit05/unit05-03a_assumptions.html#minimum-assumptions-for-bivariate-linear-regression-models), use residual-versus-fitted and scale-location plots to discuss the mean pattern and spread. Use a QQ plot of the **residuals** to assess normality. Write **exactly one sentence** summarizing the main evidence and concerns from the spread and normality plots. No replacement model or extra diagnostics are required; do not delete observations or transform them simply to make a test pass.

## Investigate sensitivity to random subsets

Would the normality test reach the same conclusion with fewer districts? Draw **100 random subsets**, each containing **50 of your selected districts**, without replacement within a subset. For each subset, fit a new regression and apply the **Shapiro–Wilk test to that model's residuals**. Set the seed once before the loop and record it with your R version.

Report or plot how many of the 100 tests return **`p < 0.05`**. In **at most three sentences**, discuss the result in relation to your diagnostic plots, sampling design and test sensitivity. Subsets can overlap; non-rejection does not prove that the model is adequate, and the rejection frequency is not the probability that it is correct.

The two land uses share a finite district area, and neighboring districts may be related. Interpret the result as an association within the selected districts, not a causal effect.

Keep the Rmd beside your `.Rproj` file. Knit it, then commit and push your **R functions, .Rmd and .html** to the course repository.

This assignment will be marked.
{: .notice--info}
