---
title: Select your variables
---

Evaluate the importance of your independent variables and select an optimal subset for your prediction model.

<!--more-->

## Learning objectives
At the end of this session you should be able to
* discuss the importance of feature selection strategies in multiple variable models,
* decide which feature selection strategy to use in some standard cases,
* implement some basic feature selection strategies.


## Basic idea of variable selection
Use only those explanatory variables which best explain the dependent variable without overfitting the model to the sample.


{% include figure image_path="/assets/images/variable_selection.jpg" alt="Increasing and then decreasing R squared with increasing number of variables." caption="Influence of variables used for two regression models on model performance." %}

The graphic above shows how the cross-validation performance of two regression models typically changes with increasing number of independent variables used by the model. At first, more independent variables lead to a better performance (increasing R squared) but the maximum performance is reached quite fast. Afterwards, additional independent variables would still lead to the same or better "internal" model results as long as the performance meassure does not account for the number of variables but the increasing overfitting of the model to the data sample certainly leads to a decreasing performance in the cross-validation.

For a deeper look into variable selection have a look at [Meyer et al. 2016](https://www.mdpi.com/2072-4292/8/9/732){:target="_blank"}

{% include figure image_path="https://imgs.xkcd.com/comics/seat_selection.png" alt="Comic illustrating the selection of a seat in a plane." caption_url="[CC-BY by xkcd.com](https://xkcd.com/726/){:target='_blank'}" %}
