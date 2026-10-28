---
title: "Unmarked Assignment: Model Tuning"
header:
  image: "/assets/images/title/curve2.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
toc: true
toc_label: In this worksheet
---

This worksheet uses cross-validation strategies for tuning an additive model.

After completing this worksheet you should have improved your skills in using cross-validation approaches.


## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client.
  * The file `hessen_holzeinschlag_2003-2025.csv` from ILIAS, used in [Assignment 03]({{ site.baseurl }}/unit03/unit03-07_assignment.html).


## Model tuning
For implementing a cross-validation-based and quite simple tuning of an additive model, we go back to the wood harvest data set for Hesse, using the 23 calendar years from 2003 to 2025. Import the annual observations, excluding the four introductory lines and the final notes.
The aim is to predict harvest in the beech and other deciduous trees group (`Beech_other_deciduous`) from harvest in the oak and red oak group (`Oak_red_oak`). Both columns are measured in 1,000 m³ without bark; they represent wood type groups, not individual species.

Write an R Markdown document tuning a Gaussian additive model for `Beech_other_deciduous` harvest from `Oak_red_oak` harvest. Retain `Year` as an identifier, check that each year from 2003 to 2025 occurs once, and use all 23 complete pairs. Neither year, other wood groups nor the official total is an additional predictor in this task.

### Fit and compare basis dimensions

Use `mgcv::gam()` with one thin-plate regression smooth, `s(Oak_red_oak, bs = "tp", k = ..., fx = TRUE)`, and the default Gaussian identity-link family. Here `fx = TRUE` makes the smooth unpenalized so that the exercise isolates **basis dimension `k`**, from **3 through 13**, as the tuning setting. `k` is not a literal number of knots; the [worked explanation]({{ site.baseurl }}/unit08/unit08-02_generalized_additive_models.html#optimal-smoother-selection-and-reducing-the-risk-of-overfitting) contrasts this with penalized smoothing.

Create **100 reproducible random 80/20 splits**: 18 training years and five held-out years per run. Set a seed once before drawing the splits, retain their year IDs, and record your seed, R version and `mgcv` version. Generate the splits once and reuse the **same training/validation rows for every `k`**. Fit each candidate only on its training rows and predict its five held-out observations.

Check basis feasibility against the training data: `k` cannot exceed the number of distinct predictor values, and the model must retain residual degrees of freedom. In this complete dataset, each training set has 18 distinct predictor values, so the range 3–13 is estimable. The largest setting still leaves only five residual degrees of freedom. Report and diagnose any failed fit or nonfinite prediction rather than silently dropping runs from a comparison.

### Summarize and visualize the tuning scores

For every `k`, calculate one RMSE per run from its held-out predictions, and record `summary(fit)$r.sq` from that run's **training fit**. Plot these summaries as a function of basis dimension `k`:

1. The **mean of the 100 run-level held-out RMSE values**.
2. That same mean **plus/minus the SD across those 100 RMSE values**.
3. The **mean adjusted training R squared** across the 100 fitted models. This is a fitted measure and can be negative; it is not a predictive R squared on the five held-out observations.

For the shared-scale visualization, divide the mean RMSE and both SD bounds by **one common divisor: the maximum mean RMSE across `k`**. Leave adjusted R squared on its own scale, label the normalization, and keep the original harvest unit when reporting numerical errors. Ensure the axes show all three curves and both SD bounds, including any negative values. The scaled error and R squared have different meanings despite sharing a plot.

### Interpret the result

Identify the setting with the smallest mean held-out RMSE and describe the sensitivity to the random splits. The SD band is descriptive, not a confidence interval or standard error from 100 independent samples. The minimum RMSE is a **tuning score**, not an independent final performance estimate; a separate final-test submission is not required.

These random splits assess held-out annual records from the same historical 2003–2025 series. They do not establish prediction performance for future years: trends, temporal dependence and collection changes remain limitations. Inspect whether held-out oak-harvest values require extrapolation beyond a training range. Use the [worked tuning/evaluation example]({{ site.baseurl }}/unit08/unit08-02_generalized_additive_models.html#from-curve-fitting-to-tuning) to distinguish this exercise from an independent final assessment.

Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.



