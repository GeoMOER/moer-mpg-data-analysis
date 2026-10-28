---
title: "Example: Generalized Additive Models"
header:
  image: "/assets/images/title/curve2.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
toc: true
toc_label: In this example
---

A generalized additive model (GAM) represents a response using a sum of predictor effects, which can include smooth functions. Here we use a Gaussian response with an identity link: `y = intercept + s(x) + error`. A GAM can also use other response distributions and links, but this example concerns a continuous response.

A straight line is still possible: supplying `y ~ x` to `mgcv::gam()` does not add a smooth automatically. We will compare that linear fit with penalized and unpenalized smooths, then distinguish curve fitting, tuning and independent evaluation.

The small plotting dataset combines the first and second [Anscombe datasets](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/anscombe.html), with a perturbed predictor for the second set. It contains 22 observations, not just the second dataset. We explicitly reproduce its historical sampling rule and restore the previous setting afterward. It is an illustration of fitting, not an independent sample for a reliable performance claim.


``` r
suppressPackageStartupMessages(library(mgcv))
previous_rng_kind <- RNGkind()
# Recreate the historical toy data, then restore the previous sampling rule.
suppressWarnings(RNGkind("Mersenne-Twister", "Inversion", "Rounding"))
set.seed(2)
x3 <- anscombe$x3 + sample(seq(-1, 1, 0.1), nrow(anscombe))
do.call(RNGkind, as.list(previous_rng_kind))

y <- c(anscombe$y1, anscombe$y2)
x <- c(anscombe$x1, x3)
plot(x, y)
```

![Combined first and second Anscombe responses against their predictors, with the second predictor perturbed; observations show curvature and scatter.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-1-1.png)<!-- -->

``` r
df <- data.frame(y = y, x = x)
```

Record the software versions when reproducing model summaries:


``` r
c(R = as.character(getRversion()),
  mgcv = as.character(packageVersion("mgcv")))
```

```
##       R    mgcv
## "4.5.2" "1.9.4"
```

### From linear regression models to generalized additive models

First fit a straight line to the combined observations:


``` r
plot(df$x, df$y)
lmod <- lm(y ~ x, data = df)
abline(lmod, col = "red")
```

![Straight regression line fitted to the combined Anscombe observations; the line does not capture their curved component.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-2-1.png)<!-- -->

``` r
summary(lmod)
```

```
##
## Call:
## lm(formula = y ~ x, data = df)
##
## Residuals:
##     Min      1Q  Median      3Q     Max
## -2.0624 -0.7535  0.1160  0.7695  1.8985
##
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)  3.08139    0.75825   4.064 0.000606 ***
## x            0.48834    0.07895   6.185 4.83e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 1.19 on 20 degrees of freedom
## Multiple R-squared:  0.6567,	Adjusted R-squared:  0.6395
## F-statistic: 38.26 on 1 and 20 DF,  p-value: 4.833e-06
```

The R squared in this summary describes **training fit**. It does not measure prediction on observations held out from fitting.

With the same Gaussian identity-link formula and no smooth term, `gam()` fits the same straight line. Predict on an ordered grid of predictor values to draw it:


``` r
linear_gam <- gam(y ~ x, data = df, family = gaussian())
px <- seq(min(df$x), max(df$x), length.out = 200)
gampred <- predict(linear_gam, newdata = data.frame(x = px))

plot(df$x, df$y)
abline(lmod, col = "grey")
lines(px, gampred, col = "red", lty = 2)
```

![Linear-model and unsmoothed Gaussian GAM lines overlap on the combined data because both fit the same straight-line formula.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-3-1.png)<!-- -->


``` r
summary(linear_gam)
```

```
##
## Family: gaussian
## Link function: identity
##
## Formula:
## y ~ x
##
## Parametric coefficients:
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)  3.08139    0.75825   4.064 0.000606 ***
## x            0.48834    0.07895   6.185 4.83e-06 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
##
## R-sq.(adj) =   0.64   Deviance explained = 65.7%
## GCV = 1.5586  Scale est. = 1.4169    n = 22
```

For this Gaussian model without an offset, *deviance explained* matches the ordinary training R squared from `lm()`. The GAM summary's `R-sq.(adj)` is **adjusted training R squared**; `summary(model)$r.sq` retrieves that adjusted quantity. It is not a held-out R squared. The [GAM summary documentation](https://stat.ethz.ch/R-manual/R-devel/library/mgcv/html/summary.gam.html) defines both measures.

Now replace the straight-line effect with `s(x)`. The default thin-plate regression spline basis (`bs = "tp"`) provides functions that can be combined into a curve. With `fx = FALSE`, a roughness penalty controls the fitted curve's flexibility. We explicitly retain GCV smoothing-parameter selection here (`method = "GCV.Cp"`):


``` r
smooth_gam <- gam(y ~ s(x, bs = "tp", k = 10, fx = FALSE),
                  data = df, method = "GCV.Cp")
gampred <- predict(smooth_gam, newdata = data.frame(x = px))

plot(df$x, df$y)
lines(px, gampred, col = "red")
```

![Penalized GAM curve follows the broad curvature in the combined Anscombe observations without following every local fluctuation.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-5-1.png)<!-- -->

``` r
summary(smooth_gam)
```

```
##
## Family: gaussian
## Link function: identity
##
## Formula:
## y ~ s(x, bs = "tp", k = 10, fx = FALSE)
##
## Parametric coefficients:
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   7.5009     0.2108   35.58   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Approximate significance of smooth terms:
##        edf Ref.df     F  p-value
## s(x) 2.243  2.792 22.94 7.51e-07 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## R-sq.(adj) =  0.751   Deviance explained = 77.8%
## GCV = 1.1471  Scale est. = 0.97807   n = 22
```

A higher fitted deviance explained indicates closer agreement with these training observations. It does not establish better prediction. The Gaussian mean/error assumptions still need assessment, including residual patterns, variance, influential observations and independence. Smoothness does not resolve dependence in the input data.

`gam.check()` provides residual plots, convergence information and a check for a basis dimension that may be too restrictive. Set a seed for its simulation-based checks. Their p-values are diagnostic clues, not proof that the model is valid:


``` r
RNGkind("Mersenne-Twister", "Inversion", "Rejection")
set.seed(806)
gam.check(smooth_gam, k.rep = 200)
```

![Four diagnostics for the penalized Gaussian GAM: residual QQ plot, residuals versus linear predictor, residual histogram, and observed versus fitted response.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-6-1.png)<!-- -->

```
##
## Method: GCV   Optimizer: magic
## Smoothing parameter selection converged after 5 iterations.
## The RMS GCV score gradient at convergence was 9.91457e-07 .
## The Hessian was positive definite.
## Model rank =  10 / 10
##
## Basis dimension (k) checking results. Low p-value (k-index<1) may
## indicate that k is too low, especially if edf is close to k'.
##
##        k'  edf k-index p-value
## s(x) 9.00 2.24    1.48    0.98
```

The smooth can be plotted separately. It is centered, so the vertical axis is the smooth contribution rather than the full response prediction. The dashed limits describe approximate uncertainty about the estimated smooth, not a prediction interval for a new observation. Use `predict()` for the complete fitted response:


``` r
plot(smooth_gam)
```

![Centered estimated GAM smooth with dashed approximate uncertainty limits and predictor observations marked along the horizontal axis.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-7-1.png)<!-- -->

### Optimal smoother selection and reducing the risk of overfitting

Two controls need to be distinguished:

* **Basis dimension `k`:** limits the size of the function space available for the curve. For this one-variable centered smooth, its effective degrees of freedom (EDF) cannot usually exceed `k - 1`.
* **Smoothing penalty:** with `fx = FALSE`, penalizes roughness within that space. The smoothing parameter selected during fitting determines how much of the available flexibility is used. Increasing `k` does not force EDF to reach its upper limit.

In `mgcv::s()`, `k` is **not a literal count of knots**. Choose it large enough to represent the pattern and check the fit; [basis-dimension guidance](https://stat.ethz.ch/R-manual/R-devel/library/mgcv/html/choose.k.html) explains the distinction. GCV and REML are smoothing-selection methods; the [GAM selection documentation](https://stat.ethz.ch/R-manual/R-devel/library/mgcv/html/gam.selection.html) also discusses the limitations of automatic selection with few observations.

With `fx = TRUE`, the smooth is **unpenalized**: its complexity is controlled by the chosen basis dimension. The following fit uses the same `k = 10` as before, with about nine EDF for the smooth and one intercept:


``` r
fixed_gam <- gam(y ~ s(x, bs = "tp", k = 10, fx = TRUE), data = df)
gampred <- predict(fixed_gam, newdata = data.frame(x = px))

plot(df$x, df$y)
lines(px, gampred, col = "red")
```

![Unpenalized GAM with basis dimension ten bends through local features of the combined sample; its fitted curve is more variable than the penalized fit.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-8-1.png)<!-- -->

``` r
summary(fixed_gam)
```

```
##
## Family: gaussian
## Link function: identity
##
## Formula:
## y ~ s(x, bs = "tp", k = 10, fx = TRUE)
##
## Parametric coefficients:
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   7.5009     0.2155    34.8 2.02e-13 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Approximate significance of smooth terms:
##      edf Ref.df     F  p-value
## s(x)   9      9 7.643 0.000904 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## R-sq.(adj) =   0.74   Deviance explained = 85.1%
## GCV = 1.8733  Scale est. = 1.0218    n = 22
```

Closer agreement with training data can accompany worse held-out prediction. Adjusted training R squared also accounts for fitted model complexity, so it can decrease even when deviance explained increases.

For an explicit basis-size tuning exercise, vary `k` with `fx = TRUE`. The next plot **only compares fitted curves**; it does not select a model by validation. This toy dataset has 22 rows and 19 distinct predictor values, so the illustrative range stops at `k = 19`. At that upper end, only three residual degrees of freedom remain. Feasibility depends on the training subset, not just the full dataset.


``` r
basis_dimensions <- seq(3, 19)
curve_palette <- colorRampPalette(c("blue", "green", "red"))
cols <- curve_palette(length(basis_dimensions))
curve_predictions <- lapply(basis_dimensions, function(k) {
  fit <- gam(y ~ s(x, k = k, fx = TRUE), data = df)
  predict(fit, newdata = data.frame(x = px))
})
plot(df$x, df$y, ylim = range(c(df$y, unlist(curve_predictions))))
for (i in seq_along(basis_dimensions)) {
  lines(px, curve_predictions[[i]], col = cols[i], lty = 2)
}
legend("topleft", legend = paste("k =", basis_dimensions),
       col = cols, lty = 2, ncol = 2, cex = 0.65, bty = "n")
```

![Unpenalized GAM curves for basis dimensions three through nineteen show increasing capacity for local bends; the legend identifies basis dimension k.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-9-1.png)<!-- -->

### LOESS

Locally weighted scatterplot smoothing (LOESS) fits a polynomial near each target predictor value. For one predictor, `span = 0.75` uses approximately the nearest 75% of observations, with closer observations given higher weights. This is a fraction of observations ordered by predictor distance, not a fixed number of observations on each side or a time window. R's default polynomial degree is **two** (locally quadratic); use `degree = 1` for local straight-line fits. See the [LOESS documentation](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/loess.html).


``` r
loessmod <- loess(y ~ x, data = df, span = 0.75, degree = 2)
loesspred <- predict(loessmod, newdata = data.frame(x = px))
plot(df$x, df$y)
lines(px, loesspred, col = "red")
```

![Locally quadratic LOESS with span 0.75 follows the broad curved component of the combined Anscombe sample.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-10-1.png)<!-- -->

Smaller spans use fewer nearby observations and permit more local variation. A fit can become unstable when too few distinct predictor values support a local polynomial. The next comparison uses four spans; it illustrates flexibility and does not establish which span predicts best:


``` r
spans <- c(0.4, 0.6, 0.75, 1)
cols <- curve_palette(length(spans))
plot(df$x, df$y)
for (i in seq_along(spans)) {
  fit <- loess(y ~ x, data = df, span = spans[i], degree = 2)
  lines(px, predict(fit, newdata = data.frame(x = px)), col = cols[i])
}
legend("topleft", legend = paste("span =", spans),
       col = cols, lty = 1, cex = 0.8, bty = "n")
```

![LOESS fits at spans 0.4, 0.6, 0.75 and 1 show increasing smoothing as more neighboring observations enter each local quadratic fit.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-11-1.png)<!-- -->

### From curve fitting to tuning

Use held-out prediction errors to compare tuning settings. Keep the observations and validation partitions fixed across candidates, as in Units 06–07. To show the distinction from final evaluation, create a larger independent synthetic sample. Reserve 20 observations as a final test set; split the remaining 80 into 60 for fitting and 20 for tuning:


``` r
RNGkind("Mersenne-Twister", "Inversion", "Rejection")
set.seed(808)
tuning_data <- data.frame(id = seq_len(100), x = runif(100, -2, 2))
tuning_data$y <- sin(2 * tuning_data$x) + rnorm(100, sd = 0.25)

training_id <- sample(seq_len(nrow(tuning_data)), 60)
remaining_id <- setdiff(seq_len(nrow(tuning_data)), training_id)
validation_id <- sample(remaining_id, 20)
final_test_id <- setdiff(remaining_id, validation_id)
train_data <- tuning_data[training_id, ]
validation_data <- tuning_data[validation_id, ]
final_test <- tuning_data[final_test_id, ]
```

Compare three basis dimensions using the same training and validation rows. `fx = TRUE` isolates the effect of basis size. The candidate table records adjusted R squared **from the training fit** and RMSE **from held-out validation predictions**:


``` r
candidate_k <- c(3, 5, 9)
candidate_models <- lapply(candidate_k, function(k) {
  gam(y ~ s(x, bs = "tp", k = k, fx = TRUE), data = train_data)
})
candidate_scores <- data.frame(
  k = candidate_k,
  training_adjusted_R2 = vapply(candidate_models, function(fit) {
    summary(fit)$r.sq
  }, numeric(1)),
  validation_RMSE = vapply(candidate_models, function(fit) {
    pred <- predict(fit, newdata = validation_data)
    sqrt(mean((pred - validation_data$y)^2))
  }, numeric(1))
)
round(candidate_scores, 3)
```

```
##   k training_adjusted_R2 validation_RMSE
## 1 3                0.092           0.775
## 2 5                0.860           0.313
## 3 9                0.853           0.322
```

Select the smallest validation RMSE, keeping full precision for the comparison. The minimum is a **tuning score**, since it helped choose `k`. Freeze that choice, refit on the 80 development observations, and use the reserved test set once:


``` r
selected_k <- candidate_scores$k[which.min(candidate_scores$validation_RMSE)]
development <- rbind(train_data, validation_data)
final_gam <- gam(y ~ s(x, bs = "tp", k = selected_k, fx = TRUE),
                 data = development)
final_prediction <- predict(final_gam, newdata = final_test)
final_test_RMSE <- sqrt(mean((final_prediction - final_test$y)^2))
c(selected_k = selected_k, final_test_RMSE = round(final_test_RMSE, 3))
```

```
##      selected_k final_test_RMSE
##            5.00            0.22
```

``` r
plot(final_test$y, final_prediction, xlab = "Observed final-test response",
     ylab = "Final-test prediction", asp = 1)
abline(0, 1, col = "red")
```

![Observed versus predicted responses for the untouched synthetic final test set after selecting GAM basis dimension on separate validation data.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/final-evaluation-1.png)<!-- -->

Do not use the final test score to choose another `k`, try another split or change the data preparation. That would make the final test part of tuning. This example uses one tuning holdout to make the roles clear; repeated tuning splits can be drawn **within the development data** before a frozen model is tested independently. Units 06–07 provide the repetition and selection patterns.

### Metrics for repeated tuning runs

For each candidate `k` and each tuning run, retain one held-out RMSE and the fitted model's adjusted training R squared. The three curves requested in Assignment 08 have these definitions:

| Curve | Calculation for each `k` | Interpretation |
|---|---|---|
| Mean RMSE | Mean of the 100 run-level held-out RMSE values. | Average error across the chosen random splits; smaller is better. |
| Mean RMSE ± SD | Mean RMSE plus/minus the SD of those same 100 run-level values. | Descriptive sensitivity to the splits, not a standard error or confidence interval. |
| Mean training adjusted R squared | Mean of `summary(fit)$r.sq` across the 100 training fits. | A fitted summary, not a held-out prediction score; it can be negative. |

The [run-level example in Unit 06]({{ site.baseurl }}/unit06/unit06-02_cross_validation.html#leave-many-out-cross-validation) shows why one score per run is needed. Do not substitute pooled RMSE across all test rows for the mean run-level RMSE, or use the SD of individual squared errors. Repeated splits reuse observations, so their scores are dependent.

For a shared-scale plot, calculate one divisor: the maximum **mean** RMSE across the candidate settings. Divide the mean RMSE and both SD bounds by that same divisor; keep adjusted R squared on its own scale. Label the normalization and retain the original error units when reporting numerical values. The scaled error is unitless, but its height is not equivalent in meaning to R squared. Set axis limits to show every curve, including negative adjusted R squared or a descriptive lower SD bound below zero.

### Annual observations in Assignment 08

The timber dataset has only 23 annual records, from 2003 to 2025. The assignment retains 100 random 80/20 splits: **18 training years and five held-out years** per run after rounding down the training size. Its target is retrospective prediction of held-out records within the same historical series, not forecasting a future year. Shared trends, serial dependence and collection changes can make random-split scores optimistic. A held-out predictor value can also lie outside the training predictor range; inspect that possibility rather than treating every random split as interpolation.

For the one-smooth unpenalized Gaussian model, `k` cannot exceed the number of distinct training predictor values, and the total model rank must leave residual degrees of freedom. The current complete timber input has 23 distinct oak-harvest values, so every 18-year training set can support `k = 3:13`; the largest candidate uses 13 model coefficients including the intercept and leaves only five residual degrees of freedom. Being estimable does not make that setting reliable. Keep all candidates on the same 100 splits; report and diagnose failures rather than silently comparing different sets of successful runs.

This is a tuning exercise. Its best repeated-split score has already been used to choose `k`; do not present it as an independent final performance assessment. A separate final-test submission is not required. Chronological or blocked validation would address a different prediction design and needs a separate choice of training windows and feasible basis sizes.
