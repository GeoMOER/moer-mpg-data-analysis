---
title: "Unmarked Assignment: Model Tuning"
header:
  image: "/assets/images/title/curve2.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
toc: true
toc_label: In this worksheet
---

This worksheet uses cross-validation strategies for tuning an additive model.

After completing this worksheet you should have improved your skills for handling cross-validation approaches.


## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} environment for your operating system. For Windows users with little experience on the command line we recommend [GitHub Desktop](https://desktop.github.com/){:target="_blank"}.
  * Wood harvest data from Hessen provided by the course instructors.


## Model tuning
For implementing a cross-validation-based and quite simple tuning of an additive model, we go back to the wood harvest data set. 
The aim is to predict beech harvest from oak harvest.

Write an R markdown script, which tunes the prediction of beech harvest based on oak harvest using an additive model. 
The tuning should run over the number of knots between 3 and 13, 
and the estimate of the model performance for each knot should be based on a cross validation repeated 100 times with 80 percent of the data set as training and the rest as testing samples.
The cross validation should be reproducible. 
Please visualize 
(i) the root mean square error, 
(ii) the root mean square error +/- its standard deviation and
(iii) the adjusted R squared as a function of increasing knots (i.e. knots should be on the x axis). 
Since the root mean square error is much larger than the R squared values, normalize the root mean square errors to their maximum for the visualization.

Save your Rmd file in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to the GitHub classroom.
Make sure that the created html file is also part of your GitHub classroom repository.



