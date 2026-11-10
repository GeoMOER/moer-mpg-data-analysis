---
title: "Example: Exploring a Temperature Time Series"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/air_temperature.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---


Before this example, work through [dates and times]({{ site.baseurl }}/unit09/unit09-01a_datetime.html). A **time series** records a variable in time order. Nearby observations can be related; this is called **autocorrelation**. It matters when describing uncertainty and predicting future observations.

We use hourly air temperature at DWD station 03164, Cölbe. Our first question is whether the observations form the hourly sequence that the analysis assumes.

<span id="a-first-look-at-the-time-series"></span>
<span id="auto-correlation"></span>

## Download the data

Save <a href="{{ site.baseurl }}/assets/data/time-series/stundenwerte_TU_03164_20060701_20251231_hist.zip" download>Cölbe hourly temperature (ZIP)</a> in `Data/`. The unchanged DWD archive includes station metadata; [source notes]({{ site.baseurl }}/assets/data/time-series/source.txt) describe the course copies. We use observations through 2022, so the example has a fixed end date.


``` r
archive <- "Data/stundenwerte_TU_03164_20060701_20251231_hist.zip"
data_file <- grep("^produkt_tu_stunde_.*_03164\\.txt$",
                  unzip(archive, list = TRUE)$Name, value = TRUE)
stopifnot(length(data_file) == 1)
unzip(archive, files = data_file, exdir = "Data/dwd")
dwd <- read.table(file.path("Data/dwd", data_file), header = TRUE, sep = ";")
dwd$DATUM <- as.POSIXct(as.character(dwd$MESS_DATUM),
                       format = "%Y%m%d%H", tz = "UTC")
```

## Keep the hourly calendar

DWD uses `-999` for missing measurements. A missing value is not a cold temperature or zero humidity. Some timestamps are absent entirely. Create the expected hourly calendar and join observations to it, using the `merge()` operation from Unit 04. `all.x = TRUE` retains every expected hour; an absent observation becomes `NA`.


``` r
stopifnot(!anyNA(dwd$DATUM), !anyDuplicated(dwd$DATUM))
calendar <- data.frame(DATUM = seq(
  as.POSIXct("2006-07-01", tz = "UTC"),
  as.POSIXct("2022-12-31 23:00:00", tz = "UTC"), by = "hour"))
dwd <- merge(calendar, dwd, by = "DATUM", all.x = TRUE, sort = TRUE)
dwd$TT_TU[dwd$TT_TU == -999 & !is.na(dwd$TT_TU)] <- NA_real_
dwd$RF_TU[dwd$RF_TU == -999 & !is.na(dwd$RF_TU)] <- NA_real_
colSums(is.na(dwd[c("TT_TU", "RF_TU")]))
```

```
## TT_TU RF_TU
##   853   927
```


``` r
plot(dwd$DATUM, dwd$TT_TU, type = "l",
     xlab = "Date", ylab = "Air temperature (°C)")
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e09-02/unnamed-chunk-3-1.png" alt="Hourly Cölbe temperatures through 2022, retaining gaps at missing observations."  />
<p class="caption">plot of chunk unnamed-chunk-3</p>
</div>

**Take home:** keep the position of a missing hour. Removing its row would make observations on either side appear one hour apart.

## Autocorrelation at hourly lags

A **lag** is a time separation. Here lag 1 means one hour and lag 24 means one day. `acf()` compares values separated by these lags. `na.action = na.pass` leaves the missing positions in place and estimates each comparison from available pairs.


``` r
acf(dwd$TT_TU, lag.max = 100, na.action = na.pass,
    xlab = "Lag (hours)", main = "Hourly temperature autocorrelation")
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e09-02/unnamed-chunk-4-1.png" alt="Temperature autocorrelation across hourly lags on the regular calendar, with missing positions retained."  />
<p class="caption">plot of chunk unnamed-chunk-4</p>
</div>

The dashed lines are approximate reference limits for an uncorrelated series. They are not proof of normality, independence or a suitable forecasting model. Having many observations does not remove dependence or missing-data problems.

## Check monthly coverage before averaging

A monthly mean based on a short warm spell need not describe the whole month. For this teaching example, use a simple conservative rule: **a monthly mean is available only when every expected hourly temperature is observed**. This is our teaching rule, not a claim about DWD's official monthly processing.

`mean()` returns `NA` when any input is missing. Do not add `na.rm = TRUE` here: that would quietly average an incomplete month. Count valid and expected hours to make the reason visible.


``` r
month <- format(dwd$DATUM, "%Y%m", tz = "UTC")
tam <- aggregate(dwd$TT_TU, by = list(Date = month), FUN = mean)
names(tam)[2] <- "Ta"
valid <- aggregate(!is.na(dwd$TT_TU), by = list(Date = month), FUN = sum)
coverage <- data.frame(Date = valid$Date, Valid_hours = valid$x,
                       Expected_hours = as.integer(table(month)))
coverage[coverage$Valid_hours < coverage$Expected_hours, ]
```

```
##       Date Valid_hours Expected_hours
## 1   200607         743            744
## 37  200907         743            744
## 157 201907         574            744
## 158 201908         254            744
## 171 202009         583            720
## 182 202108         690            744
```

August 2019, for example, has only 254 of 744 hourly temperatures. Its monthly value must remain missing under this rule. No missing temperature is replaced by zero or an invented value.


``` r
write.table(tam, "tam.txt", sep = ";", row.names = FALSE, na = "NA")
```

The saved file keeps all 198 months from July 2006 to December 2022, including `NA` for incomplete months. A prepared <a href="{{ site.baseurl }}/assets/data/time-series/tam.txt" download>tam.txt</a> is available; save it beside `.Rproj` to match the following examples. The optional [preparation script]({{ site.baseurl }}/assets/data/time-series/prepare-tam.R) reproduces it from the ZIP.

## Use a continuous complete period

The following forecasting and decomposition examples use **January 2010–December 2018**: nine complete years with every hourly temperature available. Select by the recorded date, then check the sequence. Do not remove isolated missing months and relabel the remaining rows as consecutive months.


``` r
tam_example <- tam[tam$Date >= "201001" & tam$Date <= "201812", ]
expected_months <- format(seq(as.Date("2010-01-01"),
                             as.Date("2018-12-01"), by = "month"), "%Y%m")
stopifnot(identical(as.character(tam_example$Date), expected_months),
          !anyNA(tam_example$Ta))
```


``` r
acf(tam_example$Ta, xlab = "Lag (months)",
    main = "Monthly temperature autocorrelation, 2010–2018")
```

<div class="figure">
<img src="{{ site.baseurl }}/assets/images//rmd_images/e09-02/unnamed-chunk-8-1.png" alt="Autocorrelation of complete monthly temperatures, with a strong annual cycle at twelve-month lags."  />
<p class="caption">plot of chunk unnamed-chunk-8</p>
</div>

Positive correlations around 12 months and negative correlations around six months reflect the annual temperature cycle. **Take home:** first establish the calendar and observational coverage; only then interpret the pattern.
