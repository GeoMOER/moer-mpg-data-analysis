---
title: "Unmarked Assignment: Loop and Conquer"
toc: true
toc_label: In this worksheet
---

This worksheet provides some control structure and loop examples to help you getting familiar with these probably most important properties of any programming language.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operation system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend to use R Studio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} environment for your operating system. For Windows users with little experience on the command line we recommend [GitHub Desktop](https://desktop.github.com/){:target="_blank"}.

## Loop till you drop
Please write an R script as an Rmd file with html output for the following task and commit it to your GitHub-based learning log:

1. Implement an if-then-else statement which prints "larger" if the number provided as variable `n` is larger than 1 and "equal or smaller" otherwise.
1. Extent a copy of the above statement (i.e. copy the entire if-then-else statement and include it a second time in your script in order to preserve both versions) which returns "equal" and "smaller" explicitly in addition to "larger".
1. Implement a if-then-else statement which prints "even" if the number provided as variable `n` is even and which prints "odd" otherwise.
1. Copy the extended larger/equal/smaller if-then-else statement and include it into a for loop which shows that all three options are actually implemented in a correct manner by iterating over `n` from a number which is smaller 1, exactly 1 and larger than 1.
1. Extent a copy of the above loop and modify the loop and if-then-else statement in such a way, that the information on "larger" etc. is not printed on the screen but saved within a vector (i.e. a variable which will hold all three statements in the end). Print the content of this vector after the loop.
1. Extent a copy of the above modified loop in such a way, that the results are not saved in a vector but a list. Print the content of this list after the loop.
1. Change the above modified loop in such a way, that the iteration is controlled by a `lapply` not by a for-loop. Save the returning information from the `lapply` function in a variable and print the content of this variable after the loop.
1. Finally change the above variable (i.e. do not modify the loop anymore but just include one more line) in such a way that the content is not printed as a nested list but a vector (i.e. flatten the list).

Save your Rmd file in your course repository, knitr it, update (i.e. commit) your local repository and publish (i.e. push) it to the GitHub classroom. Make sure that the created html file is also part of your GitHub repository.


