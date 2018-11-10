---
title: Clean Your Data
---

Check the integrity of datasets and clean them up to ensure that the data basis for your analysis is consistent.

<!--more-->

## Learning objectives
At the end of this unit you should be able to
* identify some common problems in the structure of data frames,
* subset, merge, separate a data frame in order to clean it.

## Cleaning 101
Cleaning dataset is a standard procedure in data analysis and the most annoying. It can be quite time consuming but it is the most important step in data analysis. If your data base is incorrect, the analysis results and your scientific study is not reliable. Hence, carefully check your data and clean it thoroughly.

To start with, Hadley Wickham suggest the following:
* separate column for each variable 
* exactly one kind of information per variable
* separate row for each observation
* separate data set for each kind of observation
See [Wickham (2012)](https://www.jstatsoft.org/article/view/v059i10){:target="_blank"} for more on these topics.

Note that one cannot provide a complete list of check and cleaning tasks since the workflow always depends on the actual dataset.
{: .notice--info}

{% include figure image_path="https://imgs.xkcd.com/comics/exploits_of_a_mom.png" alt="Picture illustratinc data cleaning as a comic." caption_url="[CC-BY by xkcd.com](https://xkcd.com/327/){:target='_blank'}" %}

