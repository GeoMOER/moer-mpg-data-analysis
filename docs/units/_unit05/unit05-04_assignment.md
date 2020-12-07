---
title: "Marked Assignment: Recreation vs. Settlement"
toc: true
toc_label: In this worksheet
---

This worksheet tackles the question, how the percentage share of settlement area is related to the share of recreation area in each community.

After completing this worksheet you should be able to compute a linear regression model and have a first idea of how variable model results could be if only a slightly different sample is used.



## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operation system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend to use R Studio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} environment for your operating system. For Windows users with little experience on the command line we recommend [GitHub Desktop](https://desktop.github.com/){:target="_blank"}.
  * Data on percentage fraction of land use on a community level provided by the course instructors.


## Linear modeling and normal distribution of the residuals  
Please write an R markdown script which computes a linear regression model that relates the percentage recreation area (dependent variable) to the settlement area and visualize the relationship as a scatter plot with the linear modeled drawn in the same plot. Additionally compute a visualization which allows the assessment of the heteroscedasticity and the normal distribution of the residuals. 

Please write exactly one sentence which summarizes the key message of both the heteroscedasticity and normal distribution plot.

Once you have described your data, please have a closer look on the normal distribution assessment. For that, please evaluate how often a normal distribution test on the residuals would reject it's null-hypothesis if a regression model is not computed on the entire dataset but 100 regression models are computed on 100 sub-samples of the dataset. Each of the 100 sub-samples should contain 50 value pairs chosen randomly from the entire data set. Please state or visualize the result and discuss it with respect to sample design and the reliability of test results (three sentence max).

Save your R functions and Rmd file in your course repository, knitr it, update (i.e. commit) your local repository and publish (i.e. push) it to the GitHub classroom. Make sure that the created html file is also part of your GitHub repository.


This assignment will be marked.
{: .notice--info}

