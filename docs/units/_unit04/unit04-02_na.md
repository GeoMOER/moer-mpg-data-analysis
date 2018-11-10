---
title: "Example: Missing Values"
toc: true
toc_label: In this example
---


Handling missing values is straight forward. Let's start with a vector with one
NA value at position 3. Please note that NA is not inside quotation marks since
it is not a string but a special type of logical data type.


```r
x <- c("A", "B", NA, "D")
```
To check, if the vector has one or more "not available" values, use the 
`is.na` function.

```r
is.na(x)
```

```
## [1] FALSE FALSE  TRUE FALSE
```
It returns another vector which gives a TRUE/FALSE answer of the question for 
each value in the data structure.

If, for any reason, we want to assign the term "no value" to NAs, the scripting
is quite simple and follows the standard logic.

```r
x[is.na(x)] <- "no value"
```
