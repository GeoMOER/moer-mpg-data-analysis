---
title: "Unmarked Assignment: Precipitation Forecast"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/teaser/air_temperature.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This worksheet introduces you to ARIMA modeling using a precipitation time series recorded at a station near Marburg.

After completing this worksheet you should have gained some first experience with time series data and have extended your case-study knowledge about the pitfalls of model selection.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client.
  * [German Weather Service (DWD) data](https://opendata.dwd.de/climate_environment/CDC/observations_germany){:target="_blank"} for the station Cölbe.


## DWD station 3164 Coelbe
Download <a href="{{ site.baseurl }}/assets/data/time-series/stundenwerte_RR_03164_20060701_20251231_hist.zip" download="stundenwerte_RR_03164_20060701_20251231_hist.zip">Cölbe hourly precipitation (ZIP)</a> and save it in `Data/`. This unchanged DWD archive includes the observations for July 2006–December 2025 and the station metadata. [Source notes]({{ site.baseurl }}/assets/data/time-series/source.txt) and the [DWD directory](https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/precipitation/historical/) provide provenance and current releases.

The station recordings are divided by variable into historical and recent records. Historical records generally extend to near the end of the previous year; recent records cover the period since then.

Use **January 2010–December 2019** from this archive. This continuous ten-year interval has every expected hourly precipitation observation; other parts of the archive contain gaps. Keep the original timestamps in **UTC**, check that each hour occurs once and that precipitation `R1` has no missing (`-999`) or negative values in the selected interval.

Compute one **monthly precipitation total in millimeters** by summing hourly `R1`, not by taking a mean. Compare valid and expected hours before summing. A month with any absent hour or missing value must be marked `NA`, never treated as zero or reported as a complete total. The selected interval should produce **120 complete monthly totals**. If your checks disagree, resolve the import or interval selection before fitting; do not drop isolated months or interpolate values.


## Predicting precipitation
In this first time series exercise, we will try to find an ARIMA model for predicting monthly precipitation data.
Fit on **January 2010–December 2017** and predict **January 2018–December 2019**, without using those final 24 months during fitting. Select the model with the smallest RMSE across those same 24 monthly totals. The [worked forecast]({{ site.baseurl }}/unit09/unit09-03_arima.html#predict-the-held-out-period) demonstrates one comparison before repetition.

For the model selection, any ARIMA parameter combination of p, d, q and the corresponding seasonal components ps, ds, qs should be tested for

* p between 0 and 5,
* d between 0 and 2,
* q between 0 and 5,
* ps between 0 and 2,
* ds between 0 and 2, and
* qs between 0 and 2.


Please write an R Markdown (.Rmd) document with HTML output in which the performance for predicting monthly precipitation of an ARIMA model with all of the possible parameter combinations above is tested.

Retain all **2,916 combinations**. Use monthly frequency 12 and `forecast::Arima(..., method = "CSS-ML")`. Record each combination and its convergence status. Record errors/warnings; exclude failed or nonconverged fits and nonfinite forecasts from selection, and report how many were excluded. Do not silently omit them or change the evaluation months.

Print the selected parameters, AIC and held-out RMSE. Fit `forecast::auto.arima()` to the **same training period**, forecast the same 24 months, and calculate its held-out RMSE in the same way. Its printed training errors are not comparable with the grid's held-out RMSE. Report AIC as a fitted-model statistic; use held-out RMSE for selection, since the grid includes different differencing orders.
Please also visualize the prediction of your model and the automatically retrieved one in a simple plot (one for each model) and add the actually observed values to the plot.
Write a one-sentence statement about the differences. These evaluation months are used to select a model, so the minimum RMSE is a selection score, not an independent final performance estimate; no additional test-period submission is required.

Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.

You can of course use 6 lapply loops for iterating over the parameters or you can have a look at the expand.grid function which realizes any combination of the supplied parameters in a single data frame which can easily be used for this task.
{: .notice--info}

Have a look at the respective metadata for details on the format of the German Weather Service data.
{: .notice--info}





