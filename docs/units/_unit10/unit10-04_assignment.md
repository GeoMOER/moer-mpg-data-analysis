---
title: "Unmarked Assignment: NAO and Cölbe"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/teaser/air_temperature.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This worksheet focuses on the analysis of meteorological time series data recorded at a station near Marburg University Forest and some global teleconnection indices related to the North Atlantic Oscillation (NAO).

After completing this worksheet you will have gained deeper experience with time series data analysis and will additionally have extended your case-study knowledge about global teleconnection indices.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client.
  * [German Weather Service (DWD) data](https://opendata.dwd.de/climate_environment/CDC/observations_germany){:target="_blank"} for the station Cölbe.
  * [NOAA data](https://www.cpc.ncep.noaa.gov/data/teledoc/nao.shtml){:target="_blank"} for the North Atlantic Oscillation (NAO).


## NAO and air temperature in Cölbe
Download <a href="{{ site.baseurl }}/assets/data/time-series/monatswerte_KL_03164_18810101_20251231_hist.zip" download="monatswerte_KL_03164_18810101_20251231_hist.zip">Cölbe monthly climate data (ZIP)</a> and <a href="{{ site.baseurl }}/assets/data/time-series/nao_index.tim" download="nao_index.tim">monthly NAO index (text)</a> into `Data/`. These are unchanged provider files; keep the station metadata and index header. Select January 1950–December 1990 from both files for this assignment. [Source notes]({{ site.baseurl }}/assets/data/time-series/source.txt) document the copies.

The DWD file has no record for **May 1965**. Match the two tables by year and month, using only matched observations for the joint analysis. Keep their calendar dates; do not align rows by position or fill the missing month automatically.

After working with a short time series of the DWD station in Cölbe as part of the last assignment,
we will now extend the time frame to the time between 1950 and 1990.
This dataset is also available directly from the [DWD Server](https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/monthly/kl/historical/){:target="_blank"}.
In addition to analyzing the dynamics in the station record,
we will explain parts of the dynamics by using a time series of the North Atlantic Oscillation provided by [NOAA](https://www.cpc.ncep.noaa.gov/data/teledoc/nao.shtml){:target="_blank"}.

Please write an R Markdown (.Rmd) document with HTML output, which computes the trend of the air temperature recorded in Cölbe based on monthly values between January 1950 and December 1990 (we stop here because afterwards, there is a gap in the time series, which could be filled in principle but not as part of this task).
{: .notice--info}

Please extend your R Markdown (.Rmd) document in such a manner that you can evaluate to what extent the dynamics in the seasonal temperature over each year can be explained by fluctuations of the North Atlantic Oscillation.
For this task, classify the NAO index as **"nonnegative" (`NAO >= 0`)** or **"negative" (`NAO < 0`)**. Use that category as a factor, together with one sine and one cosine for the annual cycle, to predict monthly temperature in a multiple linear regression.
The two exact-zero values (December 1956 and August 1970) belong to **nonnegative**. This is a two-category teaching convention, not a claim that zero represents a positive phase. The [seasonal-model example]({{ site.baseurl }}/unit10/unit10-02_time_series_analysis.html#a-simple-seasonal-model-for-the-assignment) supplies the sine/cosine terms; calculate them from the calendar month after matching the data.

Finally, develop and explain a strategy to cross-check the significance indicated by the linear model. Consider temporal dependence: randomly shuffling individual months would destroy the time structure. State what your check can and cannot establish; a small p value does not demonstrate a causal NAO effect.

Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.
