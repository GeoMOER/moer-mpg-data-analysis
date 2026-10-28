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

```r
ind <- anscombe$x1
dep <- anscombe$y1

par_org <- par(no.readonly = TRUE)
par(mfrow = c(1,2))
hist(ind, main = "Independent variable")
hist(dep, main = "Dependent variable")
```

![Histograms of the predictor and response in the first Anscombe dataset; the predictor spans about 4 to 14 and the response about 4 to 11.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/unnamed-chunk-1-1.png)<!-- -->

A look at the relationship between the variables by using a scatterplot justifies a linear modeling attempt. Fitting a bivariate linear model to the data set would result in the function shown in the plot and visualized by the red line.

```r
par(par_org)
plot(ind, dep)

lmod <- lm(dep ~ ind) # Compute linear regression model

abline(lmod, col = "red") # Add the fitted line using base R
text(10, 6, bquote(paste("y"["i"], " = ", .(round(lmod$coefficients[1], 3)),
                          " + ", .(round(lmod$coefficients[2], 3)), "* x"["i"])))
```

![First Anscombe dataset with an upward-sloping fitted line; points scatter around y = 3 + 0.5 x.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/unnamed-chunk-2-1.png)<!-- -->

The fitted line describes the observed relationship. Under suitable model assumptions, an ANOVA or t-test can assess evidence against a zero slope. Neither test checks all those assumptions or establishes a causal relationship. We calculate the summaries first, then use the separate [assumptions walkthrough]({{ site.baseurl }}/unit05/unit05-03a_assumptions.html) to judge how cautiously they should be interpreted.


### Testing a linear regression relationship by an analysis of variance

Let's start with the ANOVA. Here we divide the variation in the response into variation described by the fitted line and variation left in the residuals.

Given a (linear) model, each actual data value can be calculated by adding the fitted value and the corresponding residual value:

data value = fitted value + residual value (or y = y' + res)

The corresponding differences are:

* **Observed differences:** each observed y minus the mean response, describing total variation.
* **Model differences:** each fitted y' minus the mean response, describing variation explained by the model.
* **Residual differences:** each observed y minus its fitted y', describing the remaining variation.

Square the differences and sum them to obtain the total, model and residual sums of squares. For this ordinary least-squares model with an intercept, the model and residual sums of squares add to the total sum of squares.

In order to calculate the variances, one can use the lm class of the model since - among others - it contains the original independent and dependent values as well as the predicted ones:


```r
ss_obsrv <- sum((lmod$model$dep - mean(lmod$model$dep))**2)
ss_model <- sum((lmod$fitted.values - mean(lmod$model$dep))**2)
ss_resid <- sum((lmod$model$dep - lmod$fitted.values)**2)
```

Since the sum increases with increasing numbers of observations, the resulting sums of squares are normalized by the respective degrees of freedom. This gives us:
* the mean observed sum of squares
* the mean model sum of squares
* the mean residual sum of squares, i.e. the mean squared error if the model is a simple linear regression model.


```r
mss_obsrv <- ss_obsrv / (length(lmod$model$dep) - 1)
mss_model <- ss_model / 1
mss_resid <- ss_resid / (length(lmod$model$dep) - 2)
```

Under the zero-slope null hypothesis and the usual model assumptions, both the model and residual mean squares estimate the error variance. Their ratio fluctuates around a reference distribution; it is not exactly one in every sample. A systematic relationship can make the model mean square larger relative to the residual mean square.

This provides us with the test statistic for the *null-hypothesis* that the true slope is not different from 0.

```r
f_value <- mss_model / mss_resid
```

The F-statistic quantifies how much larger the variation explained by the model is compared to the variation left unexplained (residuals).
* A large F value indicates that the model explains a lot more variation than is left unexplained, suggesting that the slope is likely not 0.
* A small F value indicates that the model doesn't explain much more variation than the residuals, suggesting that the slope might be 0.

By comparing the computed F value to an F distribution with 1 numerator degree of freedom and (number of observations - 2) denominator degrees of freedom, the p value is determined. If the p value is very small, the null-hypothesis can be rejected.

```r
p_value <- pf(f_value, 1, length(dep) - 2, lower.tail = FALSE)
```

In summary, this gives us the following:

```r
data.frame(Name = c("ind", "residuals"),
           Deg_of_freedom = c(1, length(lmod$model$dep) - 2),
           Sum_of_squares = c(ss_model, ss_resid),
           Mean_sum_of_squares = c(mss_model, mss_resid),
           F_value = f_value,
           p_value = p_value)
```

```
##        Name Deg_of_freedom Sum_of_squares Mean_sum_of_squares  F_value
## 1       ind              1       27.51000           27.510001 17.98994
## 2 residuals              9       13.76269            1.529188 17.98994
##       p_value
## 1 0.002169629
## 2 0.002169629
```

Of course, one does not have to compute this every time. A simple call to the anova function will do it:

```r
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

Now you can check your knowledge and strengthen your plotting skills by writing code to rebuild the linear regression scatterplot from the previous page.
When coding, think about the meaning of slope, intercept, observed variance, model variance, residual variance, and the different types of sums of squares.
{: .notice--success}


<!--
### Testing a linear regression relationship by a t-test

For simple linear bivariate regressions, a t-test can be used as an alternative to test if the true slope is not different from 0.
Therefore, one needs to calculate the standard error of the slope which follows from the residual standard error by:

```r
sdt_error_slope <- sqrt(length(lmod$model$dep) * mss_resid / (length(lmod$model$dep) * sum(lmod$model$ind**2) - sum(lmod$model$ind)**2))
```

The test statistics would be

```r
lmod$coefficients[2] / sdt_error_slope
```

```
##      ind
## 4.241455
```

which is exactly what one finds in the summary statistics of the linear model:

```r
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

```r
ss_model / ss_obsrv
```

```
## [1] 0.6665425
```

```r
1 - ss_resid / ss_obsrv
```

```
## [1] 0.6665425
```


This R squared describes the fraction of observed response variation accounted for in the fitting data. For a comparison with held-out RMSE and AIC, see [which measure answers which question in Unit 07]({{ site.baseurl }}/unit07/unit07-02_variable_selection.html#which-measure-answers-which-question).

**Convention**. p and r-squared often denote results of bivariate linear regressions while P and R-squared (capital letters) often denote results of multiple linear regressions.
The letters *p* (*P*) and *r<sup>2</sup>* (*R*<sup>2</sup>) are often written in *italics*.
{: .notice--info}




### Finished?
Well, the above looks like a really good example of linear regression analysis, right? And the r-squared of about 0.67 is also quite OK not to mention the significance of the independent variable.

Before we clap our hands, let's just have a look at the other variable combinations of the Anscombe data set.

```r
par(mfrow = c(2,2))
for(i in seq(4)){
  plot(anscombe[, i], anscombe[, i+4],
       xlab = names(anscombe[i]), ylab = names(anscombe[i+4]))
}
```

![Anscombe quartet: approximately linear points, a curved relationship, one response outlier, and a cluster with one high-leverage point.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/unnamed-chunk-12-1.png)<!-- -->

Reading the panels from top left to bottom right: the first dataset is approximately linear; the second follows a curve; the third is approximately linear apart from one unusually high response; and the fourth has nearly all predictor values at the same position, with one point far to the right. These different patterns explain why similar regression summaries do not replace inspecting the observations.

While x3/y3 might still justify a linear regression if we remove the outlier, the two plots on the right side do not. So what to do? Unfortunately, all of these data combinations result in almost the same regression statistics:

```r
lmodels <- lapply(seq(4), function(i){
  lm(anscombe[, i+4] ~ anscombe[, i])
})
lapply(lmodels, summary)
```

```
## [[1]]
##
## Call:
## lm(formula = anscombe[, i + 4] ~ anscombe[, i])
##
## Residuals:
##      Min       1Q   Median       3Q      Max
## -1.92127 -0.45577 -0.04136  0.70941  1.83882
##
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)
## (Intercept)     3.0001     1.1247   2.667  0.02573 *
## anscombe[, i]   0.5001     0.1179   4.241  0.00217 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 1.237 on 9 degrees of freedom
## Multiple R-squared:  0.6665,	Adjusted R-squared:  0.6295
## F-statistic: 17.99 on 1 and 9 DF,  p-value: 0.00217
##
##
## [[2]]
##
## Call:
## lm(formula = anscombe[, i + 4] ~ anscombe[, i])
##
## Residuals:
##     Min      1Q  Median      3Q     Max
## -1.9009 -0.7609  0.1291  0.9491  1.2691
##
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)
## (Intercept)      3.001      1.125   2.667  0.02576 *
## anscombe[, i]    0.500      0.118   4.239  0.00218 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 1.237 on 9 degrees of freedom
## Multiple R-squared:  0.6662,	Adjusted R-squared:  0.6292
## F-statistic: 17.97 on 1 and 9 DF,  p-value: 0.002179
##
##
## [[3]]
##
## Call:
## lm(formula = anscombe[, i + 4] ~ anscombe[, i])
##
## Residuals:
##     Min      1Q  Median      3Q     Max
## -1.1586 -0.6146 -0.2303  0.1540  3.2411
##
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)
## (Intercept)     3.0025     1.1245   2.670  0.02562 *
## anscombe[, i]   0.4997     0.1179   4.239  0.00218 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 1.236 on 9 degrees of freedom
## Multiple R-squared:  0.6663,	Adjusted R-squared:  0.6292
## F-statistic: 17.97 on 1 and 9 DF,  p-value: 0.002176
##
##
## [[4]]
##
## Call:
## lm(formula = anscombe[, i + 4] ~ anscombe[, i])
##
## Residuals:
##    Min     1Q Median     3Q    Max
## -1.751 -0.831  0.000  0.809  1.839
##
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)
## (Intercept)     3.0017     1.1239   2.671  0.02559 *
## anscombe[, i]   0.4999     0.1178   4.243  0.00216 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 1.236 on 9 degrees of freedom
## Multiple R-squared:  0.6667,	Adjusted R-squared:  0.6297
## F-statistic:    18 on 1 and 9 DF,  p-value: 0.002165
```

So be careful when interpreting p and R-squared values!
We will learn how to treat non-linear relationships in the subsequent units.
{: .notice--info}

```r
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
