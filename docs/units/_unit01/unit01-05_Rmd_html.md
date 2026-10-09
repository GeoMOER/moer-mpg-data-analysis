---
title: "Example: R Markdown with HTML output"
toc: true
toc_label: In this example
header:
  image: "/assets/images/title/title_1600_500.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This page shows the output of an R Markdown document. The course's code examples are generated from R Markdown sources.

## This is a header

This is an R Markdown document. Markdown is a simple formatting syntax for creating HTML, PDF, and MS Word documents. 
For more details, see the [R Markdown documentation](https://rmarkdown.rstudio.com){:target="_blank"}.

When you click **Knit** in RStudio, the generated document includes your text and the output of embedded R code chunks.
You can embed an R code chunk like this:


```r
summary(cars)
```

```
##      speed           dist       
##  Min.   : 4.0   Min.   :  2.00  
##  1st Qu.:12.0   1st Qu.: 26.00  
##  Median :15.0   Median : 36.00  
##  Mean   :15.4   Mean   : 42.98  
##  3rd Qu.:19.0   3rd Qu.: 56.00  
##  Max.   :25.0   Max.   :120.00
```


## This is another header

You can also embed plots, for example:

![Scatterplot of car speed against stopping distance from the cars dataset.]({{ site.baseurl }}/assets/images/rmd_images/rmd_html_out/unnamed-chunk-2-1.png)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot (see below).


## Markdown source
Copy the following example into an `.Rmd` file and click **Knit** to create an HTML document. The plot is generated from the `cars` dataset included with R. Generated images are saved in a local `figures/` directory.


``````markdown
---
title: "Example: R Markdown with HTML output"
author: "Thomas Nauss"
date: "10 Oktober 2018"
output: 
  html_document: 
    keep_md: yes
---
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(fig.path = 'figures/')
```

## This is a header

This is an R Markdown document. Markdown is a simple formatting syntax for creating HTML, PDF, and MS Word documents. 
For more details, see the [R Markdown documentation](https://rmarkdown.rstudio.com).

When you click **Knit** in RStudio, the generated document includes your text and the output of embedded R code chunks.
You can embed an R code chunk like this:

```{r}
summary(cars)
```

## This is another header

You can also embed plots, for example:

```{r, echo=FALSE, fig.alt="Scatterplot of car speed against stopping distance from the cars dataset."}
plot(cars)
```

The `echo = FALSE` parameter hides the R code that generates the plot. The `fig.alt` parameter provides alternative text for the image.

``````

## More fancy layouts?

For more styling options, see [Styling R Markdown documents](https://geomoer.github.io/moer-base-r/unit99/sl03_css.html){:target="_blank"}.



