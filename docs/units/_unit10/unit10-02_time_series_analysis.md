---
title: "Example: Time Series Decomposition"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/air_temperature.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

The [Unit 09 date/time lesson]({{ site.baseurl }}/unit09/unit09-01a_datetime.html#extract-months-and-years) explains parsing and extracting calendar components. Here, the first day of each month is a plotting label for a monthly summary, not the date of an individual observation.

We reuse the complete **January 2010–December 2018** temperature period from Unit 09. The full checkpoint retains missing months; select the agreed complete interval before applying decomposition, which requires regularly spaced observations without gaps.

Use `tam.txt` from the [Unit 09 preparation]({{ site.baseurl }}/unit09/unit09-02_time_series.html), or download <a href="{{ site.baseurl }}/assets/data/time-series/tam.txt" download>tam.txt</a> beside `.Rproj`. [Source and coverage notes]({{ site.baseurl }}/assets/data/time-series/source.txt).


``` r
# read data we saved in unit 9
tam <- read.table("tam.txt", header = TRUE, sep = ";")
tam <- tam[tam$Date >= 201001 & tam$Date <= 201812, ]
expected <- format(seq(as.Date("2010-01-01"), as.Date("2018-12-01"),
                       by = "month"), "%Y%m")
stopifnot(identical(as.character(tam$Date), expected), !anyNA(tam$Ta))
head(tam)
```

```
##      Date         Ta
## 43 201001 -2.6278226
## 44 201002  0.2075893
## 45 201003  5.0146505
## 46 201004  9.2700000
## 47 201005 11.0623656
## 48 201006 17.1666667
```




``` r
# convert Date column to POSIXlt Date; added day 01 for the conversion
tam$Date <- strptime(paste0(tam$Date, "01"), format = "%Y%m%d", tz = "Europe/Berlin")

plot(tam$Date, tam$Ta, type = "l")
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-2-1.png" alt="Monthly mean air temperature shows repeated summer peaks and winter troughs over 2010–2018."  />
<p class="caption">plot of chunk unnamed-chunk-2</p>
</div>



### Seasonality of time series
The time series shows clear seasonality. In this case, we already know that monthly mid-latitude temperature shows a seasonality of 12 months.
In case we are not certain, we could also have a look at the spectrum using e.g. the ``spectrum`` function, which estimates the (seasonal) frequencies of a data set using an auto-regressive model.

The smallest frequency which is checked is 1 divided by the length of the time series.
Hence, in order to convert frequency back to the original time units, we divide 1 by the frequency:


``` r
spec <- spectrum(tam$Ta)
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-3-1.png" alt="Raw periodogram of monthly temperature has a prominent peak near one cycle per twelve observations."  />
<p class="caption">plot of chunk unnamed-chunk-3</p>
</div>




``` r
plot(1/spec$freq, spec$spec, type = "h")
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-4-1.png" alt="Spectral power plotted against period has a dominant peak near twelve months."  />
<p class="caption">plot of chunk unnamed-chunk-4</p>
</div>




``` r
1/spec$freq[spec$spec == max(spec$spec)]
```

```
## [1] 12
```



The frequency of 12 months dominates the spectral density.

### Decomposition of time series
Once we are certain about the seasonal frequency, we can start with the decomposition of the time series, which is assumed to be the sum of

* an annual trend,
* a seasonal component, and
* a non-correlated remainder component (i.e. white noise).

To start with the annual component or "trend", we could use a 12-month running mean filter.
In the following example, we will use the ``rollapply`` function for that:


``` r
annual_trend <- zoo::rollapply(tam$Ta, 12, mean, align = "center", fill = NA)
plot(tam$Date, tam$Ta, type = "l")
lines(tam$Date, annual_trend, col = "red")
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-6-1.png" alt="Monthly temperature with a twelve-month moving-average trend, which varies more slowly than the seasonal cycle."  />
<p class="caption">plot of chunk unnamed-chunk-6</p>
</div>



The annual trend shows some fluctuations but it is certainly not very strong or even hardly different from zero.

Once this trend is identified, we can subtract it from the original time series in order to get a de-trended seasonal signal, which will be averaged in the second step.
The average of each will finally form the seasonal signal:


``` r
seasonal <- tam$Ta - annual_trend
month <- as.integer(format(tam$Date, "%m"))
seasonal_mean <- aggregate(seasonal, by = list(month),
                           FUN = mean, na.rm = TRUE)
seasonal_cycle <- seasonal_mean$x[match(month, seasonal_mean$Group.1)]
plot(tam$Date, seasonal, type = "l")
lines(tam$Date, seasonal_cycle, col = "blue")
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-7-1.png" alt="Detrended temperature and the repeating estimated seasonal cycle show similar annual oscillations."  />
<p class="caption">plot of chunk unnamed-chunk-7</p>
</div>



The blue line shows the average seasonal signal of the time series.

The only thing remaining is the remainder, i.e. the component explained by neither the trend nor the seasonal signal:


``` r
remainder <- tam$Ta - annual_trend - seasonal_cycle
plot(tam$Date, remainder, type = "l")
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-8-1.png" alt="Temperature remainder after removing trend and seasonality fluctuates around zero, with a few larger departures."  />
<p class="caption">plot of chunk unnamed-chunk-8</p>
</div>



As we can see, it is slightly autocorrelated:


``` r
acf(remainder, na.action = na.pass)
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-9-1.png" alt="Autocorrelation of the remainder is much smaller than in the original seasonal temperature series."  />
<p class="caption">plot of chunk unnamed-chunk-9</p>
</div>



As an alternative to the workflow above, we could (and should) of course use existing functions, like ``decompose``, which handles the decomposition in one step.
Since this function requires a time series, this data type has to be created first.
Note that the frequency argument in the time series function does not correspond to the seasonal component but to the number of sub-observations within each major time step (i.e. monthly values within annual major time steps in our case):


``` r
tam_ts <- ts(tam$Ta, start = c(2010, 1), end = c(2018, 12), frequency = 12)
tam_ts_dec <- decompose(tam_ts)
plot(tam_ts_dec$trend)
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-10-1.png" alt="Trend component from classical decomposition changes slowly over the monthly temperature record."  />
<p class="caption">plot of chunk unnamed-chunk-10</p>
</div>



While the above shows the plotting of the trend component, we can also plot everything in one plot:


``` r
plot(tam_ts_dec)
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-11-1.png" alt="Classical additive decomposition separates observed monthly temperature, trend, seasonal cycle, and remainder into four panels."  />
<p class="caption">plot of chunk unnamed-chunk-11</p>
</div>




But - again - it is not as static as it seems.
While ``decompose`` computes the (annual/long-term) trend using a moving average, the ``stl`` function uses a loess smoother.
Here is one realization using "periodic" as the smoothing window, for which - according to the function description - "smoothing is effectively replaced by taking the mean".
The visualization shows the different long-term trends retrieved by the two approaches:


``` r
tam_ts_stl <- stl(tam_ts, "periodic")
plot(tam_ts_dec$trend, col = "red")
lines(tam_ts_stl$time.series[, 2], col = "blue")
legend("topleft", c("decompose", "stl"), col = c("red", "blue"), lty=c(1,1))
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-12-1.png" alt="Trend estimates from classical decomposition and STL mostly agree, with differences near some peaks and endpoints."  />
<p class="caption">plot of chunk unnamed-chunk-12</p>
</div>



The entire result from the ``stl`` function call looks like this:


``` r
plot(tam_ts_stl)
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-13-1.png" alt="STL decomposition displays observed temperature, repeating seasonality, a slowly varying trend, and a short-term remainder."  />
<p class="caption">plot of chunk unnamed-chunk-13</p>
</div>




# Trend estimation
While the above helps us decompose a time series into several components, we are sometimes also interested in linear trends over time.
Since seasonal signals strongly influence such trends, we generally remove the seasonal signal and analyze the anomalies.
In order to remove the seasonal signal, we can average over all values for each month and subtract it from the original time series:


``` r
month <- as.integer(format(tam$Date, "%m"))
monthly_mean <- aggregate(tam$Ta, by = list(Month = month), FUN = mean)
tam$Ta_ds <- tam$Ta - monthly_mean$x[match(month, monthly_mean$Month)]
plot(tam$Date, tam$Ta_ds, type = "l")
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-14-1.png" alt="Deseasonalized temperature shows departures from the average monthly cycle rather than the original annual oscillation."  />
<p class="caption">plot of chunk unnamed-chunk-14</p>
</div>



Once this is done, a linear model could be used. In this context, it is important to understand the meaning of the independent (i.e. time) variable. The following shows the slope of the trend per month since the time is just supplied as a sequence of natural numbers:


``` r
lmod <- lm(tam$Ta_ds ~ seq(nrow(tam)))
summary(lmod)
```

```
##
## Call:
## lm(formula = tam$Ta_ds ~ seq(nrow(tam)))
##
## Residuals:
##     Min      1Q  Median      3Q     Max
## -5.7462 -0.8904  0.0067  1.0586  3.4596
##
## Coefficients:
##                 Estimate Std. Error t value Pr(>|t|)
## (Intercept)    -0.773943   0.320179  -2.417  0.01735 *
## seq(nrow(tam))  0.014201   0.005099   2.785  0.00635 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 1.652 on 106 degrees of freedom
## Multiple R-squared:  0.06817,	Adjusted R-squared:  0.05938
## F-statistic: 7.755 on 1 and 106 DF,  p-value: 0.006346
```



If we were interested in annual trends, we could multiply the above slope of the time variable by 12 or define the time variable in such a way that each month is counted as a fraction of 1 (e.g. January 2010 = 2010; February 2010 ≈ 2010.0833 etc.):


``` r
ts <- as.numeric(format(tam$Date, "%Y")) +
      (as.numeric(format(tam$Date, "%m")) - 1) / 12
lmod <- lm(tam$Ta_ds ~ ts)
summary(lmod)
```

```
##
## Call:
## lm(formula = tam$Ta_ds ~ ts)
##
## Residuals:
##     Min      1Q  Median      3Q     Max
## -5.7462 -0.8904  0.0067  1.0586  3.4596
##
## Coefficients:
##               Estimate Std. Error t value Pr(>|t|)
## (Intercept) -343.28269  123.27222  -2.785  0.00635 **
## ts             0.17041    0.06119   2.785  0.00635 **
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
##
## Residual standard error: 1.652 on 106 degrees of freedom
## Multiple R-squared:  0.06817,	Adjusted R-squared:  0.05938
## F-statistic: 7.755 on 1 and 106 DF,  p-value: 0.006346
```




``` r
plot(ts, tam$Ta_ds, type = "l")
abline(lmod, col = "red")
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-17-1.png" alt="Deseasonalized temperature with a fitted fitted line over 2010–2018."  />
<p class="caption">plot of chunk unnamed-chunk-17</p>
</div>



The fitted slope is 0.17 °C per year over this selected period. The reported p value assumes independent errors; serial dependence and the short time window limit that interpretation. This descriptive fit is not, by itself, evidence of a long-term climate trend.

**Take home:** retain the actual calendar, remove the seasonal pattern explicitly, and distinguish the fitted trend from the assumptions needed for its uncertainty.

### A simple seasonal model for the assignment

A sine and a cosine can describe one smooth annual cycle. Together they allow the warmest month to occur at different positions in the year; their coefficients determine its timing and amplitude. These two columns are called the **first Fourier frequency** here. They provide a simple seasonal starting point, not a perfect fit to every month.


``` r
season_sin <- sin(2 * pi * (month - 1) / 12)
season_cos <- cos(2 * pi * (month - 1) / 12)
season_model <- lm(tam$Ta ~ season_sin + season_cos)
plot(tam$Date, tam$Ta, type = "l", ylab = "Air temperature (°C)")
lines(tam$Date, fitted(season_model), col = "blue")
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e10-02/unnamed-chunk-18-1.png" alt="Seasonal temperature model over the complete 2010–2018 interval."  />
<p class="caption">plot of chunk unnamed-chunk-18</p>
</div>

Assignment 10 adds a two-category NAO indicator to these seasonal terms. As in Unit 05, a small regression p value needs to be considered alongside residual patterns and the observation design.
