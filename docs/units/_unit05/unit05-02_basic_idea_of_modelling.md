---
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
The model coefficients are given in the equation. Residual values are additionally indicated by red lines. 

## What do we want to learn from a model?

**Description** summarizes patterns in the observed data. **Inference** uses a sample and statistical assumptions to estimate relationships or parameters beyond that sample and express uncertainty about them. **Prediction** estimates responses for observations whose outcomes are unknown.

For our land-use example, inference might ask how recreation share is associated with settlement share, and how uncertain the estimated slope is. Prediction asks how accurately recreation share can be estimated for a district whose response was not used in fitting. The same regression can serve both purposes, but the evidence needed to assess it differs. An association alone does not establish a causal effect.

For another introduction to this distinction, see the prediction and inference examples in [Stanford's statistical-learning lecture](https://web.stanford.edu/class/archive/stats/stats202/stats202.1162/content/lec2.pdf).

## Linear regression 101
Using statistical models for relating independent and dependent variables in order to describe relationships between the recorded data pairs or predict (interpolate) values in a range where no data pairs have been observed is a key method in environmental sciences. A bivariate linear regression model is the simplest form of such a statistical model. However, if the quality of a linear regression model is assessed by the commonly computed internal test statistics (e.g. p-values, t-test, R-squared), the following aspects have to be kept in mind (Y is the dependent, X the independent variable):     

* For a simple straight-line model, the conditional mean of Y should be adequately described by a line in X. Residual plots help reveal remaining curvature.
* The usual standard errors, t/F tests and intervals assume a constant error variance and independent errors. Use the study design as well as the diagnostic plots when assessing these assumptions.
* A normal-error model supports the usual small-sample t/F reference distributions and intervals. Neither X nor the pooled Y values have to be normally distributed. We examine fitted residuals as evidence about the unobserved errors.
* The observed X values can come from a random sample. Substantial measurement error in X can affect the fitted relationship and needs consideration.
* With several predictors, exact linear dependence prevents separate estimation of their coefficients; strong dependence can make estimates unstable. Multiple regression is introduced later.

These checks support careful interpretation rather than proving that a model is correct. The [minimum-assumptions walkthrough]({{ site.baseurl }}/unit05/unit05-03a_assumptions.html#minimum-assumptions-for-bivariate-linear-regression-models) explains how to inspect residuals before the assignment.

R-squared and the fitting tests summarize the data used to estimate the model. They do not by themselves measure prediction quality for new observations; independent evaluation follows in later units.

{% include figure image_path="https://imgs.xkcd.com/comics/linear_regression.png" alt="Comic illustrating scatter plots with almost no linear relationship." caption_url="[Randall Munroe / xkcd, CC BY-NC 2.5](https://xkcd.com/1725/){:target='_blank'}" %}


## Where does this course fit?

The following perspectives and fields overlap. They help us distinguish how we express uncertainty, how we fit models, and what we want to learn from data.

| Perspective or field | Main idea |
|---|---|
| **Frequentist statistics** | Evaluates estimation and uncertainty through the behavior of procedures under repeated sampling. Familiar examples include confidence intervals and hypothesis tests. |
| **Likelihood-based methods** | Use the likelihood to compare how well parameter values account for the observed data under a probability model. Maximum likelihood estimates parameters; AIC uses the fitted likelihood and a complexity penalty. Likelihood also appears in frequentist and Bayesian methods. |
| **Bayesian statistics** | Combines a prior distribution with the likelihood to obtain a posterior distribution describing uncertainty about parameters. |
| **Machine learning** | Studies methods that learn patterns from data, including supervised prediction and unsupervised tasks such as clustering. It overlaps substantially with statistics. |
| **Deep learning** | A part of machine learning using neural networks with multiple layers to learn representations and relationships. |

Frequentist and Bayesian reasoning can both support inference and prediction, including within machine learning. [Chapter 5 of *Deep Learning*](https://www.deeplearningbook.org/contents/ml.html) introduces these connections.

We begin with least-squares regression and frequentist tests, then introduce [predictive evaluation in Unit 06]({{ site.baseurl }}/unit06/unit06-01_predict_linear_data.html), [likelihood-based model selection in Unit 07]({{ site.baseurl }}/unit07/unit07-02_variable_selection.html#which-measure-answers-which-question), and [tuning in Unit 08]({{ site.baseurl }}/unit08/unit08-01_tune_models.html). Linear regression itself can be used within frequentist, likelihood-based, Bayesian, and machine-learning workflows.

## Exercise: Explain the basics of linear regression {#linear-regression-kick-off}

To get an overview of linear regression, you can watch the videos below or do some internet research on your own. There are some great tutorials out there.

1. [Fitting a line to data](https://www.youtube.com/watch?v=PaFPbb66DxQ)
2. [Linear Models Part 1](https://www.youtube.com/watch?v=nk2CQITm_eo)
3. [Linear Models Part 2](https://www.youtube.com/watch?v=NF5_btOaCig)
4. [Linear Regression in R](https://www.youtube.com/watch?v=u1cc1r_Y7M0)

Try to answer the following questions:

* What is a linear regression and how does it work?
* What types of sums of squares can be calculated and why are they important?
* What are *p* and *r*<sup>2</sup> values?
