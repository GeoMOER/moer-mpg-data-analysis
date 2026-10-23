---
title: "Unmarked Assignment: Model Tuning"
header:
  image: "/assets/images/title/curve2.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
toc: true
toc_label: In this worksheet
---

This worksheet uses cross-validation strategies for tuning an additive model.

After completing this worksheet you should have improved your skills in using cross-validation approaches.


## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client.
  * The file `hessen_holzeinschlag_2003-2025.csv` from ILIAS, used in [Assignment 03]({{ site.baseurl }}/unit03/unit03-07_assignment.html).


## Model tuning
For implementing a cross-validation-based and quite simple tuning of an additive model, we go back to the wood harvest data set for Hessen, using the 23 calendar years from 2003 to 2025. Import the annual observations, excluding the four introductory lines and the final notes.
The aim is to predict harvest in the beech and other deciduous trees group (`Beech_other_deciduous`) from harvest in the oak and red oak group (`Oak_red_oak`). Both columns are measured in 1,000 m³ without bark; they represent wood type groups, not individual species.

Write an R Markdown document, which tunes the prediction of `Beech_other_deciduous` harvest based on `Oak_red_oak` harvest using an additive model.
The tuning should run over the number of knots between 3 and 13, 
and the estimate of the model performance for each number of knots should be based on a cross-validation repeated 100 times with 80 percent of the data set as training and the rest as testing samples.
The cross-validation should be reproducible.
Please visualize 
(i) the root mean square error, 
(ii) the root mean square error +/- its standard deviation and
(iii) the adjusted R squared as a function of the number of knots (i.e. knots should be on the x axis).
Since the root mean square error is much larger than the R squared values, normalize the root mean square errors to their maximum for the visualization.

Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.



