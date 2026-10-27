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
