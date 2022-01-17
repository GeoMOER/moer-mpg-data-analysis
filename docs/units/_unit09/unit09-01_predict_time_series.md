---
title: Predict Your Temporal Data
header:
  image: "/assets/images/teaser/air_temperature.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---
Look into some specific characteristics of time series data and predict future observations based on past dynamics.

<!--more-->

## Learning objectives
At the end of this session you should be able to
* explain some basic characteristics of time series information,
* evaluate common requirements for predicting time series out of themselves, and
* use ARIMA models for short-term predictions of time series data.


## Time series data
Time series data describe how a variable changes over time. 

{% include figure image_path="/assets/images/air_temperature.jpg" alt="Air temperature time series data." %}

An important characteristic of time series is the autocorrelation between successive observations. 
This autocorrelation forms the basis for some kinds of _prediction_ or _gap filling_ models but it also has to be considered in time series _analysis_.

{% include figure image_path="/assets/images/air_temperature_auto-correlation.jpg" alt="Illustration of auto correlation of time series data." %}

The above graphic shows the auto-correlation between the individual mean monthly air temperatures shown in the first graph.

{% include figure image_path="/assets/images/air_temperature_partial_auto-correlation.jpg" alt="Illustration of auto correlation of time series data." %}

The above graphic shows the partial auto-correlation between the individual mean monthly air temperatures shown in the first graph.


## Comments?
You can leave comments below if you have questions or remarks about any of the text or code in this unit. 
Please copy the corresponding line into your comment to make it easier to answer your question.

<script src="https://utteranc.es/client.js" repo="GeoMOER/moer-mpg-data-analysis" issue-term="moer-mpg-data-analysis_unit09" theme="github-light" crossorigin="anonymous" async> </script> 
