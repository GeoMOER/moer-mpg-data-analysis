---
title: Tune your model
---

Evaluate model tuning strategies and find optimal settings for your prediction model.

<!--more-->

## Learning objectives
At the end of this session you should be able to
* explain some basic principles of (general) additive models and the LOESS smoother
* discuss the importance of model tuning and it's tripping hazards
* implement some basic model tuning strategies


## Basic idea of model tuning
Use the optimal model settings for a given set of explanatory variables in order to best explain the dependent variable without overfitting the model to the sample.

{% include figure image_path="/assets/images/gam.jpg" alt="Illustration of a generalized additive model with increasing knots." %}

The graphic above shows how a changing number of knots affects the result of a generalized additive model (GAM). With increasing knots, the model becomes more flexible to adapt itself to the dataset. By increasing the number of knots, the dataset provided to the model is fitted with increasing accuracy. However, overfitting to the sample dataset increases, too.


