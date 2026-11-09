---
title: "Example: Simple Bivariate Linear Regression"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/linear_5_1.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Linear regression modeling is one of the more common tasks in data analysis and the following example will cover the very basic topic of bivariate linear regression. The storyline follows the one from Zuur et al. (2007) to a certain degree.

While one could use actual data sets, we keep it controlled by using an artificial data set originally compiled by [Francis Anscombe](https://en.wikipedia.org/wiki/Anscombe%27s_quartet).
The [anscombe dataset](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/anscombe.html) comes as part of base R.
For now, we will use x1 as independent variable and y1 as dependent variable.


``` r
ind <- anscombe$x1
dep <- anscombe$y1

par_org <- par(no.readonly = TRUE)
par(mfrow = c(1,2))
hist(ind, main = "Independent variable")
hist(dep, main = "Dependent variable")
```

![Histograms of the predictor and response in the first Anscombe dataset; the predictor spans about 4 to 14 and the response about 4 to 11.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/unnamed-chunk-1-1.png)


A look at the relationship between the variables by using a scatterplot justifies a linear modeling attempt. Fitting a bivariate linear model to the data set would result in the function shown in the plot and visualized by the red line.

In `lm(dep ~ ind)`, the response `dep` is modeled using the predictor `ind`. The **intercept** is the fitted mean response at a predictor value of zero. The **slope** is the change in that fitted mean for a one-unit increase in the predictor. **Least squares** chooses the line with the smallest sum of squared vertical residuals.

`abline()` adds the fitted line to the scatterplot; `text()` labels it with the rounded intercept and slope. These functions are included with R, so no additional package is needed.


``` r
par(par_org)
plot(ind, dep)

lmod <- lm(dep ~ ind) # Compute linear regression model

abline(lmod, col = "red") # Add the fitted line using base R
text(10, 6, paste("Fitted y =", round(lmod$coefficients[1], 3),
                  "+", round(lmod$coefficients[2], 3), "* x"))
```

![First Anscombe dataset with an upward-sloping fitted line; points scatter around y = 3 + 0.5 x.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/unnamed-chunk-2-1.png)


Here the fitted line is approximately **y = 3 + 0.5x**: increasing x by one increases the fitted mean y by 0.5. The intercept is about 3, but x = 0 is outside the observed range of 4–14, so it is not a case represented in these data. Check your understanding: how much does the fitted mean change when x increases by two?

Under suitable model assumptions, an analysis of variance (ANOVA) can assess evidence against a zero slope. This test does not check all those assumptions or establish a causal relationship. We calculate the summaries first, then use the separate [assumptions walkthrough]({{ site.baseurl }}/unit05/unit05-03a_assumptions.html) to judge how cautiously they should be interpreted.


### Testing a linear regression relationship by an analysis of variance

A **residual** is the observed response minus its fitted value. It is the vertical distance from a point to the fitted line. Let's start with the ANOVA. Here we divide the variation in the response into variation described by the fitted line and variation left in the residuals.

Given a (linear) model, each actual data value can be calculated by adding the fitted value and the corresponding residual value:

data value = fitted value + residual value (or y = y' + res)

The corresponding differences are:

* **Observed differences:** each observed y minus the mean response, describing total variation.
* **Model differences:** each fitted y' minus the mean response, describing variation explained by the model.
* **Residual differences:** each observed y minus its fitted y', describing the remaining variation.

Square the differences and sum them to obtain the total, model and residual sums of squares. For this ordinary least-squares model with an intercept, the model and residual sums of squares add to the total sum of squares.

Calculate the sums of squares using the observed responses and fitted values stored in `lmod`:



``` r
ss_obsrv <- sum((lmod$model$dep - mean(lmod$model$dep))**2)
ss_model <- sum((lmod$fitted.values - mean(lmod$model$dep))**2)
ss_resid <- sum((lmod$model$dep - lmod$fitted.values)**2)
```

Divide each sum of squares by its **degrees of freedom** (df) to obtain its **mean square**. Degrees of freedom count how many pieces of information can vary independently after accounting for what we have estimated from the data. Here `n` is the number of observations; the first Anscombe dataset has **11 pairs**.

- **Total variation: `n - 1` = 10 df.** We measure each response's distance from the sample mean. Because that mean was calculated from the same responses, these differences must add to zero. Once ten differences are known, the eleventh is fixed: it must cancel their sum. Estimating the mean therefore leaves ten freely varying differences.
- **Model variation: 1 df.** A horizontal line at the sample mean already estimates one quantity: the mean response. Our regression estimates two quantities, the intercept and slope. Allowing the line to slope adds **one** adjustable quantity compared with that horizontal line. The model sum of squares measures the extra variation described by this addition, so its divisor is one.
- **Residual variation: `n - 2` = 9 df.** The fitted line uses the same eleven observations to estimate both its intercept and its slope. Accounting for these two estimated quantities leaves nine degrees of freedom for the variation around the line. All eleven observations still contribute to the fit; dividing by nine accounts for having estimated the line from them.

The degrees of freedom follow the same split as the sums of squares: **total = model + residual**, here **10 = 1 + 9**. We therefore divide the total, model and residual sums of squares by 10, 1 and 9, respectively:


``` r
mss_obsrv <- ss_obsrv / (length(lmod$model$dep) - 1)
mss_model <- ss_model / 1
mss_resid <- ss_resid / (length(lmod$model$dep) - 2)
```

Under the zero-slope null hypothesis and the usual model assumptions, both the model and residual mean squares estimate the error variance. Their ratio follows an F distribution; it is not exactly one in every sample. A systematic relationship can make the model mean square larger relative to the residual mean square.

This provides us with the test statistic for the *null-hypothesis* that the true slope is not different from 0.


``` r
f_value <- mss_model / mss_resid
```

The F-statistic compares the model **mean square** with the residual **mean square**. A large value is evidence against a zero slope under the stated assumptions. It does not measure the fraction of variation explained; R² answers that question below.

The **p-value** is the probability of an F-statistic at least this large if the true slope is zero and the model assumptions hold. We calculate it using an F distribution with 1 numerator degree of freedom and (number of observations - 2) denominator degrees of freedom. A small p-value is evidence against a zero slope; it is not the probability that the model is correct.


``` r
p_value <- pf(f_value, 1, length(dep) - 2, lower.tail = FALSE)
```

The built-in `anova()` function assembles the result in one table. The F statistic and its p-value belong to the predictor row; there is no separate F test for the residual row:


``` r
anova(lmod)
```

```
## Analysis of Variance Table
##
## Response: dep
##           Df Sum Sq Mean Sq F value  Pr(>F)
## ind        1 27.510 27.5100   17.99 0.00217 **
## Residuals  9 13.763  1.5292
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```


### Exercise: Recreate the regression plot

Recreate the **blue fitted line and red residual segments** in the graphic on the [basic-idea page]({{ site.baseurl }}/unit05/unit05-02_basic_idea_of_modelling.html#basic-idea-of-statistical-modeling), using `ind`, `dep` and `lmod` from this example. Develop your own plotting code: show the observations, the fitted line and a vertical segment from each fitted value to its observed value. You do not need to reproduce the equation label or exact formatting.

Hint: `segments(x0, y0, x1, y1)` joins start and end coordinates. For vertical residuals, both x coordinates are `ind`; the y coordinates are `fitted(lmod)` and `dep`. Explain which segments would contribute most to the residual sum of squares and why.
{: .notice--success}

<!--
### Testing a linear regression relationship by a t-test

For simple linear bivariate regressions, a t-test can be used as an alternative to test if the true slope is not different from 0.
Therefore, one needs to calculate the standard error of the slope which follows from the residual standard error by:


``` r
sdt_error_slope <- sqrt(length(lmod$model$dep) * mss_resid / (length(lmod$model$dep) * sum(lmod$model$ind**2) - sum(lmod$model$ind)**2))
```

The test statistics would be


``` r
lmod$coefficients[2] / sdt_error_slope
```

```
##      ind
## 4.241455
```


which is exactly what one finds in the summary statistics of the linear model:


``` r
summary(lmod)
```

```
##
## Call:
## lm(formula = dep ~ ind)
##
## Residuals:
##      Min       1Q   Median       3Q      Max
## -1.92127 -0.45577 -0.04136  0.70941  1.83882
##
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)   3.0001     1.1247   2.667  0.02573 *
## ind           0.5001     0.1179   4.241  0.00217 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 1.237 on 9 degrees of freedom
## Multiple R-squared:  0.6665,	Adjusted R-squared:  0.6295
## F-statistic: 17.99 on 1 and 9 DF,  p-value: 0.00217
```

-->

### R squared

The variance explained by the model is one of the most often used variables to explain the relationship in simple linear models. It is computed by normalizing either the model sum of squares by the observed sum of squares or by subtracting the normalization of the residual sum of squares from 1.


``` r
ss_model / ss_obsrv
```

```
## [1] 0.6665425
```



``` r
1 - ss_resid / ss_obsrv
```

```
## [1] 0.6665425
```



This R squared describes the fraction of observed response variation accounted for in the fitting data. For a comparison with held-out RMSE and AIC, see [which measure answers which question in Unit 07]({{ site.baseurl }}/unit07/unit07-02_variable_selection.html#which-measure-answers-which-question).






### Finished?
The fitted line accounts for about 67% of the observed response variation. Is that enough to trust the model? R² alone cannot tell us whether a straight line is appropriate.

Before we clap our hands, let's just have a look at the other variable combinations of the Anscombe data set.


``` r
par(mfrow = c(2,2))
for(i in seq(4)){
  plot(anscombe[, i], anscombe[, i+4],
       xlab = names(anscombe[i]), ylab = names(anscombe[i+4]))
}
```

![Anscombe quartet: approximately linear points, a curved relationship, one response outlier, and a cluster with one high-leverage point.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/unnamed-chunk-12-1.png)


Reading the panels from top left to bottom right: the first dataset is approximately linear; the second follows a curve; the third is approximately linear apart from one unusually high response; and the fourth has nearly all predictor values at the same position, with one point far to the right. These different patterns explain why similar regression summaries do not replace inspecting the observations.

Investigate the unusual observation in dataset three against its source and context before considering any exclusion. Dataset two shows curvature, while dataset four relies heavily on one isolated predictor value. Despite these differences, all four fits have almost the same intercept, slope and R²:


``` r
lmodels <- lapply(seq(4), function(i){
  lm(anscombe[, i+4] ~ anscombe[, i])
})
data.frame(
  Dataset = 1:4,
  Intercept = unlist(lapply(lmodels, function(model) coef(model)[1])),
  Slope = unlist(lapply(lmodels, function(model) coef(model)[2])),
  R_squared = unlist(lapply(lmodels, function(model) summary(model)$r.squared))
)
```

```
##   Dataset Intercept     Slope R_squared
## 1       1  3.000091 0.5000909 0.6665425
## 2       2  3.000909 0.5000000 0.6662420
## 3       3  3.002455 0.4997273 0.6663240
## 4       4  3.001727 0.4999091 0.6667073
```


So be careful when interpreting p and R-squared values!
We will learn how to treat non-linear relationships in the subsequent units.
{: .notice--info}


``` r
par(par_org)
```

## Continue with model checking

The Anscombe examples show why similar regression summaries are not enough. Next, work through [Checking Regression Assumptions]({{ site.baseurl }}/unit05/unit05-03a_assumptions.html) for residual plots, the graphical plausibility check, normality-test limitations and possible responses to concerns. That page prepares you for [Assignment 05]({{ site.baseurl }}/unit05/unit05-04_assignment.html).

<span id="minimum-assumptions-for-bivariate-linear-regression-models" hidden></span>
<span id="what-are-we-checking" hidden></span>
<span id="start-with-residuals-versus-fitted-values" hidden></span>
<span id="compare-spread-with-a-scale-location-plot" hidden></span>
<span id="qq-plots" hidden></span>
<span id="use-a-normality-test-as-an-additional-diagnostic" hidden></span>
<span id="investigate-influential-observations" hidden></span>
<span id="transformations" hidden></span>
<span id="additional-views-of-residual-patterns" hidden></span>
<span id="no-alternatives" hidden></span>
<span id="from-diagnostics-to-assignment-05" hidden></span>
<span id="scatterplot-matrix" hidden></span>
<span id="coplot" hidden></span>
<script>
(function () {
  var sections = ["minimum-assumptions-for-bivariate-linear-regression-models", "what-are-we-checking", "start-with-residuals-versus-fitted-values", "compare-spread-with-a-scale-location-plot", "qq-plots", "use-a-normality-test-as-an-additional-diagnostic", "investigate-influential-observations", "transformations", "additional-views-of-residual-patterns", "no-alternatives", "from-diagnostics-to-assignment-05", "scatterplot-matrix", "coplot"];
  var section = window.location.hash.slice(1);
  if (sections.indexOf(section) !== -1) {
    window.location.replace({{ '/unit05/unit05-03a_assumptions.html' | relative_url | jsonify }} + '#' + section);
  }
}());
</script>
