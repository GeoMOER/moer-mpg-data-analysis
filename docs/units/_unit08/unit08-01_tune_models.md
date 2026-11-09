---
toc: TRUE
title: "Tune Your Models"
header:
  image: "/assets/images/title/curve2.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Evaluate model tuning strategies and compare settings for your prediction model.

<!--more-->

## Learning objectives
At the end of this session you should be able to
* fit a generalized additive model (GAM) with a smooth response curve,
* compare one flexibility setting with others on the same held-out observations, and
* distinguish training fit, tuning scores and independent final evaluation.


## Basic idea of model tuning

{% include figure image_path="/assets/images/gam.png" alt="Schematic comparison of spline fits with increasing flexibility." %}

The graphic illustrates how a smooth curve can become more flexible. In the worked example, `k` limits how complex the curve can be; an optional penalty discourages unnecessary wiggles. We introduce both controls beside the first smooth fit.

Closer agreement with training observations does not establish better prediction. Use held-out scores to tune settings and keep final evaluation separate from that choice. The [worked example]({{ site.baseurl }}/unit08/unit08-02_generalized_additive_models.html) distinguishes these roles and defines the repeated-run metrics needed for the assignment.

For a reminder of how training R squared, held-out RMSE, and AIC differ, see [which measure answers which question in Unit 07]({{ site.baseurl }}/unit07/unit07-02_variable_selection.html#which-measure-answers-which-question).


## Comments?
You can leave comments below if you have questions or remarks about any of the text or code in this unit.
Please copy the corresponding line into your comment to make it easier to answer your question.

<script src="https://utteranc.es/client.js" repo="GeoMOER/moer-mpg-data-analysis" issue-term="moer-mpg-data-analysis_unit08" theme="github-light" crossorigin="anonymous" async> </script>

