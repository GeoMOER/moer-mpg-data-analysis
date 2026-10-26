---
title: "Example: Visual Data Exploration"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Visual exploration starts with a question and an understanding of the observations. Here, each row is one German federal state in 2024. We use the prepared [Destatis land-use file]({{ site.baseurl }}/assets/data/destatis-land-use-2024-states.rds) generated in the [CSV I/O example]({{ site.baseurl }}/unit03/unit03-04_csv_io.html). That page documents the source table, English names, numeric conversion, and exclusion of Germany's aggregate. The RDS is a saved result of that preparation, not an independent data source.

If you completed the CSV I/O example, the RDS is already in your project's `Data/` folder. Otherwise, download the prepared file linked above and save it there. All six land-use measurements are percentages of each state's total area; `Area_ha` separately records total area in hectares. The following four columns describe non-overlapping categories, but do not cover every land use. Settlement excludes transport under this source's classification.


```r
lu <- readRDS("Data/destatis-land-use-2024-states.rds")
numc <- c("Settlement", "Transport", "Agriculture", "Forest")
head(lu[, c("Year", "ID", "Place", numc)])
```

```
##   Year ID                  Place Settlement Transport Agriculture Forest
## 1 2024 01     Schleswig-Holstein        9.4       4.4        68.1   10.3
## 2 2024 02                Hamburg       46.3      12.4        22.7    5.6
## 3 2024 03           Lower Saxony        9.5       5.2        57.7   21.7
## 4 2024 04                 Bremen       44.0      12.3        26.8    1.4
## 5 2024 05 North Rhine-Westphalia       16.9       7.1        46.6   24.8
## 6 2024 06                  Hesse        9.5       6.7        41.1   40.1
```

## First numerical overview

Before plotting, inspect the ranges and typical values:


```r
summary(lu[, numc])
```

```
##    Settlement      Transport       Agriculture        Forest
##  Min.   : 5.60   Min.   : 3.100   Min.   : 4.00   Min.   : 1.40
##  1st Qu.: 7.85   1st Qu.: 4.400   1st Qu.:40.12   1st Qu.:20.40
##  Median : 9.50   Median : 5.400   Median :46.30   Median :25.80
##  Mean   :17.01   Mean   : 6.569   Mean   :44.49   Mean   :25.61
##  3rd Qu.:15.93   3rd Qu.: 6.800   3rd Qu.:54.62   3rd Qu.:35.33
##  Max.   :55.90   Max.   :14.700   Max.   :68.10   Max.   :40.50
```

For each numerical column, `summary()` reports the minimum, first quartile, median, mean, third quartile, and maximum. The three quartiles mark the boundaries of four approximately equal parts of the ordered observations. The median is the middle value, or the mean of the two middle values for an even number of observations. The mean uses every value and is more sensitive to extreme observations. These summaries give each of the 16 states equal weight; they are not Germany's area-weighted percentages.

## Bar charts: compare named observations

Suppose the question is: **How do selected land-use shares compare between Lower Saxony, Hesse, and Bavaria?** Select those states by their stable identifiers, then compare the four categories with grouped bars:


```r
selected <- lu[match(c("03", "06", "09"), lu$ID), ]
heights <- t(as.matrix(selected[, numc]))
barplot(heights, beside = TRUE,
        names.arg = c("Lower Saxony", "Hesse", "Bavaria"),
        col = c("steelblue", "darkorange", "goldenrod2", "darkgreen"),
        ylim = c(0, max(heights) * 1.4),
        ylab = "Share of state area (%)", main = "Land use, 2024",
        legend.text = numc,
        args.legend = list(x = "topright", ncol = 2, bty = "n"))
```

![Grouped bars compare settlement, transport, agriculture, and forest shares in Lower Saxony, Hesse, and Bavaria in 2024.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/land-use-2024-grouped-bars.png)<!-- -->

`match()` locates the requested state IDs in the specified order, and `as.matrix()` converts the selected numerical columns to a matrix. `barplot()` uses the matrix values as bar heights. Transposing with `t()` puts categories in rows and states in columns; `beside = TRUE` places category bars next to each other within each state. The bars start at zero, and the labels and legend identify the percentages and groups.

This figure shows a value for each named category in each selected state. A boxplot instead answers how the values are distributed across all 16 states; a histogram groups numerical values into intervals. The [Base R bar-chart page](https://geomoer.github.io/moer-base-r/unit09/unit09-05_barplot.html) provides additional examples.


## Boxplot
A boxplot summarizes the center and spread of a distribution. The line inside the box marks the median. R places the box edges at lower and upper *hinges*, which approximate the first and third quartiles and can differ slightly from the values printed by `summary()`. The whiskers extend to the most extreme observed values within 1.5 box lengths of the box edges. More distant values are plotted individually; this rule flags values to inspect, not errors to delete automatically. See the [R boxplot documentation](https://stat.ethz.ch/R-manual/R-devel/library/grDevices/html/boxplot.stats.html) for the calculation.

Producing a boxplot is straightforward (the x-axis labels are just the column names):


```r
boxplot(lu[, numc], ylab = "Share of state area (%)")
```

![Boxplots of settlement, transport, agriculture, and forest shares across the 16 German states in 2024.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-3-1.png)<!-- -->


## Histograms
A histogram shows how many observations fall within each numerical interval. Here the horizontal axis shows settlement shares and the vertical axis counts states. With only 16 observations, the apparent shape can depend strongly on the interval boundaries:


```r
hist(lu$Settlement, main = "Settlement shares across 16 states",
     xlab = "Settlement share (%)", ylab = "Number of states")
```

![Histogram of settlement area shares across the 16 German states in 2024.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-6-1.png)<!-- -->


## Scatterplot
A scatterplot shows paired values for the same observations. Here, each point represents one state. We compare settlement and transport shares; placing a variable on the horizontal axis does not establish it as a cause of the vertical-axis variable.

Pass the two numerical columns to `plot()`:


```r
plot(lu$Settlement, lu$Transport,
     xlab = "Settlement share (%)", ylab = "Transport share (%)", pch = 16)
```

![Paired settlement and transport shares for the 16 states in 2024; each point represents one state.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-10-1.png)<!-- -->


Read the figures alongside the summary: the settlement mean (17.01%) exceeds its median (9.50%), consistent with a few states having much higher shares.

Even an exploratory graph benefits from variable names and units. City-states and larger states can occupy different parts of the plot. Investigate the reporting areas before interpreting an unusual point as an error or a general relationship.

## Arrange four plots in one figure

For a 2×2 figure, `par(mfrow = c(2, 2))` creates two rows and two columns. Each new high-level plotting call, such as `plot()`, `hist()` or `boxplot()`, fills the next panel, moving across each row:

```text
1: top left       2: top right
3: bottom left    4: bottom right
```

Use the following layout template with your own four plotting commands in place of the comments:

```text
old_par <- par(no.readonly = TRUE)
par(mfrow = c(2, 2))
# First plotting command
# Second plotting command
# Third plotting command
# Fourth plotting command
par(old_par)
```

Saving the original settings before changing them lets you restore them afterward. A call such as `lines()` adds to the current plot; it does not start another panel. The transformation example below demonstrates a complete four-panel figure.

## Further exploration

After the basic plots, the following examples explore transformations, reference distributions and conditioning in more detail. They use the same prepared land-use file.

### Transformations

Inspect unusual observations and their reporting areas before deciding how to handle them. To compare the displayed scales, the following figure shows the original shares and square-root, cube-root and logarithmic transformations. The `main` argument supplies each panel's title.

```r
par_org <- par(no.readonly = TRUE)
par(mfrow = c(2,2))
boxplot(lu[, numc], main = "Original")
boxplot(lu[, numc]**0.5, main = "Square root")
boxplot(lu[, numc]**(1/3), main = "Cube root")
boxplot(log1p(lu[, numc]), main = "Log(1 + x)")
```

![Land-use shares for the 16 states on original, square-root, cube-root, and log(1+x) scales.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-4-1.png)<!-- -->


`log1p(x)` computes `log(1 + x)` and is defined at zero, unlike `log(x)`. These transformations change the displayed scale; they do not alter the original data frame. A transformation is a choice to explain, rather than an automatic response to an unusual observation.


```r
par(par_org)
```





### QQ plots
QQ plots compare observed quantiles with those expected from a chosen distribution. Here we have only 16 states, so detailed judgments about distribution shapes are limited. Visual agreement does not prove that the data follow a distribution, and descriptive plots do not require a normal distribution.

For a normal reference distribution, use `qqnorm`. The red reference line passes through the first and third sample quartiles. Substantial departures from a straight line suggest that a normal distribution may be a poor description:


```r
qqnorm(lu$Agriculture)
qqline(lu$Agriculture, col = "red", lwd = 2)

abline(h=quantile(lu$Agriculture, probs = c(0.25,0.75), na.rm = TRUE), col="blue", lty = 3)
abline(v=qnorm(c(0.25,0.75)), col="blue", lty = 3)
```

![Normal QQ plot of 2024 agricultural area shares for 16 states, with quartile reference lines.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-7-1.png)<!-- -->


Different transformations may be helpful (although not in this case; example adapted from Zuur et al., 2007):


```r
par(mfrow = c(2,2))
for(p in c(1, 0.5, 0.25, 0)){
  if(p != 0){
    qqnorm((lu$Agriculture**p-1)/p, main = paste0("Normal Q-Q Plot, (y^p - 1)/p; p = ", p))
    qqline((lu$Agriculture**p-1)/p, col = "red")
  } else {
    qqnorm(log(lu$Agriculture), main = "Normal Q-Q Plot, log(y)")
    qqline(log(lu$Agriculture), col = "red")
  }
}
```

![Four normal QQ plots of power and log transformations of state agricultural area shares in 2024.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-8-1.png)<!-- -->



```r
par(par_org)
```

To compare other reference distributions, use their theoretical quantile functions (`qnorm`, `qchisq`, `qgamma`, and `qweibull`) at the same probability points. The shape parameters below are illustrative choices, not fitted estimates. The line joins the first and third quartiles:


```r
par(mfrow = c(2,2))
observed <- na.omit(lu$Settlement)
probs <- ppoints(length(observed))
references <- list(Normal = qnorm(probs),
                   `Chi squared` = qchisq(probs, df = 2),
                   Gamma = qgamma(probs, shape = 0.6),
                   Weibull = qweibull(probs, shape = 1))
for (name in names(references)) {
  dist <- references[[name]]
  qqplot(dist, observed, main = name, xlab = "Theoretical quantiles",
         ylab = "Settlement share (%)")
  abline(lm(quantile(observed, probs = c(0.25, 0.75)) ~
            quantile(dist, probs = c(0.25, 0.75))), col = "red", lwd = 2)
}
```

![State settlement shares in 2024 compared with normal, chi-squared, gamma, and Weibull reference quantiles.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-9-1.png)<!-- -->



```r
par(par_org)
```


### Scatterplot matrix

If you are interested in the relation between all (or many) variables in your dataset, just supply the entire data frame or a column subset of it to `plot`:


```r
plot(lu[, numc])
```

![Scatterplot matrix of settlement, transport, agriculture, and forest shares for the 16 states in 2024.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-12-1.png)<!-- -->


### Coplot
With only 16 states, splitting into several panels leaves few observations per panel. Use this as an illustration of conditioning rather than evidence of a stable relationship. As a final example, a coplot might be of some value. It is a scatterplot but the visualized relationship is split in accordance with value ranges of (an)other variable(s). The call to `coplot` is again straightforward. Left of the `|` are the two variables which will be included in the actual scatterplots, to the right is the variable which is used for the splits. If more than one variable should be used, the variables are combined with a `+` (not included here because of figure margin restrictions):


```r
coplot(Forest ~ Agriculture | Settlement, data = lu)
```

![Conditional forest-versus-agriculture scatterplots for 16 states, split by settlement share; panels contain few observations.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-13-1.png)<!-- -->
