---
title: "Example: Splitting Text"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

## Separate text without inventing information

A label can contain several pieces of information. First split the text mechanically; then decide what each part means. Preserve the original label throughout. This example builds on [Unit 02's functions, returned values and `lapply()`]({{ site.baseurl }}/unit02/unit02-05_operations.html#required-preparation).

## Split a small example

```r
labels <- c("  Riverdale, District",
            "Hillford, State capital, Urban district",
            "Cedar City")
parts <- strsplit(trimws(labels), ",", fixed = TRUE)
parts
```

`trimws()` removes leading and trailing whitespace. `strsplit()` returns a **list** because labels can contain different numbers of parts. `fixed = TRUE` treats the comma as a literal delimiter. For example, the first label has two parts, the second three, and the last only one.

```r
parts <- lapply(parts, trimws)
place <- lapply(parts, function(x) x[1])
place <- unlist(place)
descriptors <- lapply(parts, function(x) x[-1])
place
```

`lapply()` applies `trimws()` to each list element, then extracts the first part of each label. As in Unit 02, `unlist()` combines those returned results into a vector: `Riverdale`, `Hillford`, `Cedar City`. `x[-1]` retains the remaining parts in `descriptors`. The last label has no descriptor.

## Recognize only documented categories

For each label, keep the entries from `known_types` that occur among its descriptors. `%in%` tests this membership. Accept a type only when there is exactly one match; otherwise return a missing character value.

```r
known_types <- c("District", "Urban district")
admin_unit <- lapply(descriptors, function(x) {
  found <- known_types[known_types %in% x]
  if (length(found) == 1) found else NA_character_
})
admin_unit <- unlist(admin_unit)
admin_unit
```

The result is `District`, `Urban district`, `NA`. The first two labels identify their type explicitly. `Cedar City` remains unresolved: a place name containing "City" is not evidence of its legal status. `State capital` is an additional descriptor; it does not replace `Urban district`.

For real regional data, use documented source classifications and dates. Do not assign every unresolved label to the same category. Retain the other descriptors and report cases that require checking.

## Package a repeated operation

A function names a reusable operation and makes its input explicit:

```r
split_label <- function(x) {
  strsplit(trimws(x), ",", fixed = TRUE)
}
split_label(labels)
```

This function takes a vector of labels and returns a list of parts. Save the definition in `Scripts/region_helpers.R`, then load it with `source("Scripts/region_helpers.R")` from your Rmd before calling it. The crop assignment asks you to develop your own region-cleaning function using the operations above.

See [character strings in Base R](https://geomoer.github.io/moer-base-r/unit08/unit08-06-string.html) and [writing functions](https://geomoer.github.io/moer-base-r/unit07/unit07-06_functions.html).
