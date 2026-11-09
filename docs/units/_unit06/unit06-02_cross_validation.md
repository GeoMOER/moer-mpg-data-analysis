---
title: "Example: Cross-Validation"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/linear_5_1.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

A model's fitted statistics describe its fit to the observations used for training. Prediction assessment asks a different question: how well does the fitted model predict observations that were left out of training?

Cross-validation repeatedly separates training observations from validation observations. The held-out observations are used to calculate prediction errors. Reusing observations across splits makes the resulting scores dependent; it does not create new independent samples.

We will compare three approaches:

* **Leave-one-out cross-validation:** hold out one observation, fit on all others, and repeat until each observation has one held-out prediction.
* **Repeated random holdout (leave-many-out):** repeatedly draw a training subset, such as 80% of the observations, and validate on the remaining observations. Some observations can be held out several times and others less often.
* **Four-fold cross-validation:** divide the observations into four disjoint groups. Hold out each group once and fit on the other three. Each observation has one held-out prediction per complete four-fold run.

These random splits illustrate the mechanics. Use them when the prediction question concerns other observations from the same population and collection process. Repeated observations from the same region should stay together when assessing prediction for unseen regions; nested administrative aggregates should not be mixed with their component districts. Predicting future years requires chronological validation. A random split alone does not remove spatial or temporal dependence.

To illustrate the calculations, we use `x1` and `y1` from the [Anscombe dataset](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/anscombe.html){:target='_blank'}. Its eleven observations make the loops easy to inspect, but such a small dataset gives unstable performance estimates.

First, fit the model to all observations. These are **training statistics**, not held-out prediction scores:


``` r
lmod <- lm(y1 ~ x1, data = anscombe)
plot(anscombe$x1, anscombe$y1)
abline(lmod, col = "red")
```

![First Anscombe dataset with its fitted linear regression, used as the starting model for cross-validation.]({{ site.baseurl }}/assets/images/rmd_images/e06-02/unnamed-chunk-1-1.png)

``` r
summary(lmod)$r.squared
```

```
## [1] 0.6665425
```

## Leave-one-out cross-validation

Start with **one observation**, row 1. Fit without it, then predict its response from its predictor value. `newdata` supplies the held-out rows and must contain the predictor column named in the model (`x1`). The held-out response `y1` is used only afterward to calculate the error.


``` r
i <- 1
train <- anscombe[-i, ]
test <- anscombe[i, ]
fit <- lm(y1 ~ x1, data = train)
pred <- predict(fit, newdata = test)
data.frame(row_id = i, observed = test$y1, predicted = pred,
           error = pred - test$y1)
```

```
##   row_id observed predicted       error
## 1      1     8.04  7.996667 -0.04333333
```

The prediction error is **predicted minus observed**; positive means overprediction. This differs from the fitted residual convention in Unit 05 (observed minus fitted).

Now repeat those same steps for each row. `lapply()` returns one small table per row; `do.call(rbind, cv)` joins these tables. Retain the row ID so each prediction can be traced back to its observation.


``` r
cv <- lapply(seq_len(nrow(anscombe)), function(i) {
  train <- anscombe[-i, ]
  test <- anscombe[i, ]
  fit <- lm(y1 ~ x1, data = train)
  data.frame(row_id = i, pred = predict(fit, newdata = test),
             obsv = test$y1)
})
cv <- do.call(rbind, cv)

plot(cv$obsv, cv$pred - cv$obsv,
     xlab = "Observed response", ylab = "Prediction error")
abline(h = 0, lty = 2)
```

![Leave-one-out prediction errors, predicted minus observed response, plotted against observed values; errors fall on both sides of zero.]({{ site.baseurl }}/assets/images/rmd_images/e06-02/unnamed-chunk-2-1.png)

**Root mean squared error (RMSE)** summarizes the size of the errors: square them, take their mean, then take the square root. It has the response's units and gives greater weight to large errors. Smaller RMSE means smaller errors on these held-out observations.


``` r
error <- cv$pred - cv$obsv
sqrt(mean(error^2))
```

```
## [1] 1.367787
```

Here, one leave-one-out run produces eleven held-out predictions and **one RMSE**. The individual errors are not eleven RMSE runs. We do not derive an ANOVA F-test from these predictions: each prediction comes from a different fitted model, so the usual single-model ANOVA decomposition does not apply.

Compare the held-out predictions with the observations. The diagonal indicates perfect prediction:


``` r
plot(cv$obsv, cv$pred, xlab = "Observed response",
     ylab = "Held-out prediction", asp = 1)
abline(0, 1, col = "red")
```

![Observed versus leave-one-out predicted Anscombe responses, with a diagonal reference line for perfect prediction.]({{ site.baseurl }}/assets/images/rmd_images/e06-02/loo-predictions-1.png)

## Leave-many-out cross-validation

In this example, repeat a random 80/20 split 100 times. Set the seed once before sampling and keep both the run ID and the original row ID. With eleven observations, rounding down gives eight training observations and three validation observations per run.


``` r
RNGkind(sample.kind = "Rejection")
set.seed(6)
n_train <- floor(0.8 * nrow(anscombe))

cv_sample <- lapply(seq_len(100), function(i) {
  train_id <- sample(seq_len(nrow(anscombe)), n_train)
  test_id <- setdiff(seq_len(nrow(anscombe)), train_id)
  fit <- lm(y1 ~ x1, data = anscombe[train_id, ])
  data.frame(run = i, row_id = test_id,
             obsv = anscombe$y1[test_id],
             pred = predict(fit, newdata = anscombe[test_id, ]))
})
cv_sample <- do.call(rbind, cv_sample)
head(cv_sample)
```

```
##    run row_id  obsv      pred
## 6    1      6  9.96 10.227311
## 7    1      7  7.24  5.556050
## 11   1     11  5.68  4.972143
## 1    2      1  8.04  7.752304
## 8    2      8  4.26  5.482220
## 9    2      9 10.84  8.508998
```

The table has one row per held-out observation in each run: 300 rows in total. `split(cv_sample, cv_sample$run)` groups these rows by run. Calculate **one RMSE per group** before summarizing the distribution across runs:


``` r
run_scores <- lapply(split(cv_sample, cv_sample$run), function(x) {
  error <- x$pred - x$obsv
  data.frame(run = x$run[1], n_test = nrow(x),
             RMSE = sqrt(mean(error^2)))
})
run_scores <- do.call(rbind, run_scores)
rownames(run_scores) <- NULL
head(run_scores)
```

```
##   run n_test      RMSE
## 1   1      3 1.0658648
## 2   2      3 1.5286334
## 3   3      3 1.6152109
## 4   4      3 1.6380227
## 5   5      3 1.5848474
## 6   6      3 0.6392997
```

``` r
round(c(mean_RMSE = mean(run_scores$RMSE),
        SD_RMSE = sd(run_scores$RMSE)), 3)
```

```
## mean_RMSE   SD_RMSE
##     1.280     0.502
```

The standard deviation describes how RMSE varies with these random splits. Because runs share observations, it is not a standard error or confidence interval based on 100 independent samples. The standard deviation or standard error of the **individual squared errors** is a different quantity and cannot be labeled the spread of RMSE across runs.


``` r
hist(run_scores$RMSE, xlab = "RMSE per run", main = "100 random holdout runs")
abline(v = mean(run_scores$RMSE), col = "red", lwd = 2)
```

![Histogram of the 100 run-level RMSE values from repeated random holdout; the vertical line marks their mean.]({{ site.baseurl }}/assets/images/rmd_images/e06-02/rmse-distribution-1.png)

Keep one RMSE per run for the assignment. Pooling all prediction rows across repeated runs and then calculating one RMSE gives a different summary: it takes the square root after averaging all squared errors. It is not the mean of the run-level RMSE values.

## Four-fold cross-validation

A four-fold run is a partition, not four unrelated random holdouts. Randomly assign every observation to one of four approximately equal groups. Each group is used for validation once:


``` r
set.seed(7)
fold_id <- sample(rep(seq_len(4), length.out = nrow(anscombe)))
table(fold_id)
```

```
## fold_id
## 1 2 3 4
## 3 3 3 2
```

``` r
four_fold_predictions <- lapply(seq_len(4), function(k) {
  test_id <- which(fold_id == k)
  fit <- lm(y1 ~ x1, data = anscombe[-test_id, ])
  data.frame(fold = k, row_id = test_id,
             obsv = anscombe$y1[test_id],
             pred = predict(fit, newdata = anscombe[test_id, ]))
})
four_fold_predictions <- do.call(rbind, four_fold_predictions)
```

Pool the held-out predictions from the four folds and compute **one RMSE for the complete run**. When comparing candidate models, use the same observations and the same fold assignment for every candidate.


``` r
error <- four_fold_predictions$pred - four_fold_predictions$obsv
round(sqrt(mean(error^2)), 3)
```

```
## [1] 1.472
```

Equivalently, add the four sums of squared prediction errors, divide by the total number of held-out observations, then take the square root. This weights folds by their sizes; it is not an unweighted mean of four fold RMSE values. If the complete partitioning procedure is repeated, retain one pooled RMSE per repetition before summarizing its distribution.

## Transfer to the regional data

In Assignment 06, carry forward Assignment 05's 2014 district-level cohort and complete `Agriculture`–`Forest` pairs. Split records from this prepared cohort, retaining identifiers for checks. This prevents repeated years and nested administrative levels from entering the same comparison. Nearby districts can still be related, so random validation describes held-out districts within this historical cohort; it does not establish performance in a new geographic area or a future year.

The assignment asks for a distribution across runs. Use a repeated holdout design or repeated complete fold partitions, document your choice, and return one RMSE per run from your function. One leave-one-out run alone does not supply that distribution.

## Further watching

1. [Machine Learning Fundamentals: cross-validation](https://youtu.be/fSytzGwwBVw?si=Es_FWEBZdwq4x0fB){:target="_blank"}

For a written description of fold partitioning, see the [R documentation for cross-validation](https://stat.ethz.ch/R-manual/R-devel/library/boot/html/cv.glm.html). The worked code above uses base R so you can inspect each split directly.
