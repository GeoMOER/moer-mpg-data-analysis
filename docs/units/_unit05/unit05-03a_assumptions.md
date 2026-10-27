---
title: "Checking Regression Assumptions"
toc: true
toc_label: On this page
header:
  image: "/assets/images/teaser/linear_5_1.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

After fitting a regression, check whether its assumptions are a reasonable description of the observations. This page continues the [Anscombe regression example]({{ site.baseurl }}/unit05/unit05-03_linear_regression.html) and leads to [Assignment 05]({{ site.baseurl }}/unit05/unit05-04_assignment.html). QQ plots concern the fitted model's residuals; transformations are followed by a new fit and another diagnostic check.

## Recreate the example models

The `anscombe` dataset is included with R. The following code recreates the first fitted model (`lmod`) and all four models (`lmodels`), so the page also works in a fresh R session without additional downloads:

```r
ind <- anscombe$x1
dep <- anscombe$y1
lmod <- lm(dep ~ ind)
lmodels <- lapply(seq(4), function(i) {
  lm(anscombe[, i+4] ~ anscombe[, i])
})
par_org <- par(no.readonly = TRUE)
```

## Minimum assumptions for bivariate linear regression models {#minimum-assumptions-for-bivariate-linear-regression-models}

Similar coefficients, p-values and R-squared values can describe very different patterns. Before interpreting a fitted model, ask whether a straight line and its uncertainty calculations are a reasonable description of these observations.

We start with a **graphical plausibility check**: describe patterns, consider their possible causes and record what remains uncertain. A reassuring plot supports a model; it does not prove that all assumptions hold.

### What are we checking?

A residual is the observed response minus its fitted value: **residual = observed − fitted**. Positive residuals lie above the fitted line; negative residuals lie below it. The model's errors are unobserved. Residuals are estimates that help us examine them.

```r
diagnostics <- data.frame(
  Predictor = ind,
  Fitted = fitted(lmod),
  Residual = residuals(lmod)
)
head(diagnostics, 3)
```

The assumptions concern the errors around the conditional mean relationship. **Neither the predictor nor the pooled response has to follow a normal distribution.** A histogram or QQ plot of raw land-use percentages therefore does not check the normality assumption of a regression fitted to those percentages.

| Question | Useful starting point | What would need attention? |
|---|---|---|
| Is a straight line adequate for the mean relationship? | Scatterplot and residuals versus fitted values or predictor. | A curve or another systematic residual pattern. |
| Is the error spread roughly constant (homoscedasticity)? | Residuals versus fitted values and scale-location plot. | A clear widening/narrowing of the residual band. |
| Is a normal-error approximation plausible for the usual small-sample t/F tests and intervals? | Normal QQ plot of residuals. | Strong curvature, pronounced tails or isolated extreme points. |
| Are observations reasonably independent for the analysis? | Sampling design, region/year identifiers and meaningful time/group information. | Repeated observations, overlapping areas or temporal/spatial dependence. |
| Does one observation dominate the fitted line? | Original scatterplot, leverage and Cook's distance. | An isolated predictor value or a strongly influential observation. |

Check the mean pattern before interpreting the spread or QQ plot. A misspecified mean can leave structure in the residuals that should not be explained away as a distribution problem. Independence also needs information about how the data were collected; a QQ plot cannot establish it.

### Start with residuals versus fitted values

```r
par(par_org)
par(mfrow = c(2,2))
for(i in seq(4)){
  plot(lmodels[[i]], which = 1)
}
```

![Residual-versus-fitted plots for the four Anscombe datasets; the second shows curvature and the third highlights one large residual.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/unnamed-chunk-14-1.png)

Look for a band around zero without a clear curve. Compare the vertical spread across the horizontal axis. A curved trend suggests a problem with the mean relationship; a fan-shaped band suggests changing spread. They are different questions, even though one graph helps with both.

In the second Anscombe dataset, the residual curve makes the straight-line mean questionable. The third has one conspicuous residual. The first is more compatible with a straight-line description, but eleven observations provide limited evidence. In the fourth, one isolated predictor value has a strong role in determining the line.

### Compare spread with a scale-location plot

```r
par(mfrow = c(2,2))
for(i in seq(4)){
  plot(lmodels[[i]], which = 3)
}
```

![Scale-location plots for the Anscombe quartet compare the spread of standardized residuals across fitted values.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/unnamed-chunk-15-1.png)

`which = 3` plots the square root of the absolute standardized residual against the fitted value. Standardization accounts for the estimated error scale and leverage. A roughly level trend with similar spread is reassuring; a marked trend calls for investigation. These are diagnostic scales: the original response and fitted model have not been transformed.

For the fourth dataset, R can warn that a leverage-one observation is omitted from standardized diagnostic plots. That observation alone determines the fitted value at its predictor position, making its standardized residual undefined. The warning is useful evidence of the unusual design; an apparently quiet remaining plot does not resolve that problem.

### Read a residual QQ plot {#qq-plots}

A normal QQ plot compares ordered residuals with theoretical normal quantiles. Approximate alignment with a straight reference line is compatible with a normal-error approximation. Strong curvature or isolated tail points deserve attention. Small departures are expected, especially with few observations.

```r
par(mfrow = c(2,2))
for(i in seq(4)){
  plot(lmodels[[i]], which = 2)
}
```

![Normal QQ plots for the four Anscombe regression models show different residual patterns despite their similar summary statistics.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/unnamed-chunk-16-1.png)

```r
par(par_org)
```

`plot(model, which = 2)` uses standardized residuals. The marked departure in the third dataset is consistent with the unusual observation already seen in the scatterplot. Interpret the QQ plot together with those other views. A straight QQ pattern would not repair the curved mean in dataset two or the isolated predictor in dataset four.

To connect this plot with the simpler distribution plots from Unit 03, inspect one model directly:

```r
standardized_residuals <- rstandard(lmod)
old_par <- par(no.readonly = TRUE)
par(mfrow = c(1, 2))
hist(standardized_residuals, main = "Residual distribution",
     xlab = "Standardized residual")
qqnorm(standardized_residuals, main = "Residual normal QQ plot")
qqline(standardized_residuals, col = "red", lwd = 2)
par(old_par)
```

![Histogram and normal QQ plot of standardized residuals from the first Anscombe model; both show only eleven observations.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/minimum-residual-overview-1.png)

The histogram gives a rough view of the shape; the QQ plot makes the normal reference explicit. With eleven residuals, neither provides a detailed description of the underlying error distribution. The red QQ line is a reference for residual quantiles, not the regression line relating the predictor to the response.

### Use a normality test as an additional diagnostic

The Shapiro–Wilk test has a normal-distribution null hypothesis. A small p-value is evidence against that hypothesis; a large p-value does not prove normality. Small samples can hide departures, while large samples can reveal small departures that require a judgment about practical relevance.

```r
normality_p <- unlist(lapply(lmodels, function(model) {
  shapiro.test(residuals(model))$p.value
}))
data.frame(Dataset = 1:4, p_value = normality_p,
           Below_0.05 = normality_p < 0.05)
```

Here only the third dataset falls below 0.05. Yet the second and fourth already raised clear graphical concerns. A normality test answers one narrow question; it cannot certify the model. Fitted residuals also share constraints from the estimated model, so treat these p-values as diagnostic indicators rather than an exact test that all regression assumptions hold.

In Assignment 05 you will repeat this diagnostic for different subsets. The fraction below 0.05 describes sensitivity to those subsets; it is not the probability that the model is wrong. Subsets drawn repeatedly from the same data can overlap and are not independent replications.

### Investigate influential observations

Plot labels identify observations, using the relevant diagnostic to select conspicuous cases. They are not a verdict that a record is erroneous. Cook's distance summarizes how strongly deleting an observation would change the fitted model:

```r
par(mfrow = c(2,2))
for(i in seq(4)){
  plot(lmodels[[i]], which = 4)
}
par(par_org)
```

![Cook distance plots for the Anscombe quartet identify observations with unusually strong influence on the fitted regressions.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/unnamed-chunk-17-1.png)

The isolated predictor in dataset four is an important warning about the information supporting its slope. Check the source and scientific context before excluding any observation; changing a dataset just to obtain a better diagnostic plot needs justification.

### Transformations: refit and check again {#transformations}

If the pattern suggests a different scale, transform an observed variable and **refit the model**, then inspect the new residuals. Transforming residuals alone cannot improve the unchanged model. A transformation also changes the meaning of the relationship and the scale on which errors are described.

The following is a comparison, not an automatic improvement. All response values in the first Anscombe dataset are positive, so a logarithm is defined:

```r
log_model <- lm(log(dep) ~ ind)
old_par <- par(no.readonly = TRUE)
par(mfrow = c(2, 2), oma = c(0, 0, 2, 0))
plot(lmod, which = 1, main = "Original response", sub.caption = "")
plot(log_model, which = 1, main = "Log response", sub.caption = "")
plot(lmod, which = 2, main = "Original response", sub.caption = "")
plot(log_model, which = 2, main = "Log response", sub.caption = "")
par(old_par)
```

![Residual-versus-fitted and normal QQ plots compare models for the original and log-transformed response of the first Anscombe dataset.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/minimum-transformation-refit-1.png)

Compare curvature, spread and tail behavior, then ask whether the log-response model makes sense for the question. There is no need to transform an otherwise adequate relationship merely to increase a normality-test p-value. R-squared values on different response scales are not directly comparable. A curved mean or dependent observations can require a different model or design; transformation is not a universal remedy.

### Additional views of residual patterns

The standard diagnostic plots above are sufficient preparation for Assignment 05. The following two views extend the exploration tools introduced in Unit 03.

**Scatterplot matrix.** Each panel compares a pair of columns. Here the fitted value is a straight-line function of the predictor by construction; that relationship is not a new discovery. Focus on whether the residual panels show a pattern.

<span id="scatterplot-matrix"></span>

```r
plot(diagnostics, pch = 16)
```

![Scatterplot matrix of predictor, fitted values and residuals from the first Anscombe model; fitted values are a linear function of the predictor.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/minimum-scatterplot-matrix-1.png)

**Conditional plots.** A coplot compares residual patterns in separate groups. Here the groups are the four Anscombe datasets, not intervals chosen from the response. Each row added below is one observation from one fitted model:

<span id="coplot"></span>

```r
residual_groups <- data.frame()
for (i in seq_along(lmodels)) {
  residual_groups <- rbind(residual_groups, data.frame(
    Dataset = factor(i),
    Fitted = fitted(lmodels[[i]]),
    Residual = residuals(lmodels[[i]])
  ))
}
coplot(Residual ~ Fitted | Dataset, data = residual_groups)
```

![Conditional residual-versus-fitted plots separate the four Anscombe datasets and show their different residual patterns.]({{ site.baseurl }}/assets/images/rmd_images/e05-02/minimum-coplot-1.png)

Read the panels from bottom left to bottom right, then top left to top right: datasets 1, 2, 3 and 4. The strips labeled “Given: Dataset” identify the conditioning groups. There are only eleven observations per group. Use these panels to ask questions about the mean relationship and spread; they do not establish independence or a normal error distribution.

### If a check raises concerns {#no-alternatives}

Summarize which assumption appears compatible with the data, which looks questionable and which cannot be assessed from the available information. For each concern, identify the relevant plot or design feature and explain the consequence for interpreting the model. Avoid an automatic pass/fail decision based on one plot or p-value.

For example: “The curved residual trend makes a straight-line mean questionable, so its slope and tests need cautious interpretation even though the normality test does not reject.” An unresolved issue is a legitimate finding. More flexible models and predictive evaluation are introduced in later units.

### From this example to Assignment 05 {#from-diagnostics-to-assignment-05}

[Assignment 05: Recreation vs. Settlement]({{ site.baseurl }}/unit05/unit05-04_assignment.html) applies the same workflow to the wide `Output/lu_clean.rds` prepared in Unit 04:

1. Define comparable observations and check missing values for the two measurements.
2. Inspect the scatterplot, fit the line and inspect its residuals.
3. Describe evidence about the mean pattern, spread and normal approximation, and discuss what the sampling design can tell you about independence.
4. Compare the normality-test result across repeated random subsets, without treating it as a single model-quality score.

For random subsets, `sample()` selects positions. This small example uses invented row numbers:

```r
set.seed(42)
chosen_rows <- sample(1:100, size = 10, replace = FALSE)
chosen_rows
```

`replace = FALSE` prevents an observation from occurring twice within one draw. `set.seed()` makes the draw reproducible in the same R setup; record the seed and R version. Set it once before a repeated-sampling loop. Random selection cannot make dependent or incomparable source observations independent.

The assignment specifies the regional cohort and retains its existing 100 repetitions of 50 pairs. Begin with the graphical checks; use the repeated test results to discuss sample sensitivity and limitations. You are not asked to force all diagnostic plots to look perfect or to implement the extra transformation/matrix/coplot examples.

For further explanation, see the [NIST guide to graphical residual analysis](https://www.itl.nist.gov/div898/handbook/pmd/section4/pmd44.htm), the [R diagnostic-plot documentation](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/plot.lm.html) and [Shapiro–Wilk documentation](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/shapiro.test.html).
