---
title: "Predicting time series"
toc: true
toc_label: In this example
---

Time-series analyses can generally be divided into forecasting future dynamics and describing and potentially explaining past patterns. 
Since the later often requires continuous i.e. gap-free observations, we start with a simple forecasting procedure which can also be used for gap-filling in some cases.

To illustrate forecasting, we will again use the (mean monthly) air temperature records of the weather station in Coelbe (which is closest to the Marburg university forest). The data has been supplied by the [German Weather Service](ftp://opendata.dwd.de/climate_environment/CDC/observations_germany){:target="_blank"}. 




```r
head(tam)
```

```
##     Date        Ta
## 1 200607 21.753970
## 2 200608 15.567473
## 3 200609 16.683194
## 4 200610 12.118817
## 5 200611  7.325556
## 6 200612  4.468011
```

### Auto-regressive and moving average models for predicting time series
In order to predict the time series just based on its observed dynamics, an auto-regressive integrated moving average model (ARIMA) can be used. 
ARIMA is not a diagnostic model for the identification of seasonal or other periodic components. 
On the contrary, it requires a stationary time series, which is a prerequisite we already know is not true for the monthly mean air temperature values between July 1st 2006 and December 31st 2015. 

```r
acf(tam$Ta)
```

![]({{ site.baseurl }}/assets/images/rmd_images/e09-03/unnamed-chunk-3-1.png)<!-- -->

### Auto-regressive models (AR)
While we can start with de-trending and de-seasoning now, let us try a quick-and-dirty approach first and postpone the time series decomposition to the next session. 
One thing one could try is to not use the original values but the difference between the consecutive value pairs (i.e. the difference between time t and t+1 etc.). 
And if one difference is not enough, we can compute the differences of the differences and the auto-correlation behaviour would look like that:

```r
dTa <- diff(diff(tam$Ta))
acf(dTa)
```

![]({{ site.baseurl }}/assets/images/rmd_images/e09-03/unnamed-chunk-4-1.png)<!-- -->

Not perfect but good enough to be used in this example. Before we run the ARIMA model, we run a simple AR model first:

```r
armod <- ar(dTa, aic = TRUE, order.max = 20, method = "yule-walker")
armod
```

```
## 
## Call:
## ar(x = dTa, aic = TRUE, order.max = 20, method = "yule-walker")
## 
## Coefficients:
##       1        2        3        4        5        6        7        8  
## -0.7334  -0.5075  -0.2491  -0.2513  -0.3969  -0.6473  -0.5665  -0.5402  
##       9       10  
## -0.2995  -0.2997  
## 
## Order selected 10  sigma^2 estimated as  8.501
```

The ``ar`` function computes an AR model and iterates over the lags to be included in the linear equation which predicts the monthly air temperature values for time t based on its value at time t-1, t-2, and so on.

The maximum number of lags (within a maximum of 20 as provided to the function) is determined based on an internal estimate of the AIC parameter. The number of lags with the minimum AIC are used:

```r
plot(0:20, armod$aic, type = "o")
```

![]({{ site.baseurl }}/assets/images/rmd_images/e09-03/unnamed-chunk-6-1.png)<!-- -->

Using the Yule-Walker method for estimating the AR parameters, a maximum lag of 10 is considered. 
Although the results will be quite different if another method is used and although the following is of no use if one actually wants to use not just an AR or a MA but an ARIMA model, a rule of thumb states that if

* the auto-correlation function declines exponentially or shows a sinus pattern and
* the partial auto-correlation function shows only p significant lags in the beginning,

an AR(p) model (i.e. an AR model with p considered lags) is a good starting point. For moving average models it is vice versa and the lags q considered in the model would be taken from the auto-correlation function. 
In the auto- and partial auto-correlation function of the two-times differentiated dataset, we might see exactly this:

```r
par_org <- par()
par(mfrow = c(1,2))
acf(dTa)
pacf(dTa)
```

![]({{ site.baseurl }}/assets/images/rmd_images/e09-03/unnamed-chunk-7-1.png)<!-- -->

```r
par(par_org)
```

Nice, but pretty useless since if we change the parameter estimation method, the results look like this (17 is the optimum):

```r
armod <- ar(dTa, aic = TRUE, order.max = 20, method = "mle")
armod
```

```
## 
## Call:
## ar(x = dTa, aic = TRUE, order.max = 20, method = "mle")
## 
## Coefficients:
##       1        2        3        4        5        6        7        8  
## -1.5341  -2.0412  -2.3315  -2.5476  -2.8204  -3.1504  -3.2904  -3.3489  
##       9       10       11       12       13       14       15       16  
## -3.1917  -3.0814  -2.6816  -2.2896  -1.8580  -1.2937  -0.8677  -0.4083  
##      17  
## -0.1449  
## 
## Order selected 17  sigma^2 estimated as  3.174
```


The AR model can now be used to predict the time series (although 100 months in the future is way to much; grey lines indicate the standard error):

```r
arpred <- predict(armod, n.ahead = 100)

plot(dTa, type = "l", xlim = c(0, length(dTa)+100))
lines(arpred$pred, col = "red")
lines(arpred$pred + arpred$se, col = "grey")
lines(arpred$pred - arpred$se, col = "grey")
```

![]({{ site.baseurl }}/assets/images/rmd_images/e09-03/unnamed-chunk-9-1.png)<!-- -->


### Auto-regressive integrated moving average models (ARIMA)
Since the auto-correlation and partial auto-correlation function might slightly demand for an auto-regressive model and not for a moving average model, 
we will skip the later and jump directly to the combined version - ARIMA.

In the ARIMA world, three parameters are generally required: 

* p which is the number of time lags considered in the AR model,
* d which is the number of differences taken from the dataset (to reach stationarity), and
* q which is the number of time lags considered in the MA model.

Hence, if we want to compute an ARIMA comparable to the AR above (the second one), we call it with:

```r
armod <- arima(tam$Ta, order = c(17,2,0), method = "ML")  # the order is p, d, q
armod
```

```
## 
## Call:
## arima(x = tam$Ta, order = c(17, 2, 0), method = "ML")
## 
## Coefficients:
##           ar1      ar2      ar3      ar4      ar5      ar6      ar7
##       -1.5323  -2.0368  -2.3241  -2.5367  -2.8068  -3.1350  -3.2741
## s.e.   0.0982   0.1783   0.2576   0.3215   0.3631   0.3981   0.4325
##           ar8      ar9     ar10     ar11     ar12     ar13     ar14
##       -3.3327  -3.1753  -3.0653  -2.6656  -2.2745  -1.8440  -1.2815
## s.e.   0.4485   0.4604   0.4485   0.4321   0.3977   0.3619   0.3185
##          ar15     ar16     ar17
##       -0.8586  -0.4031  -0.1428
## s.e.   0.2544   0.1781   0.0988
## 
## sigma^2 estimated as 3.188:  log likelihood = -230.95,  aic = 495.91
```

Finding the right values for an ARIMA model is not trivial. 
Basically, one has to iterate over a variety of options. Let us try just one for illustration purposes.

```r
arimamod <- arima(tam$Ta, c(6,2,2))
summary(arimamod)
```

```
## 
## Call:
## arima(x = tam$Ta, order = c(6, 2, 2))
## 
## Coefficients:
##          ar1     ar2     ar3      ar4      ar5      ar6      ma1     ma2
##       0.3197  0.0425  0.0449  -0.1024  -0.3006  -0.3669  -1.8782  0.8872
## s.e.  0.0985  0.0924  0.0932   0.0932   0.0935   0.1001   0.0649  0.0636
## 
## sigma^2 estimated as 3.703:  log likelihood = -239.34,  aic = 494.67
## 
## Training set error measures:
##               ME RMSE MAE MPE MAPE
## Training set NaN  NaN NaN NaN  NaN
```

We will not focus on optimal prediction in this example, so these results are just fine for the purpose of illustration. 
The ARIMA model can be used to predict the time series in the future analogously to the AR model:

```r
arima_predict <- predict(arimamod, n.ahead = 100)

plot(tam$Ta, type = "l", xlim = c(0, length(dTa)+100))
lines(arima_predict$pred, col = "red")
lines(arima_predict$pred + arima_predict$se, col = "grey")
lines(arima_predict$pred - arima_predict$se, col = "grey")
```

![]({{ site.baseurl }}/assets/images/rmd_images/e09-03/unnamed-chunk-12-1.png)<!-- -->


### Finding the right parameters for ARIMA
Finding the right number of lags p for the AR model, number of differentiations d, and number of lags q for the MA model requires several iterations. 
You now already know everything you need to e.g. iterate over a bunch of values for each parameter and select the appropriate combination by minimizing e.g. cross-validation errors. An alternative approach could be the ``forecast::auto.arima`` function. It will iterate over the parameters (see defaults of the function) and apply some statistical tests for e.g. stationarity. 
It will also include seasonal components in the ARIMA model (which is basically the same as a time lag but with respect to the seasonal difference, e.g. a seasonal component [12] with a lag of 1 skips 12 months, one for [4] would skip a quarter of a year).

### Finding the right parameters for ARIMA with the auto.arima function
The forecast package generally works on time series data of class ``ts``, which is easy to generate if you actually have a complete (i.e. gap-free) time series. The time series is defined by the values, the starting point in time (e.g. year and month), the end point in time, the frequency of observations per main time unit and the time step delta t. 
For monthly data starting in July 2006 and ending in December 2015, the creation of a time series will look like this:

```r
tam_ts <- ts(tam$Ta, start = c(2006, 7), end = c(2015, 12), 
             frequency = 12)
str(tam_ts)
```

```
##  Time-Series [1:114] from 2006 to 2016: 21.75 15.57 16.68 12.12 7.33 ...
```

Now, we can use the ``forecast::auto.arima`` function. We will extend the iteration over p and q to 20 to be compatible with the above example but we will not include a seasonal component for the moment:

```r
# library(forecast)
arima_ns <- auto.arima(tam_ts, max.p = 20, max.q = 20, stationary = TRUE, seasonal=FALSE)
summary(arima_ns)
```

```
## Series: tam_ts 
## ARIMA(4,0,1) with non-zero mean 
## 
## Coefficients:
##          ar1      ar2     ar3      ar4      ma1    mean
##       1.0643  -0.2341  0.0017  -0.3637  -0.5698  9.7454
## s.e.  0.1083   0.1486  0.1433   0.1024   0.0816  0.1590
## 
## sigma^2 estimated as 4.365:  log likelihood=-245.05
## AIC=504.11   AICc=505.16   BIC=523.26
## 
## Training set error measures:
##                      ME     RMSE      MAE      MPE     MAPE      MASE
## Training set 0.06181951 2.033455 1.626722 57.91271 97.16354 0.8519967
##                     ACF1
## Training set -0.05493963
```

Actually, the ARIMA model comes with d = 0 which means that the data values are not differentiated (which is a tough choice).

To better estimate the quality of the ARIMA model, we can use some diagnostic plots:

```r
tsdiag(arima_ns)
```

![]({{ site.baseurl }}/assets/images/rmd_images/e09-03/unnamed-chunk-15-1.png)<!-- -->

The last plot shows test results if the residuals are independently distributed. 
For time lags larger 4, this is maybe not the case, which indicates that the ARIMA model is not really well specified.

The forecast looks like this:

```r
plot(forecast(arima_ns))
```

![]({{ site.baseurl }}/assets/images/rmd_images/e09-03/unnamed-chunk-16-1.png)<!-- -->

If we include a seasonal component, the results look like this:

```r
arima_s <- auto.arima(tam_ts, max.p = 20, max.q = 20, seasonal=TRUE)
summary(arima_s)
```

```
## Series: tam_ts 
## ARIMA(1,0,0)(2,1,0)[12] 
## 
## Coefficients:
##          ar1     sar1     sar2
##       0.1865  -0.6021  -0.3465
## s.e.  0.0998   0.1006   0.1041
## 
## sigma^2 estimated as 4.471:  log likelihood=-222.47
## AIC=452.95   AICc=453.36   BIC=463.45
## 
## Training set error measures:
##                      ME    RMSE      MAE       MPE     MAPE      MASE
## Training set -0.1559868 1.97039 1.435267 -6.164647 46.61725 0.7517223
##                      ACF1
## Training set -0.009007497
```

```r
tsdiag(arima_s)
```

![]({{ site.baseurl }}/assets/images/rmd_images/e09-03/unnamed-chunk-17-1.png)<!-- -->

```r
plot(forecast(arima_s))
```

![]({{ site.baseurl }}/assets/images/rmd_images/e09-03/unnamed-chunk-17-2.png)<!-- -->
