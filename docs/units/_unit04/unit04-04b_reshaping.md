---
title: "Example: Reshaping and Grouped Summaries"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

## Define one observation first

A **wide** table stores different measurements in different columns. A **long** table puts a measurement name in one column and its value in another. Both can be appropriate; reshaping changes what a row represents, rather than improving a table automatically.

## A small wide table

```r
wide <- data.frame(
  ID = c("01", "02"),
  Year = c(2024L, 2024L),
  Height_m = c(18.5, 16.2),
  Crown_m = c(4.0, 3.5),
  stringsAsFactors = FALSE
)
wide
```

Here one row is one site in one year. `ID` and `Year` identify it; height and crown diameter are in meters.

## Stack measurements into rows

Use `reshape()`, which is included with R. First name the measurement columns to combine:

```r
measurements <- c("Height_m", "Crown_m")
long <- reshape(
  wide, direction = "long",
  idvar = c("ID", "Year"), varying = measurements,
  timevar = "Measurement", times = measurements,
  v.names = "Value_m"
)
long
```

The arguments describe the change:

- `idvar` identifies each original row.
- `varying` lists the columns to combine.
- `timevar` names the new label column; `times` supplies its labels. Here these labels identify measurements, rather than dates.
- `v.names` names the new value column.

There are now four rows: two sites multiplied by two measurements. One row represents one measurement at one site in one year. Its key is `ID`, `Year` **and** `Measurement`. Missing measurements remain in the table.

## Return to wide form

```r
anyDuplicated(long[c("ID", "Year", "Measurement")])
restored <- reshape(long, direction = "wide")
restored
```

The duplicate check should return zero: each key identifies one value. Investigate duplicates before reshaping; several values cannot occupy the same output cell.

Because `long` was created with `reshape()`, it retains the information needed to reverse the conversion. Setting `direction = "wide"` restores the original measurement columns. This short form relies on that information remaining attached to the table.

## Summarize groups deliberately

```r
aggregate(Height_m ~ Year, data = wide, FUN = mean)
```

For 2024, this returns the unweighted mean **17.35 m** across two sites. Aggregation reduces several observations to a summary; reshaping merely rearranges them.

A regional percentage or yield is not an additive total. Summing percentages from overlapping administrative areas is invalid, and an unweighted average across districts does not generally reproduce a national percentage or yield. The worked regional example therefore retains individual region-year observations.

## Use each form for its purpose

The land-use exercise creates a long view to illustrate reshaping, then saves the validated **wide** table for regression in Units 05–06. The crop assignment also produces a wide table for Unit 07.

See the R documentation for [`reshape()`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/reshape.html) and [`aggregate()`](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/aggregate.html).
