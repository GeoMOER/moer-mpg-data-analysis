---
title: "Example: Forecasting with ARIMA"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/air_temperature.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---


Forecasting asks how well past observations predict later ones. Unlike the random splits in Unit 06, a time-series forecast must use only observations available before the predicted period.

We use the complete **January 2010–December 2018** temperature period established on the [previous page]({{ site.baseurl }}/unit09/unit09-02_time_series.html). Save <a href="{{ site.baseurl }}/assets/data/time-series/tam.txt" download>tam.txt</a> beside your `.Rproj` file. The full file includes incomplete months as `NA`; we select the documented complete period by date.

<span id="auto-regressive-and-moving-average-models-for-predicting-time-series"></span>
<span id="auto-regressive-models-ar"></span>
<span id="auto-regressive-integrated-moving-average-models-arima"></span>
<span id="finding-the-right-parameters-for-arima"></span>
<span id="finding-the-right-parameters-for-arima-with-the-autoarima-function"></span>

## Prepare a monthly series


``` r
tam <- read.table("tam.txt", header = TRUE, sep = ";")
tam <- tam[tam$Date >= 201001 & tam$Date <= 201812, ]
expected <- format(seq(as.Date("2010-01-01"), as.Date("2018-12-01"),
                       by = "month"), "%Y%m")
stopifnot(identical(as.character(tam$Date), expected), !anyNA(tam$Ta))
tam_ts <- ts(tam$Ta, start = c(2010, 1), frequency = 12)
```

`ts()` records the starting year/month and the number of observations per year. Here `frequency = 12` means monthly observations with an annual cycle. It does not detect or repair gaps, which is why we checked the dates first.

## What an ARIMA model describes

An **autoregressive** term uses earlier values; a **moving-average** term uses earlier model errors. Here moving average does not mean a rolling average of the observations. **Differencing** subtracts an earlier value to model changes rather than levels.

The ordinary ARIMA settings are:

| Setting | Meaning |
|---|---|
| `p` | Number of earlier observations used in autoregressive terms. |
| `d` | Number of ordinary differences. With `d = 1`, model this month's value minus last month's value. |
| `q` | Number of earlier errors used in moving-average terms. |

A seasonal model adds settings `P`, `D` and `Q` for the annual cycle. With monthly data, seasonal lags are multiples of 12; `D = 1` subtracts the value 12 months earlier. Differencing should address the observed series, not be increased automatically.

Install **forecast** once if needed, then load it:


``` r
# install.packages("forecast")
library(forecast)
```

## Fit one model before comparing many

Keep the last two years, **2017–2018**, out of fitting. The following example uses one ordinary and one seasonal autoregressive term, without differencing or moving-average terms. It is a starting candidate, not a claim that these settings are optimal.


``` r
training <- window(tam_ts, end = c(2016, 12))
validation <- window(tam_ts, start = c(2017, 1))
model <- Arima(training, order = c(1, 0, 0),
               seasonal = list(order = c(1, 0, 0), period = 12),
               method = "CSS-ML")
model
```

```
## Series: training
## ARIMA(1,0,0)(1,0,0)[12] with non-zero mean
##
## Coefficients:
##          ar1    sar1    mean
##       0.3692  0.8669  9.1534
## s.e.  0.1432  0.0607  1.9144
##
## sigma^2 = 6.456:  log likelihood = -204.42
## AIC=416.84   AICc=417.35   BIC=426.57
```

The printed coefficients describe the fitted relationships. AIC summarizes fit with a penalty for model complexity; it is not a forecast error in degrees Celsius. Do not compare AIC across models fitted to different data or with different differencing orders as if they were the same likelihood comparison.

## Predict the held-out period

`h = 24` requests 24 months after the training period. The forecast origin is the last training month; the horizon is how far ahead we predict.


``` r
prediction <- forecast(model, h = 24)
plot(prediction, ylab = "Air temperature (°C)")
lines(validation, col = "red")
legend("topleft", "Held-out observations", col = "red", lty = 1, bty = "n")
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e09-03/unnamed-chunk-4-1.png" alt="Two-year temperature forecast with prediction intervals and the held-out 2017–2018 observations in red."  />
<p class="caption">plot of chunk unnamed-chunk-4</p>
</div>

The shaded prediction intervals express uncertainty under the fitted model. They do not guarantee that future observations will fall inside them.


``` r
predicted <- as.numeric(prediction$mean)
rmse <- sqrt(mean((as.numeric(validation) - predicted)^2))
rmse
```

```
## [1] 2.644675
```

This RMSE measures errors on later observations that were not used for fitting. Lower RMSE means closer predictions over this particular evaluation period.

## Compare with automatic selection

`auto.arima()` searches for a model using the **training series**. Compare its forecast over the same 24 months; do not compare its training error with the first model's held-out RMSE.


``` r
automatic <- auto.arima(training, seasonal = TRUE)
automatic_prediction <- forecast(automatic, h = 24)
automatic_rmse <- sqrt(mean((as.numeric(validation) -
                              as.numeric(automatic_prediction$mean))^2))
data.frame(Model = c("Specified ARIMA", "Automatic ARIMA"),
           Held_out_RMSE = c(rmse, automatic_rmse))
```

```
##             Model Held_out_RMSE
## 1 Specified ARIMA      2.644675
## 2 Automatic ARIMA      2.120630
```

Adding parameters does not guarantee better forecasts. If we use these errors to choose a model, they become **selection scores**; another untouched period would be needed for an independent final assessment. The precipitation assignment retains a larger grid, but each iteration follows this same fit → forecast → compare sequence.
