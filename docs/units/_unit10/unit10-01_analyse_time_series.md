---
title: Analyse Your Temporal Data
---

Analyse your time series data and decompose it into seasonal characteristics and long-term trends.

<!--more-->

## Learning objectives
At the end of this session you should be able to
* explain some different strategies for time-series decomposition,
* discuss why some care should be taken in pre-processing time series prior to trend analysis,
* use e.g. linear models for explaining trends.


## Time series decomposition
Dynamics of environmental variables are often composed of very short term, intermediate (seasonal) and long-term (trend) variations. When analysing time series data, the decomposition into the respective components offers insights into driver-response relationships as basis for further analysis.

{% include figure image_path="/assets/images/time_series_decomposition.jpg" alt="Illustration of time series decomposition using the R CO2 dataset as an example." %}

The above graphic shows the decomposition of the CO2 dataset from R's forecast library.