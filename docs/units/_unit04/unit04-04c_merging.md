---
title: "Example: Matching Tables by Keys"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

## Match observations, not row positions

A **key** identifies an observation. Joining by a key combines columns from matching records even when the two tables are in different orders.

## A small example

```r
measurements <- data.frame(
  ID = c("01", "02", "03"),
  Height_m = c(18.5, 21.0, 16.2),
  stringsAsFactors = FALSE
)
metadata <- data.frame(
  ID = c("02", "01"),
  Place = c("Hillford", "Riverdale"),
  stringsAsFactors = FALSE
)
anyDuplicated(metadata$ID)
setdiff(measurements$ID, metadata$ID)
```

The first check should return **0**: no metadata ID is repeated. `setdiff()` finds measurement IDs absent from the metadata table; here it returns `03`. This site has a height but no place description. A matching result can be incomplete even when the code runs without an error.

```r
joined <- merge(measurements, metadata, by = "ID", all.x = TRUE)
joined
nrow(joined) == nrow(measurements)
```

`all.x = TRUE` retains every row from the first table, `measurements`. The unmatched ID receives `NA` for `Place`. The row count is still three. Without `all.x = TRUE`, only matching IDs remain. Choose the behavior deliberately.

## Check matches and row order {#check-cardinality-and-order}

If metadata contains two matching rows for the same ID, a join can multiply measurement rows. Check that the key is unique in the table supplying the descriptions **before** joining, and compare row counts afterward. `merge()` sorts by the key by default; never rely on its output having the input's row order.

In the regional example, records repeat across years. Use `by = c("ID", "Year")` when the metadata is specific to a region-year observation. Do not assume that an administrative name or status is constant throughout a historical series.

## Handle column names explicitly

When non-key columns have the same name in both tables, `merge()` adds `.x` and `.y` by default to distinguish their origins. These suffixes refer to the first and second table. They do not describe coordinates or the meaning of a variable. Select and name your intended columns before joining when practical.

Keep identifier types consistent, especially leading zeros.

See [merging in Base R](https://geomoer.github.io/moer-base-r/unit08/unit08-04_merging.html) and the [R documentation for `merge()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/merge.html).
