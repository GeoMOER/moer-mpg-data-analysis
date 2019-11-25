---
title: Predict your linear data
---

Compute simple linear models to predict dependent data  and assess the performance by independent test samples.

<!--more-->

## Learning objectives
At the end of this session you should be able to
* evaluate the prediction performance of a statistical regression model,
* decide which cross-validation strategy to use, and
* compute and interpret some prediction error metrics.


## Basic idea of statistical prediction
Use observation samples to build a model which predicts the dependent variable based on one or more independent variables. 

{% include figure image_path="/assets/images/cross_validation.jpg" alt="Cross validation example using linear regressions" caption="Linear regression models computed with left-out data pairs." %}

The graphic above shows a scatter plot of data pairs between independent (X axis) and dependent (Y axis) variables. 
The red lines represent linear regression models, each computed on a different subset of the data pairs where one data pair has been removed. 
The difference between the left out observation and its prediction by the model provides an estimate for the error of the model predictions. 
Such an error estimation strategy is generally called (leave-one-out) _cross-validation_.

For a deeper look into cross-validation strategies related to spatially and temporally dependent data, have a look at [Meyer et al. 2018](https://www.sciencedirect.com/science/article/pii/S1364815217310976?via%3Dihub){:target="_blank"}

{% include figure image_path="https://imgs.xkcd.com/comics/extrapolating.png" alt="Comic illustrating extrapolation." caption_url="[CC-BY by xkcd.com](https://xkcd.com/605/){:target='_blank'}" %}
