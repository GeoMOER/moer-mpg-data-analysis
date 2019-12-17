---
title: "Unmarked Assignment: Precipitation Forecast"
toc: true
toc_label: In this worksheet
---

This worksheet introduces you to ARIMA modeling using a precipitation time series recorded at a station near Marburg University Forest.

After completing this worksheet you should have gained some first experience with time series data and have extended your case-study knowledge about the pitfalls of model selection.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operation system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend to use R Studio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} environment for your operating system. For Windows users with little experience on the command line we recommend [GitHub Desktop](https://desktop.github.com/){:target="_blank"}.
  * [German Weather Service (DWD) data](ftp://opendata.dwd.de/climate_environment/CDC/observations_germany){:target="_blank"} for the station Coelbe.


## DWD station 3164 Coelbe
The required station data can be downloaded directly from the German Weather Service (DWD) via its [FTP-Server](ftp://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/){:target="_blank"}. 
In addition to Coelbe, you will also find all stations available for Germany.

The station recordings are divided by variable and by history (i.e. generally a time frame closing at the end of last year) and recent (i.e. generally a time frame starting towards the end of the historic time frame and ending quite recently, e.g. yesterday or so).

From the data provided, we will require the dataset starting in July 2006. 


## Predicting precipitation
In this first time series exercise, we will try to find an ARIMA model for predicting monthly precipitation data. 
The model should be selected based on its capability measured by the RMSE for predicting the last two years of the provided time series.

For the model selection, any ARIMA parameter combination of p, d, q and the corresponding seasonal components ps, ds, qs should be tested for

* p between 0 and 5,
* d between 0 and 2,
* q between 0 and 5,
* ps between 0 and 2,
* ds between 0 and 2, and
* qs between 0 and 2.


Please write an Rmd file with html output in which the performance for predicting monthly precipitation of an ARIMA model with all of the possible parameter combinations above is tested. 

The performance should be tested using the RMSE between predicted and observed monthly precipitation for the last two full years of the dataset. 
Please print the parameters (i.e. p, d, q...) as well as the AIC and RMSE of your optimal model and compare them with the corresponding values retrieved using the ``forecast::auto.arima`` function (for the later you can just use the summary function although it gives more information than necessary). Please also visualize the prediction of your model and the automatically retrieved one in a simple plot (one for each model) and add the actually observed values to the plot. Write a one-sentence-statement about the differences.

Save your Rmd file in your course repository, knitr it, update (i.e. commit) your local repository and publish (i.e. push) it to the GitHub classroom. Make sure that the created html file is also part of your GitHub repository.

You can of course use 6 lapply loops for iterating over the parameters or you can have a look at the expand.grid function which realizes any combination of the supplied parameters in a single data frame which can easily be used for this task.
{: .notice--info}

Have a look at the respective meta information for details on the format of the German Weather Service data.
{: .notice--info}





