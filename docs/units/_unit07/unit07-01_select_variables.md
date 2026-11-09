---
toc: TRUE
title: "Select Your Variables"
header:
  image: "/assets/images/teaser/ffs_beta2.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics){:target="_blank"}'
---

Evaluate the importance of your independent variables and select a useful subset for your prediction model.

<!--more-->

## Learning objectives
At the end of this session you should be able to
* compare one predictor addition with the current model,
* explain why AIC and held-out RMSE answer different questions, and
* implement forward selection with a clear stopping rule.


## Basic idea of variable selection
Add explanatory variables only when they improve the chosen comparison score. **Overfitting** means following chance features of the training sample that do not help prediction.


{% include figure image_path="/assets/images/variable_selection.jpg" alt="Increasing and then decreasing R squared with increasing number of variables." caption="Influence of variables used for two regression models on model performance." %}

The graphic illustrates a possible pattern: held-out performance improves with useful predictors, then worsens as more predictors are added. This decline is possible, not inevitable. Ordinary training R² cannot decrease when predictors are added on the same rows, so training fit alone is not a sufficient selection rule. The worked example compares models using AIC (a balance between fit and complexity) and held-out RMSE (prediction error).

Scores used to choose predictors belong to model selection. The [worked example]({{ site.baseurl }}/unit07/unit07-02_variable_selection.html#keep-final-evaluation-independent) shows how a reserved test set provides a separate final assessment after that choice.

For a deeper look into variable selection have a look at [Meyer et al. 2016](https://www.mdpi.com/2072-4292/8/9/732){:target="_blank"}

{% include figure image_path="https://imgs.xkcd.com/comics/seat_selection.png" alt="Seat Selection comic: a traveler clicks the cockpit on an airline seat diagram and finds herself flying the plane." caption_url="[Randall Munroe / xkcd, CC BY-NC 2.5](https://xkcd.com/726/){:target='_blank'}" %}


## Comments?
You can leave comments below if you have questions or remarks about any of the text or code in this unit.
Please copy the corresponding line into your comment to make it easier to answer your question.

<script src="https://utteranc.es/client.js" repo="GeoMOER/moer-mpg-data-analysis" issue-term="moer-mpg-data-analysis_unit07" theme="github-light" crossorigin="anonymous" async> </script>
