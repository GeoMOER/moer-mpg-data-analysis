---
title: "Marked Assignment: Recreation vs. Settlement"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/teaser/linear_5_1.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This worksheet tackles the question of how the percentage share of settlement area is related to the share of recreation area in German reporting regions.

After completing this worksheet you should be able to compute a linear regression model and have a first idea of how variable model results could be if only a slightly different sample is used.



## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client.
  * Data on percentage shares of land use at several administrative levels provided by the course instructors.


## Input from Unit 04

Use the wide land-use table saved as `Output/lu_clean.rds` in the [Unit 04 land-use exercise]({{ site.baseurl }}/unit04/unit04-05_cleaning.html#handoff-to-later-units). Read it from your existing course project with `readRDS("Output/lu_clean.rds")`. `Settlement` includes transport; `Settlement` and `Recreation` are percentages, and each row is a region-year record. This is separate from Unit 03's 16-state table. A prepared instructor checkpoint must match the current workflow before substituting for your output.

## Prepare comparable observations

Use **2014** observations whose explicitly recorded `Admin_unit` is **`District` or `Urban district`**. These are the two district-level types for this exercise; omit other levels and unresolved types rather than guessing them. Retain complete `Settlement`–`Recreation` pairs, preserving the region identifiers. Report how many records were excluded for metadata or missing measurements, and check that each region occurs once. Check that at least 50 complete pairs remain.

This avoids mixing repeated years and nested administrative levels. It does not guarantee independence: neighboring regions can still be related. Keep that limitation in your interpretation.

## Fit and inspect the model {#linear-modeling-and-normal-distribution-of-the-residuals}

Write an R Markdown document fitting recreation share (response) against settlement share (predictor) in this cohort. Plot the paired observations and add the fitted line. Then assess the model using the [minimum-assumptions walkthrough]({{ site.baseurl }}/unit05/unit05-03a_assumptions.html#minimum-assumptions-for-bivariate-linear-regression-models):

- Use residual-versus-fitted and scale-location plots to discuss the mean pattern and spread.
- Use a normal QQ plot of residuals to assess the normal approximation. A plot of the raw percentages does not answer this question.
- Write **exactly one sentence** summarizing the main evidence from the spread and normality plots. Use cautious wording and identify any concern.

The additional transformation, scatterplot-matrix and coplot examples are not required. A diagnostic concern is a result to explain, not a request to delete observations or transform the data until a test passes.

## Investigate sensitivity to random subsets

From the **same prepared cohort**, draw **100 random subsets of 50 complete pairs**, without replacement within each subset. Set a random seed once before the loop and record it with your R version. Fit the same regression separately to each subset and apply a Shapiro–Wilk test to that model's residuals.

Report or visualize how often the test returns `p < 0.05`. Discuss the result in **at most three sentences**, relating it to the graphical evidence, sample design and sensitivity of the test. These subsets can overlap, so the rejection fraction is not based on independent replications and is not the probability that the regression model is correct or incorrect. Failure to reject normality does not establish linearity, constant variance or independence.

Keep your Rmd beside the `.Rproj` file so that `Output/lu_clean.rds` resolves in both the console and knitting.

Save your R functions and R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.


This assignment will be marked.
{: .notice--info}

