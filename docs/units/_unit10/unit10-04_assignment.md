---
title: "Unmarked Assignment: NAO and Cölbe"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/teaser/air_temperature.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This worksheet focuses on the analysis of meteorological time series data recorded at a station near Marburg University Forest and some global teleconnection indices related to the North Atlantic Oscillation (NAO).

After completing this worksheet you will have gained deeper experiences with time series data analysis and will additionally have extended your case-study knowledge about global teleconnection indices.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operation system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend to use R Studio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} environment for your operating system. For Windows users with little experience on the command line we recommend [GitHub Desktop](https://desktop.github.com/){:target="_blank"}.
  * [German Weather Service (DWD) data](https://opendata.dwd.de/climate_environment/CDC/observations_germany){:target="_blank"} for the station Cölbe.
  * [NOAA data](http://www.cpc.ncep.noaa.gov/data/teledoc/nao.shtml){:target="_blank"} for the North Atlantic Oscillation (NAO).


## NAO and air temperature in Cölbe
The required station data can be downloaded directly from the German Weather Service (DWD) via its [server](https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/){:target="_blank"}. 
In addition to Cölbe, you will also find all climate stations available for Germany.

After working with a short time series of the DWD station in Cölbe as part of the last assignment, 
we will now extent the time frame to the time between 1950 and 1990. 
This dataset is also available directly from the [DWD Server](https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/hourly/){:target="_blank"}. 
In addition to analyzing the dynamics in the station record, we will explain parts of the dynamics by using a time series of the North Atlantic Oscillation provided by [NOAA](http://www.cpc.ncep.noaa.gov/data/teledoc/nao.shtml){:target="_blank"}.

Please write an Rmd file with html output, which computes the trend of the air temperature recorded in Cölbe based on monthly values between January 1950 and December 1990 (we stop here because afterwards, there is a gap in the time series, which could be filled in principle but not as part of this task).
{: .notice--info}

Please extend your Rmd file in such a manner that you can evaluate to which degree the dynamics in the seasonal temperature over each year can be explained by fluctuations of the North Atlantic Oscillation. 
For this task, divide the NAO index provided above into "positive" and "negative" (i.e. use it as a factor, not as a numeric variable) and predict the temperature dynamics in a simple multiple linear model, which uses the NAO index classes as a factor and the first Fourier frequency (i.e. one sin and one cos) as independent variables. 
Finally, develop a strategy to cross-check the significance indicated by the linear model.

Save your Rmd file in your course repository, knitr it, update (i.e. commit) your local repository and publish (i.e. push) it to the GitHub classroom. 
Make sure that the created html file is also part of your GitHub classroom repository.





