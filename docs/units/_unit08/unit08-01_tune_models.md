---
title: "Tune Your Models"
header:
  image: "/assets/images/title/curve2.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Evaluate model tuning strategies and find optimal settings for your prediction model.

<!--more-->

## Learning objectives
At the end of this session you should be able to
* explain some basic principles of generalized additive models and the LOESS smoother,
* discuss the importance of model tuning and its tripping hazards, and
* implement some basic model tuning strategies.


## Basic idea of model tuning

{% include figure image_path="/assets/images/gam.png" alt="Schematic comparison of spline fits with increasing flexibility." %}

The graphic illustrates how a spline can become more flexible. In `mgcv::s()`, `k` specifies the **basis dimension**, not a literal number of knots. With a penalized smooth, the smoothing parameter also controls the effective flexibility; a larger `k` does not force a more variable fit.

Closer agreement with training observations does not establish better prediction. Use held-out scores to tune settings and keep final evaluation separate from that choice. The [worked example]({{ site.baseurl }}/unit08/unit08-02_generalized_additive_models.html) distinguishes these roles and defines the repeated-run metrics needed for the assignment.


## Comments?
You can leave comments below if you have questions or remarks about any of the text or code in this unit. 
Please copy the corresponding line into your comment to make it easier to answer your question.

<script src="https://utteranc.es/client.js" repo="GeoMOER/moer-mpg-data-analysis" issue-term="moer-mpg-data-analysis_unit08" theme="github-light" crossorigin="anonymous" async> </script> 

