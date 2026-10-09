---
title: "Unmarked Assignment: Hello R, Hello GitHub"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/title/title_1600_500.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This worksheet introduces you to R, R scripts, and R Markdown. You will run R commands in code chunks, combine code and explanations in one document, and use Git and GitHub to submit your work to your class repository.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client for working with Git.

## Hello R and GitHub submission
Create an R Markdown (`.Rmd`) document with HTML output for the following task.

1. Assign the value of five to a variable called `a` and the value of two to a variable called `b`.
1. Compute the sum, difference, product and ratio of a and b (a always in the first place) and store the results to four different variables called `r1`, `r2`, `r3`, and `r4`.
1. Create a vector `v1` which contains the values stored within the four variables from step 2.
1. Add a fifth entry to vector `v1` which represents `a` raised to the power of `b` (i.e. `a**b`).
1. Show the content of vector `v1` (e.g. use the `print` function or just type the variable name in a separate row).
1. Create a second vector `v2` which contains information on the type of mathematical operation used to derive the five results. Hence this vector should have five entries of values *sum*, *difference*,...
1. Show the content of vector `v2`.
1. Combine the two vectors `v1` and `v2` into a data frame called `df`. Each vector should become one column of the data frame so you will end up with a data frame having 5 rows and 2 columns.
1. Make sure that the column with the data of `v1` is named *Results* and `v2` is named *Operation*.
1. Show the entire content of `df`.
1. Show just the entry of the cell in the second row and first column.

Save your `.Rmd` file in your course repository and knit it to HTML. Commit both the `.Rmd` source and the generated HTML file, then push your changes to the GitHub classroom. Check that both files are present in your GitHub classroom repository.
{: .notice--info}

Completing the R code is only part of the assignment. You must also knit the document, commit the source and HTML files, and push them to your course repository on GitHub.
{: .notice--warning}


