---
title: "Code Styling"
toc: true
toc_label: In this example
---

Using a consistent and intuitive coding style helps both you as the programmer and others as re-users of your source code. A comprehensive coding style helps to read and understand the code and hence reduces the intrinsic complexity of programming. 

## Suggested code style for a starter
In the web, there are many *definitive* coding styles for all sorts of programming language and also they are called definitive, there is generally more than one style. Some to a certain degree consistent opinions you could use to build up your own mind and get a general idea of code styling can be found in an [RStudio's blog entry by Joseph Rickert](https://rviews.rstudio.com/2016/12/02/writing-good-r-code-and-writing-well/){:target="_blank"}.

In this course we suggest to follow the [style guide by Hadley Wickham](http://style.tidyverse.org/){:target="_blank"} published as part of the tydiverse package collection when you write scripts or functions. Note that when it comes to functions, the R community is equally using *lowerCamelCaseNames* instead of the *snake_case_names* suggested in the guide.

{% include figure image_path="https://imgs.xkcd.com/comics/code_quality.png" alt="XKCD comic on code quality." caption_url="[CC-BY-NC by xkcd.com](https://xkcd.com/1513/){:target='_blank'}" %}

## A note on roxygen documentation and R packages
While documentation is not for the R interpreter but for the user, documentation is mandatory required in R packages. R packages are the things which are installed or loaded if you type `install.packages(...)` or `library(...)` respectively. They are a collection of functions and classes written in R and maybe linked to C++ function or other fast running code to speed things up a little. For more information see e.g. [Hadley Wickham's book on R packages](http://r-pkgs.had.co.nz/){:target="_blank"}.

To streamline the documentation of R package functions and classes, the utilization of the roxygen2 library is the defacto standard. Using this library, the documentation can be written at the top of the respective R file which holds the function or class code. See e.g. the files within the *R* folder of the [mapview package at GitHub](https://github.com/r-spatial/mapview){:target="_blank"}. For more information a starting point is again the afore mentioned R packages book.

Please note that roxygen documentation has been developed for R packages but it is a very good idea to follow this syntax also for your individual scripts or functions in order to have a nice and informative header in your scripts.
{: .notice--info}

## Suggested documentation header
The following summarizes our suggestion for a documentation header to include in all scripts or functions even when these scripts are not part of an R package.

```R
#' Mandatory: One short line that summarizes for what the script or function is.
#'
#' @description Optional: One to three lines describing a little more about the
#' script or function.
#' 
#' @param Mandatory if function: One param at at time.
#'
#' @name Mandatory: Name of the script or function.
#'
#' @export Mandatory if function: Name of the function.
#' 
#' @details Optional: Whatever you need to describe regarding the functionality
#' and/or theoretical background of your script or function.
#' 
#' @references  Optional: If you use something from somebody else, handle it
#' like any other scientific reference/literature list.
#' 
#' @examples
#' \dontrun{
#' # Mandatory if part of R package.
#' }
#' 

<start here with your R code>

  
# Header for lager section e.g. read datasets ----------------------------------
<your R code>

# Short comment for a code snipet e.g. a complicated loop
<your R code>

```