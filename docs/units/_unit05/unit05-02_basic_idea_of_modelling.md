---
toc: TRUE
title: "Basic Idea of Statistical Modeling"
header:
  image: "/assets/images/teaser/linear_5_1.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---


## Basic idea of statistical modeling
Use observation samples to describe the relationship between a dependent variable and one or more independent variables.

{% include figure image_path="/assets/images/linear_regression.png" alt="Linear regression with residuals" caption="Linear regression with residuals." %}

The graphic above shows a scatter plot of data pairs between an independent (X axis) and a dependent (Y axis) variable.
The relationship is estimated by a linear regression model illustrated by a blue line.
The equation describes the fitted line. The red vertical lines show **residuals**: each observed response minus its fitted value.

## What do we want to learn from a model?

**Description** summarizes patterns in the observed data. **Inference** uses a sample and statistical assumptions to estimate relationships or parameters beyond that sample and express uncertainty about them. **Prediction** estimates responses for observations whose outcomes are unknown.

For our land-use example, inference might ask how forest share is associated with agricultural share, and how uncertain the estimated slope is. Prediction asks how accurately forest share can be estimated for a district whose response was not used in fitting. The same regression can serve both purposes, but the evidence needed to assess it differs. An association alone does not establish a causal effect.

For another introduction to this distinction, see the prediction and inference examples in [Stanford's statistical-learning lecture](https://web.stanford.edu/class/archive/stats/stats202/stats202.1162/content/lec2.pdf).

## Linear regression 101
A **bivariate linear regression** describes the mean response using one predictor and a straight line. Here, “mean response” means the average response we would expect at a given predictor value; individual observations can lie above or below it.

First fit the line, then check whether that description is plausible. Look for remaining curves, changing residual spread and unusually influential observations. The usual tests and uncertainty calculations also rely on assumptions about the errors and independence of observations. The [assumptions walkthrough]({{ site.baseurl }}/unit05/unit05-03a_assumptions.html#minimum-assumptions-for-bivariate-linear-regression-models) introduces each check when you use it.

R² describes the fraction of response variation accounted for in the fitting data. It does not by itself measure prediction quality for new observations; that follows in Unit 06.

{% include figure image_path="https://imgs.xkcd.com/comics/linear_regression.png" alt="Comic illustrating scatter plots with almost no linear relationship." caption_url="[Randall Munroe / xkcd, CC BY-NC 2.5](https://xkcd.com/1725/){:target='_blank'}" %}


## Where does this course fit?

This is an **applied statistical modeling course for physical geography**. We begin with frequentist inference: estimate a relationship and discuss its uncertainty using tests and model assumptions. We then move toward predictive modeling: check performance on observations not used to fit the model, compare models and tune their flexibility. This part overlaps with supervised machine learning, where known predictor–response pairs are used to learn a prediction rule. Bayesian methods and deep learning provide context here; we do not fit those models in this course.

The following perspectives and fields overlap. They help us distinguish how we express uncertainty, how we fit models, and what we want to learn from data.

| Perspective or field | Main idea |
|---|---|
| **Frequentist statistics** | Evaluates estimation and uncertainty through the behavior of procedures under repeated sampling. Familiar examples include confidence intervals and hypothesis tests. |
| **Likelihood-based methods** | Use the likelihood to compare how well parameter values account for the observed data under a probability model. Maximum likelihood estimates parameters; AIC uses the fitted likelihood and a complexity penalty. Likelihood also appears in frequentist and Bayesian methods. |
| **Bayesian statistics** | Combines a prior distribution with the likelihood to obtain a posterior distribution describing uncertainty about parameters. |
| **Machine learning** | Studies methods that learn patterns from data, including supervised prediction and unsupervised tasks such as clustering. It overlaps substantially with statistics. |
| **Deep learning** | A part of machine learning using neural networks with multiple layers to learn representations and relationships. |

Frequentist and Bayesian reasoning can both support inference and prediction, including within machine learning. [Chapter 5 of *Deep Learning*](https://www.deeplearningbook.org/contents/ml.html) introduces these connections.

Follow that progression through [prediction checks in Unit 06]({{ site.baseurl }}/unit06/unit06-01_predict_linear_data.html), [model selection in Unit 07]({{ site.baseurl }}/unit07/unit07-02_variable_selection.html#which-measure-answers-which-question), and [tuning in Unit 08]({{ site.baseurl }}/unit08/unit08-01_tune_models.html). We introduce the comparison measures when we need them.

## Exercise: Explain the basics of linear regression {#linear-regression-kick-off}

Use the questions below for a short discussion, then revisit your answers after the worked example and assumptions walkthrough. The videos are optional support for preparation or review; you do not need to watch all four.

1. [Fitting a line to data](https://www.youtube.com/watch?v=PaFPbb66DxQ)
2. [Linear Models Part 1](https://www.youtube.com/watch?v=nk2CQITm_eo)
3. [Linear Models Part 2](https://www.youtube.com/watch?v=NF5_btOaCig)
4. [Linear Regression in R](https://www.youtube.com/watch?v=u1cc1r_Y7M0)

Try to answer the following questions:

* What is a linear regression and how does it work?
* What types of sums of squares can be calculated and why are they important?
* What are *p* and *R*<sup>2</sup> values?
