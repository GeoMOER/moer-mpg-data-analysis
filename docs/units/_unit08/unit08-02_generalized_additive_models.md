---
title: "Example: Generalized Additive Models"
header:
  image: "/assets/images/title/curve2.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
toc: true
toc_label: In this example
---

A generalized additive model (GAM) represents a response using a sum of predictor effects, which can include smooth functions. Here we fit a smooth mean curve for a continuous response: `y = intercept + s(x) + error`. We use normally distributed errors and keep predictions on the response’s original scale.

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

![Combined first and second Anscombe responses against their predictors, with the second predictor perturbed; observations show curvature and scatter.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-1-1.png)

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
## "4.3.3" "1.9.1"
```

### From linear regression models to generalized additive models

First fit a straight line to the combined observations:


``` r
plot(df$x, df$y)
lmod <- lm(y ~ x, data = df)
abline(lmod, col = "red")
```

![Straight regression line fitted to the combined Anscombe observations; the line does not capture their curved component.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-2-1.png)

``` r
summary(lmod)$r.squared
```

```
## [1] 0.6567026
```

The R squared in this summary describes **training fit**. It does not measure prediction on observations held out from fitting.

Using `gam(y ~ x)` would fit the same straight line. To allow a curve, add the smooth term `s(x)`.

Two controls determine the curve's flexibility:

* **`k` (basis dimension)** limits how complex the curve can be; it is not a literal number of knots.
* **`fx = FALSE`** lets fitting penalize unnecessary wiggles within that limit. **`fx = TRUE`** removes that penalty, so the chosen `k` controls complexity directly.

Start with `k = 10` and a penalty. The supplied fitting option `method = "GCV.Cp"` chooses the penalty strength from the training data; leave it unchanged here. Draw the fitted response on an ordered grid `px`, using `newdata` as in Unit 06:


``` r
px <- seq(min(df$x), max(df$x), length.out = 200)
smooth_gam <- gam(y ~ s(x, k = 10, fx = FALSE),
                  data = df, method = "GCV.Cp")
gampred <- predict(smooth_gam, newdata = data.frame(x = px))

plot(df$x, df$y)
lines(px, gampred, col = "red")
```

![Penalized GAM curve follows the broad curvature in the combined Anscombe observations without following every local fluctuation.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-5-1.png)

``` r
summary(smooth_gam)$r.sq
```

```
## [1] 0.7511845
```

`summary(fit)$r.sq` for a GAM returns **adjusted training R²**, accounting for fitted complexity. It does not establish better prediction. See the [GAM summary documentation](https://stat.ethz.ch/R-manual/R-devel/library/mgcv/html/summary.gam.html) for this distinction. The mean/error assumptions still need assessment, including residual patterns, variance, influential observations and independence. Smoothness does not resolve dependence in the input data.

Use the familiar residual-versus-fitted and QQ views to check the mean pattern, spread and normal approximation:


``` r
old_par <- par(no.readonly = TRUE)
par(mfrow = c(1, 2))
plot(fitted(smooth_gam), residuals(smooth_gam),
     xlab = "Fitted response", ylab = "Residual")
abline(h = 0, lty = 2)
qqnorm(residuals(smooth_gam))
qqline(residuals(smooth_gam), col = "red")
```

![Residual-versus-fitted and normal QQ views of the smooth GAM, used to inspect remaining patterns and the normal approximation.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/gam-residual-checks-1.png)

``` r
par(old_par)
```

The QQ reference line compares residuals with a normal distribution. These views do not establish independence; use the sampling design too. More detailed GAM checks are described in the optional [basis-dimension guidance](https://stat.ethz.ch/R-manual/R-devel/library/mgcv/html/choose.k.html).

### Optimal smoother selection and reducing the risk of overfitting

**Overfitting** means following chance features in training data that do not help prediction. Compare the penalized curve above with an unpenalized fit using the same `k = 10`:


``` r
fixed_gam <- gam(y ~ s(x, k = 10, fx = TRUE), data = df)
gampred <- predict(fixed_gam, newdata = data.frame(x = px))

plot(df$x, df$y)
lines(px, gampred, col = "red")
```

![Unpenalized GAM with basis dimension ten bends through local features of the combined sample; its fitted curve is more variable than the penalized fit.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-8-1.png)

``` r
summary(fixed_gam)$r.sq
```

```
## [1] 0.7400548
```

Closer agreement with training data can accompany worse held-out prediction. Adjusted training R squared also accounts for fitted model complexity, so it can decrease even when the fit to the training observations becomes closer.

For an explicit basis-size tuning exercise, vary `k` with `fx = TRUE`. The next plot **only compares fitted curves**; it does not select a model by validation. This toy dataset has 22 rows and 19 distinct predictor values, so the illustrative range stops at `k = 19`. At that upper end, only three residual degrees of freedom remain. Feasibility depends on the training subset, not just the full dataset.


``` r
basis_dimensions <- c(3, 9, 19)
cols <- c("black", "blue", "red")
curve_predictions <- lapply(basis_dimensions, function(k) {
  fit <- gam(y ~ s(x, k = k, fx = TRUE), data = df)
  predict(fit, newdata = data.frame(x = px))
})
plot(df$x, df$y, ylim = range(c(df$y, unlist(curve_predictions))))
for (i in seq_along(basis_dimensions)) {
  lines(px, curve_predictions[[i]], col = cols[i], lty = i)
}
legend("topleft", legend = paste("k =", basis_dimensions),
       col = cols, lty = 1:3, cex = 0.9, bty = "n")
```

![Three unpenalized GAM curves, k = 3, 9 and 19, show increasing capacity for local bends; colors and line types distinguish the settings.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/unnamed-chunk-9-1.png)

### LOESS

LOESS is another way to draw a smooth curve, fitting nearby observations around each predictor value. It is optional background for later time-series smoothing; this unit and Assignment 08 use GAMs only. See the [LOESS documentation](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/loess.html) if needed.

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

First fit **one setting**, `k = 3`, and predict the 20 validation responses. Calculate its adjusted training R² and held-out RMSE separately:


``` r
fit_k3 <- gam(y ~ s(x, k = 3, fx = TRUE), data = train_data)
pred_k3 <- predict(fit_k3, newdata = validation_data)
c(training_adjusted_R2 = summary(fit_k3)$r.sq,
  validation_RMSE = sqrt(mean((pred_k3 - validation_data$y)^2)))
```

```
## training_adjusted_R2      validation_RMSE
##           0.09242067           0.77511672
```

Now repeat those steps for three candidate settings. Keep the same training and validation rows for each. As in Unit 06, `lapply()` returns small tables and `do.call(rbind, ...)` joins them:


``` r
candidate_k <- c(3, 5, 9)
candidate_scores <- lapply(candidate_k, function(k) {
  fit <- gam(y ~ s(x, k = k, fx = TRUE), data = train_data)
  pred <- predict(fit, newdata = validation_data)
  data.frame(k = k,
             training_adjusted_R2 = summary(fit)$r.sq,
             validation_RMSE = sqrt(mean((pred - validation_data$y)^2)))
})
candidate_scores <- do.call(rbind, candidate_scores)
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
final_gam <- gam(y ~ s(x, k = selected_k, fx = TRUE),
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

![Observed versus predicted responses for the untouched synthetic final test set after selecting GAM basis dimension on separate validation data.]({{ site.baseurl }}/assets/images/rmd_images/e08-02/final-evaluation-1.png)

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

For this unpenalized model with one smooth, `k` cannot exceed the number of distinct training predictor values, and the number of fitted coefficients must leave residual degrees of freedom. The current complete timber input has 23 distinct oak-harvest values, so every 18-year training set can support `k = 3:13`; the largest candidate uses 13 model coefficients including the intercept and leaves only five residual degrees of freedom. Being estimable does not make that setting reliable. Keep all candidates on the same 100 splits; report and diagnose failures rather than silently comparing different sets of successful runs.

This is a tuning exercise. Its best repeated-split score has already been used to choose `k`; do not present it as an independent final performance assessment. A separate final-test submission is not required. Chronological or blocked validation would address a different prediction design and needs a separate choice of training windows and feasible basis sizes.
