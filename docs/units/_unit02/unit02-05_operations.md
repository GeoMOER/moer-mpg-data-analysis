---
title: Operations
header:
  image: "/assets/images/title/title_1600_500.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics){:target="_blank"}'
---

Learn how operators, conditions, loops and functions work together.
<!--more-->

## Required preparation

Work through the following parts of the accompanying Base R course in order. Focus on understanding a small example for each operation before starting Assignment 02.

| Topic | What you need to be able to do |
|---|---|
| [Operators](https://geomoer.github.io/moer-base-r/unit07/unit07-02_operators.html) | Calculate values and compare them; distinguish assignment from comparison. |
| [If-then-else](https://geomoer.github.io/moer-base-r/unit07/unit07-04_if-then-else.html) | Choose an action using a logical condition. |
| [For loops](https://geomoer.github.io/moer-base-r/unit07/unit07-05_for-loops.html) | Repeat an operation over a sequence and store the results. |
| [Functions](https://geomoer.github.io/moer-base-r/unit07/unit07-06_functions.html) | Define an input, call a function and explain the value it returns. |
| [The apply family](https://geomoer.github.io/moer-base-r/unit07/unit07-07_apply.html) and [lapply: basic structure](https://geomoer.github.io/moer-base-r/unit07/unit07-08_lapply.html#basic-structure) | Pass a function to `lapply()` and keep its returned list. |

A function returns the value of its last expression, or a value supplied with `return()`. `lapply()` collects one returned result for each input element in a list. Assign that list to an object to keep it. `unlist()` flattens a list into a vector; combining different types can convert the values to a common type.

You should be able to explain the difference between printing a result and returning it. These ideas are reused when you write a cleaning function in Unit 04. The later examples on while loops and more elaborate uses of `lapply()` are additional reading.

## Additional explanations

See the [Base R module overview](https://geomoer.github.io/moer-base-r/unit07/unit07-01_Intro.html), the [Quick-R operators page](https://www.statmethods.net/management/operators.html) or the [DataCamp video](https://www.youtube.com/watch?v=qvSKipqzg3U).
