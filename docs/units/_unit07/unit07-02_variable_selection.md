---
title: "Example: Feature Selection in Multiple Regression"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/ffs_beta2.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics){:target="_blank"}'
---

So far, the models have only considered one explanatory (i.e. independent) variable.
If a dependent variable should be explained or predicted by more than one independent variable, decisions have to be made regarding the best combination of independent variables.

We will use **forward selection**: begin with a model that predicts only the mean, try adding each available predictor, keep the best improvement and repeat. Stop when no addition improves the chosen score. This finds a useful model along that search path; it does not guarantee the best of all possible combinations.

## Which measure answers which question?

| Measure | What it describes | How to use it here |
|---|---|---|
| **R squared (R²)** | Fraction of response variation accounted for in the fitting data. | Describes training fit; adding predictors cannot decrease it on the same rows. |
| **Adjusted R²** | Training fit adjusted for the number of predictors. | Can decrease when an added predictor contributes little; still a training summary. |
| **Akaike information criterion (AIC)** | Balance between fit and the number of estimated parameters. | Prefer smaller values when comparing these linear models on the same response observations. It is a relative score, not an absolute quality rating. |
| **Root mean squared error (RMSE)** | Size of prediction errors in response units. | Prefer smaller values calculated from the same held-out observations. |

We use AIC first, then the held-out RMSE from Unit 06. A score used to select a model is a **selection score**; it is not an independent final evaluation. See the [R AIC documentation](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/AIC.html) for comparison requirements.

To illustrate multiple regression, we modify the [Anscombe dataset](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/anscombe.html). Its original `x1`, `x2` and `x3` are identical. This is an extreme case of **collinearity**: predictors contain overlapping information, and exact duplicates prevent separate estimation of their effects.

The following code recreates the small historical synthetic example using its original sampling algorithm and fixed seeds, then restores the previous sampling setting. These eleven rows illustrate model comparison, not a reliable independent prediction assessment. A larger simulated example later separates selection from final evaluation. Use the following as provided setup. In this toy example `x2` is constructed from the response `y`; do not do that when building a real predictor for an unknown response:


``` r
previous_sample_kind <- RNGkind()[3]
# Reproduce only the historical toy data with the pre-R-3.6 sampling rule.
suppressWarnings(RNGkind(sample.kind = "Rounding"))
y <- anscombe$y1
x1 <- anscombe$x1
lmod <- lm(y~x1)

set.seed(5)
x2 <- lmod$model$y - lmod$fitted.values * sample(seq(-1, 0, 0.1), nrow(anscombe))
set.seed(2)
x3 <- anscombe$x3 + sample(seq(-1, 1, 0.1), nrow(anscombe))
set.seed(3)
x4 <- anscombe$x4 + sample(seq(-1, 1, 0.1), nrow(anscombe))

df <- data.frame(y = y,
                 x1 = x1,
                 x2 = x2,
                 x3 = x3,
                 x4 = x4)
RNGkind(sample.kind = previous_sample_kind)
```

## Multiple linear regression model

Adding a predictor to the formula gives it its own slope. The usual residual assumptions from Unit 05 still apply.


``` r
lmod <- lm(y ~ x2 + x1, data = df)
summary(lmod)$coefficients
```

```
##              Estimate Std. Error  t value   Pr(>|t|)
## (Intercept) 2.0979017  1.1869105 1.767531 0.11511842
## x2          0.2022383  0.1277803 1.582704 0.15214663
## x1          0.3480164  0.1454046 2.393434 0.04362144
```

Each coefficient test in `summary()` concerns that predictor **while holding the other predictors fixed**. In contrast, `anova()` on a single fitted model tests additions in formula order. Compare:


``` r
anova(lmod)
```

```
## Analysis of Variance Table
##
## Response: y
##           Df Sum Sq Mean Sq F value   Pr(>F)
## x2         1 23.287 23.2867 17.7746 0.002932 **
## x1         1  7.505  7.5050  5.7285 0.043621 *
## Residuals  8 10.481  1.3101
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

``` r
anova(lm(y ~ x1 + x2, data = df))
```

```
## Analysis of Variance Table
##
## Response: y
##           Df  Sum Sq Mean Sq F value   Pr(>F)
## x1         1 27.5100 27.5100  20.998 0.001796 **
## x2         1  3.2818  3.2818   2.505 0.152147
## Residuals  8 10.4809  1.3101
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

The second predictor is tested after accounting for the first. Reversing their order can therefore change these sequential tests, even though the fitted predictions are the same. We will use the specified model-comparison score, rather than these sequential p-values, to select predictors.

## Compare models on the same observations

AIC and cross-validation scores can compare predictor sets only when the comparison uses the same response observations. Before selection, choose the response and full candidate set and prepare **one common complete-case dataset** for them. Do not allow `lm()` to silently drop a different set of rows for each formula. The functions below require complete values in their supplied response and predictors; the caller keeps the same prepared rows throughout selection.

For the crop assignment, use the defined 2014 district cohort and keep only rows complete across `Winter_wheat` and the nine other crop yields. Report the exclusions. This makes comparisons consistent, but complete-case results apply to the retained records and may be biased if missingness is systematic. IDs, years and source-symbol records are not yield predictors; `Winter_wheat` must never appear among its own predictors.

## Recursive feature selection

Backward selection starts with all candidate predictors and tries removing one at a time. It uses the same compare-and-stop idea. We concentrate on forward selection below; implementing a backward search is not needed for Assignment 07.

## Forward feature selection
First compare an **intercept-only baseline** with two possible first additions. `y ~ 1` predicts the same fitted mean for every observation. `AIC()` can compare several fitted models at once:


``` r
baseline <- lm(y ~ 1, data = df)
with_x1 <- lm(y ~ x1, data = df)
with_x2 <- lm(y ~ x2, data = df)
AIC(baseline, with_x1, with_x2)
```

```
##          df      AIC
## baseline  2 49.76201
## with_x1   3 39.68137
## with_x2   3 42.62529
```

`with_x1` has the lowest AIC here, so add `x1`. At the next step compare `y ~ x1` with models that each add one remaining predictor. Keep the current model if none improves AIC.

The provided helper repeats this comparison for a supplied candidate list. It takes the data, response name, remaining predictor names and already selected names. It returns **one name to add**, or `character(0)` (an empty character vector) to signal **stop**. Read its comparison and stopping rule; the formula-building and input checks are supporting code. `as.formula()` converts the assembled text to a model formula, and `setdiff()` removes names already selected.


``` r
forward_feature_selection <- function(data, dep, vars, selected_vars = NULL) {
  stopifnot(all(complete.cases(data[c(dep, selected_vars, vars)])))
  vars <- setdiff(vars, selected_vars)
  if (length(vars) == 0) return(character(0))

  candidates <- c(list(selected_vars),
                  lapply(vars, function(v) c(selected_vars, v)))
  scores <- lapply(candidates, function(v) {
    rhs <- if (length(v) == 0) "1" else paste(v, collapse = " + ")
    fit <- lm(as.formula(paste(dep, "~", rhs)), data = data)
    c(Adj_R_sqrd = summary(fit)$adj.r.squared, AIC = AIC(fit))
  })
  scores <- as.data.frame(do.call(rbind, scores))
  label <- if (length(selected_vars) == 0) "intercept only" else
    paste0("all: ", paste(selected_vars, collapse = ", "))
  print(data.frame(Variable = c(label, vars), round(scores, 4)))

  best <- which.min(scores$AIC)
  if (scores$AIC[best] >= scores$AIC[1] - 1e-8) return(character(0))
  vars[best - 1L]
}
```

For the first call, all explanatory variables x1 to x4 will be passed to the above function:


``` r
next_vars <- c("x1", "x2", "x3", "x4")
act_var <- forward_feature_selection(data = df, dep = "y", vars = next_vars)
```

```
##         Variable Adj_R_sqrd     AIC
## 1 intercept only     0.0000 49.7620
## 2             x1     0.6295 39.6814
## 3             x2     0.5158 42.6253
## 4             x3     0.5819 41.0108
## 5             x4     0.1987 48.1661
```


Please note that this time, the variable column does not indicate which variable has been left out but which one has been included.
Here, x1 gives the lowest AIC, improving on the intercept-only baseline. Hence, during the next run, x1 will be included into all models and x2 to x4 will be iterated.
Technically, this is realized by excluding x1 from the variable `next_vars` and adding it to the variable `selected_vars`.


``` r
next_vars <- setdiff(next_vars, act_var)
selected_vars <- act_var
act_var <- forward_feature_selection(data = df, dep = "y", vars = next_vars,
                                     selected_vars = selected_vars)
```

```
##   Variable Adj_R_sqrd     AIC
## 1  all: x1     0.6295 39.6814
## 2       x2     0.6826 38.6849
## 3       x3     0.5939 41.3942
## 4       x4     0.6067 41.0438
```


If x1 is already included in the model, adding x2 increases the model performance as documented by the increase in the adjusted r squared or the decrease in AIC.
Hence, x2 is added to the baseline model formula for the next run:


``` r
next_vars <- setdiff(next_vars, act_var)
selected_vars <- c(selected_vars, act_var)
act_var <- forward_feature_selection(data = df, dep = "y", vars = next_vars,
                                     selected_vars = selected_vars)
```

```
##      Variable Adj_R_sqrd     AIC
## 1 all: x1, x2     0.6826 38.6849
## 2          x3     0.6410 40.5699
## 3          x4     0.6728 39.5482
```


Neither remaining addition improves AIC, so `act_var` is now `character(0)`, the stop signal. Retain `selected_vars`, which contains x1 and x2. The helper prefers the current model when AIC is tied within the stated tolerance; a tie between improving candidates is resolved by their input order. Candidate choice uses unrounded AIC values.

## Which feature selection to choose?

Backward and forward selection are greedy searches: each step takes the best available deletion or addition under the chosen criterion. They can reach different predictor sets, and neither guarantees the globally best model or protects against overfitting.

Highly correlated predictors can make the selected set unstable. Any screening based on the data belongs inside the model-development process, before the independent final test. Do not interpret ordinary post-selection coefficient p-values as if the predictor set had been specified in advance.

## Compare candidates with four-fold validation

The preceding helper uses AIC. For a cross-validation criterion, replace candidate AIC scoring with held-out RMSE. The [four-fold example in Unit 06]({{ site.baseurl }}/unit06/unit06-02_cross_validation.html#four-fold-cross-validation) showed the partition and aggregation. Here we wrap that calculation in a function and compare just two specified candidate formulas; extending the selection loop is your assignment.

To make the selection/evaluation distinction visible, generate a larger independent synthetic sample. First reserve 20% as a final test set. All candidate comparison uses the remaining development data:


``` r
RNGkind(sample.kind = "Rejection")
set.seed(70)
selection_data <- data.frame(x1 = rnorm(100), x2 = rnorm(100))
selection_data$y <- 3 + 2 * selection_data$x1 + rnorm(100)

development_id <- sample(seq_len(nrow(selection_data)), 80)
development <- selection_data[development_id, ]
final_test <- selection_data[-development_id, ]
fold_id <- sample(rep(seq_len(4), length.out = nrow(development)))
table(fold_id)
```

```
## fold_id
##  1  2  3  4
## 20 20 20 20
```

The following scorer is provided for reuse; you do not need to reproduce its input checks. It gives each development observation exactly one held-out prediction and returns one pooled RMSE across the four folds. It requires a common complete dataset and four valid, nonempty folds; the caller creates the fold vector once and reuses it for every candidate.


``` r
four_fold_rmse <- function(data, formula, fold_id) {
  stopifnot(length(fold_id) == nrow(data),
            !anyNA(fold_id), setequal(unique(fold_id), seq_len(4)),
            all(complete.cases(model.frame(formula, data, na.action = na.pass))))
  predictions <- lapply(seq_len(4), function(k) {
    test_id <- which(fold_id == k)
    fit <- lm(formula, data = data[-test_id, ], na.action = na.fail)
    observed <- model.response(model.frame(formula, data[test_id, ]))
    predicted <- predict(fit, newdata = data[test_id, ])
    data.frame(row_id = test_id, error = predicted - observed)
  })
  predictions <- do.call(rbind, predictions)
  sqrt(mean(predictions$error^2))
}

candidate_formulas <- list(y ~ x1, y ~ x1 + x2)
candidate_rmse <- unlist(lapply(candidate_formulas, function(f) {
  four_fold_rmse(development, f, fold_id)
}))
data.frame(candidate = c("x1", "x1 + x2"),
           selection_RMSE = round(candidate_rmse, 3))
```

```
##   candidate selection_RMSE
## 1        x1          0.880
## 2   x1 + x2          0.891
```

In Assignment 07, your independent task is to implement the repeated forward-selection loop with the two requested scoring options: AIC and four-fold RMSE. This example supplies a single AIC step and a reusable RMSE scorer, not the complete assignment loop.

The smaller score chooses between these candidates. Keep the same folds and rows for every predictor combination throughout a selection path so that changing partitions or missing values do not confound the comparison. Keep an intercept-only baseline and stop when no addition improves the chosen criterion.

## Keep final evaluation independent

Once validation scores have helped choose predictors, the best of those scores is a **selection score**. It is not an independent assessment of the chosen model: the choice has used that validation information.

Freeze the selected formula, fit it on all development observations, and evaluate it once on the reserved final test observations:


``` r
selected_formula <- candidate_formulas[[which.min(candidate_rmse)]]
final_model <- lm(selected_formula, data = development)
final_pred <- predict(final_model, newdata = final_test)
final_test_rmse <- sqrt(mean((final_pred - final_test$y)^2))
cat("Selected formula:", deparse(selected_formula), "\n")
```

```
## Selected formula: y ~ x1
```

``` r
round(final_test_rmse, 3)
```

```
## [1] 0.806
```

``` r
plot(final_test$y, final_pred, xlab = "Observed final-test response",
     ylab = "Final-test prediction", asp = 1)
abline(0, 1, col = "red")
```

![Observed versus predicted responses for the untouched synthetic final test set, with a diagonal reference line for perfect prediction.]({{ site.baseurl }}/assets/images/rmd_images/e07-02/final-evaluation-1.png)

Do not use this final score to change the formula or keep trying splits. If that happens, the test set becomes part of development and a new independent evaluation is needed. The [cross-validation guide](https://scikit-learn.org/stable/modules/cross_validation.html#cross-validation) explains the distinction between validation for model choice and a reserved final test.

In Assignment 07, label the reported AIC or four-fold RMSE as the **selection criterion**. The requested performance trajectory and final selected-model score describe the selection exercise; a separate final-test submission is not required. Do not present the minimum selection RMSE as independent predictive performance. Random district folds within 2014 do not assess transfer to another region or future year.
