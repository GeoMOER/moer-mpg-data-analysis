---
title: "Unmarked Assignment: Loop and Conquer"
toc: true
toc_label: In this worksheet
header:
  image: "/assets/images/title/title_1600_500.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This worksheet lets you practice control structures and loops in R. First complete the [required preparation on operations]({{ site.baseurl }}/unit02/unit02-05_operations.html#required-preparation), including functions, returned values and `lapply()`.

## Things you need for this worksheet
  * [R](https://cran.r-project.org/){:target="_blank"} — the interpreter can be installed on any operating system.
  * [RStudio](https://www.rstudio.com/){:target="_blank"} — we recommend using RStudio for (interactive) programming with R.
  * [Git](https://git-scm.com/downloads){:target="_blank"} installed and available to RStudio. [GitHub Desktop](https://desktop.github.com/){:target="_blank"} is an optional graphical client.

## Loop till you drop
Write an R Markdown (`.Rmd`) document with HTML output for the following tasks. Save it beside the `.Rproj` file in your course repository; the [shared project layout]({{ site.baseurl }}/unit03/unit03-02a_organize_your_data_files.html#common-project-layout) explains the folder roles used later. Set `n` to a value before testing the first three statements.

1. Implement an if-then-else statement which prints "larger" if the number provided as variable `n` is larger than three and "equal or smaller" otherwise.
1. Extend a copy of the above statement (i.e. copy the entire if-then-else statement and include it a second time in your script in order to preserve both versions) so that it prints "equal" and "smaller" explicitly in addition to "larger".
1. Implement an if-then-else statement which prints "even" if the integer provided as variable `n` is even and which prints "odd" otherwise.
1. Copy the extended larger/equal/smaller if-then-else statement and include it in a for loop over values below, equal to, and above 3 (for example, 2, 3, and 4). Check that all three outcomes occur.
1. Extend a copy of the above loop and modify the loop and if-then-else statement in such a way that the information on "larger" etc. is not printed on the screen but saved within a vector (i.e. a variable which will hold all three statements in the end). Print the content of this vector after the loop.
1. Extend a copy of the above modified loop in such a way that the results are not saved in a vector but a list. Print the content of this list after the loop.
1. Replace the for loop in the preceding step with `lapply`. Save the returned list in a variable and print it.
1. Add one more line to flatten that list into a vector and print the vector.

Save your R Markdown (.Rmd) document in your course repository, knit it, update (i.e. commit) your local repository and publish (i.e. push) it to GitHub.
Make sure that the created HTML file is also part of your course repository on GitHub.
{: .notice--info}

