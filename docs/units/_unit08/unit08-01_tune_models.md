---
title: "Tune your model"
header:
  image: "/assets/images/title/curve2.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Evaluate model tuning strategies and find optimal settings for your prediction model.

<!--more-->

## Learning objectives
At the end of this session you should be able to
* explain some basic principles of (general) additive models and the LOESS smoother,
* discuss the importance of model tuning and its tripping hazards, and
* implement some basic model tuning strategies.


## Basic idea of model tuning

{% include figure image_path="/assets/images/gam.jpg" alt="Illustration of a generalized additive model with increasing knots." %}

The graphic above shows how a changing number of knots affects the result of a generalized additive model (GAM). With increasing knots, the model becomes more flexible to adapt itself to the dataset. By increasing the number of knots, the dataset provided to the model is fitted with increasing accuracy. However, overfitting of the sample dataset increases, too.


## Comments?
You can leave comments below if you have questions or remarks about any of the text or code in this unit. 
Please copy the corresponding line into your comment to make it easier to answer your question.

<script src="https://utteranc.es/client.js" repo="GeoMOER/moer-mpg-data-analysis" issue-term="moer-mpg-data-analysis_unit08" theme="github-light" crossorigin="anonymous" async> </script> 

