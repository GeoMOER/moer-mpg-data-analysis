---
title: "Example: Missing Values"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

## What a missing value means

A missing value records information that is unavailable. It is different from a measured zero. R represents missing values with `NA`, without quotation marks; `"NA"` is ordinary text. Although the constant `NA` is logical, R converts it to the appropriate type when it is placed in a character or numeric vector.

```r
x <- c("A", "B", NA, "D")
is.na(x)
```

```text
[1] FALSE FALSE  TRUE FALSE
```

`is.na()` asks whether each entry is missing. Use it instead of `x == NA`: a comparison with an unknown value does not establish equality.

## Count before making a decision

The following invented table contains three measurements. Create it directly in R; no download is required.

```r
measurements <- data.frame(
  ID = c("01", "02", "03"),
  Height_m = c(18.5, NA, 16.2),
  stringsAsFactors = FALSE
)
colSums(is.na(measurements))
```

```text
      ID Height_m
       0        1
```

`is.na(measurements)` produces a logical table and `colSums()` counts the missing entries in each column. Inspect the affected rows before deciding what to do:

```r
measurements[is.na(measurements$Height_m), ]
mean(measurements$Height_m)
mean(measurements$Height_m, na.rm = TRUE)
```

The first mean is `NA`. With `na.rm = TRUE`, the mean is **17.35 m**, calculated from the two available heights. Report that one of three measurements was unavailable: excluding it does not recover its value or remove possible bias.

Keep numerical columns numerical. Replacing an unavailable height with `"no value"` would turn the entire column into text. A display label can be created in a separate character column if needed.

## Preserve source symbols

Official tables can use symbols such as `-`, `.`, or `/`. Their meanings depend on the source documentation. Inspect them as text before converting a column to numbers. Preserve the original tokens so that different reasons for an unavailable number remain distinguishable.

```r
reported <- c("18,5", ".", "16,2")
table(reported, useNA = "ifany")
```

If the documentation says that `.` represents an unavailable number, create a numerical version while retaining `reported`:

```r
height <- reported
height[height == "."] <- NA
height <- as.numeric(sub(",", ".", height, fixed = TRUE))
```

This example explains a conversion rule; it does not assign meanings to every symbol in the regional crop file. An unexplained token should lead to a documented question, not an automatic replacement with zero.

## Apply this to the regional data

In the worked cleaning example and crop assignment:

- count source symbols and missing entries before and after conversion;
- explain the chosen treatment for each documented symbol;
- retain source codes alongside numerical data where they carry additional information;
- distinguish an optional missing descriptor from an unavailable measurement;
- explain exclusions and check how many observations remain for analysis.

A table with no missing cells can still be wrong. The goal is a dataset whose values and limitations you can explain. See the [R documentation for missing values](https://stat.ethz.ch/R-manual/R-devel/library/base/html/NA.html).
