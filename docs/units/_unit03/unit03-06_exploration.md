---
title: "Example: Visual Data Exploration"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---



Visual data exploration should be one of the first steps in data analysis. In fact, it should start right after reading a data set. The following examples are based on a data set showing the percentage fraction of settlement and transport, recreational, agricultural, and forest areas for regional units in Germany. The data has been provided through the [Regional Database Germany](https://www.regionalstatistik.de/genesis/online/).

Within this example, we will focus on basic R graphics. Of course, all of the examples could also be realized using more advanced plotting libraries like `lattice` or `ggplot`.




Download `lu_clean.rds` from ILIAS and place it beside your R Markdown document. This prepared R data frame has English column names and is separate from the raw `.txt` file in the CSV I/O example. The observations cover 1996–2014, and the four area columns are percentages of total area. The first rows and a column selector are shown below.

```r
lu <- readRDS("lu_clean.rds")
numc <- c("Settlement", "Recreation", "Agriculture", "Forest")
head(lu[, c("Year", "ID", "Place", numc)])
```

```
##   Year ID              Place Settlement Recreation Agriculture Forest
## 1 1996 01 Schleswig-Holstein       10.8        0.7        73.0    9.3
## 2 2000 01 Schleswig-Holstein       11.2        0.7        72.2    9.5
## 3 2004 01 Schleswig-Holstein       11.9        0.8        71.0   10.0
## 4 2008 01 Schleswig-Holstein       12.4        0.9        70.0   10.4
## 5 2009 01 Schleswig-Holstein       12.5        0.9        69.9   10.5
## 6 2010 01 Schleswig-Holstein       12.6        0.9        69.8   10.5
```

## Boxplot
A boxplot shows the median and the first and third quartiles. Its whiskers extend to the most extreme observed values no farther than 1.5 times the interquartile range from the box. More distant values are plotted individually; this rule flags values to inspect, not errors to delete automatically.

Producing a boxplot is straightforward (the x-axis labels are just the column names):

```r
boxplot(lu[, numc])
```

![Boxplots of settlement, recreation, agriculture, and forest area shares.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-3-1.png)

As can be seen, outliers in terms of the box-plot logic are clearly identifiable although this logic does not actually prove if an observation is an outlier. Hence, one has to cross-check the data and if there is no actual sign for an outlier, then keep the data as is! However, since "outliers" might have a strong influence on further analysis, one could check some kind of transformation to reduce the value range. The following example shows a root and logarithmic transformation. In order to distinguish the plots, we add a title using the `main` parameter:

```r
par_org <- par()
par(mfrow = c(2,2))
boxplot(lu[, numc], main = "Original")
boxplot(lu[, numc]**0.5, main = "Square root")
boxplot(lu[, numc]**(1/3), main = "Cube root")
boxplot(log1p(lu[, numc]), main = "Log(1 + x)")
```

![The four area-share boxplots on original, square-root, cube-root, and log(1+x) scales.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-4-1.png)

`log1p(x)` computes `log(1 + x)`, so the zero values in `Recreation` remain finite. It changes the scale of the plot; it does not change the original data frame.

```r
par(par_org)
```





## Histograms
Histograms are useful for getting an idea of the distribution of the dataset. Visualization is straightforward:

```r
hist(lu$Settlement)
```

![Histogram of settlement area share.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-6-1.png)


## QQ plots
QQ plots compare observed quantiles with those expected from a chosen distribution. They are useful diagnostics, but visual agreement does not prove that the data follow that distribution.

For a normal reference distribution, use `qqnorm`. The red reference line passes through the first and third sample quartiles. Substantial departures from a straight line suggest that a normal distribution may be a poor description:

```r
qqnorm(lu$Agriculture)
qqline(lu$Agriculture, col = "red", lwd = 2)

abline(h=quantile(lu$Agriculture, probs = c(0.25,0.75), na.rm = TRUE), col="blue", lty = 3)
abline(v=qnorm(c(0.25,0.75)), col="blue", lty = 3)
```

![Normal QQ plot for agricultural area share with quartile reference lines.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-7-1.png)

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

![Four normal QQ plots for power and log transformations of agricultural area share.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-8-1.png)

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

![Four QQ plots comparing settlement area share with normal, chi-squared, gamma, and Weibull references.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-9-1.png)

```r
par(par_org)
```


## Scatterplot
Scatterplot, i.e. the mother of all plots, focuses on the relationship between variables. The x-axis should be used for the (more) independent variable, the y-axis for the (more) dependent variable.

Again, creating such a plot is very simple:

```r
plot(lu$Settlement, lu$Recreation)
```

![Scatterplot of settlement and recreation area shares.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-10-1.png)

The axis labels are just the column names of the data frame but for this stage of data analysis, this is more than fine. If you finally decide which graphic should be included in a final presentation (e.g. publication), then the right time for nice labels and other stuff has come. But prior to that, pimping is just a waste of time.

If you are interested in the relation between all (or many) variables in your dataset, just supply the entire data frame or a column subset of it to `plot`:

```r
plot(lu[, numc])
```

![Scatterplot matrix of the four land-use area shares.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-12-1.png)


## Coplot
As a final example, a coplot might be of some value. It is a scatterplot but the visualized relationship is split in accordance with value ranges of (an)other variable(s). The call to `coplot` is again straightforward. Left of the `|` are the two variables which will be included in the actual scatterplots, to the right is the variable which is used for the splits. If more than one variable should be used, the variables are combined with a `+` (not included here because of figure margin restrictions):

```r
coplot(Forest ~ Agriculture | Settlement, data = lu)
```

![Conditional scatterplots of forest versus agricultural area share across settlement-share ranges.]({{ site.baseurl }}/assets/images/rmd_images/vis_dat_expl/unnamed-chunk-13-1.png)
 

