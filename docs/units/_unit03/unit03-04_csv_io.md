---
title: "Example: CSV I/O"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

## Reading data from text files

A successful import produces the right rows, columns, types, and units. After the small `example.txt` exercise, we will now follow an official dataset from its source table to an R object used in the [exploration example]({{ site.baseurl }}/unit03/unit03-06_exploration.html).

### Source and downloads

Our source is Destatis's *Survey of land area by actual use, 2024*, published on November 21, 2025. Worksheet `csv-33111-03` contains **17 records**: Germany and its 16 federal states, all at December 31, 2024. It has 64 columns, including identifiers, descriptions, total area in hectares, and land-use percentages. These are state-level observations for one date, not districts or a time series.

Use the `Data/` folder you created on the file-organization page. <a href="{{ site.baseurl }}/assets/data/destatis-land-use-2024.csv" download="destatis-land-use-2024.csv">Download the teaching CSV</a> and save it there, keeping its filename. Also available are the [original Destatis workbook]({{ site.baseurl }}/assets/data/destatis-land-use-2024.xlsx), [column dictionary and source crosswalk]({{ site.baseurl }}/assets/data/destatis-land-use-2024-dictionary.csv), and [source and preparation notes]({{ site.baseurl }}/assets/data/destatis-land-use-2024-source.txt). The CSV retains all 17 source records and 64 columns. Its headers, survey description and region names are English teaching translations; numerical values, identifiers and empty cells are preserved. The dictionary maps every English column name to its original German source header and explains its meaning and units. The original workbook remains in German.

The official [publication page](https://www.destatis.de/DE/Themen/Branchen-Unternehmen/Landwirtschaft-Forstwirtschaft-Fischerei/Flaechennutzung/_inhalt.html) and [methods report](https://www.destatis.de/DE/Methoden/Qualitaet/Qualitaetsberichte/Land-Forstwirtschaft-Fischerei/flaechenerhebung.pdf?__blob=publicationFile) provide the publisher's definitions.

### Import and inspect

This CSV starts with its header: inspect the file before choosing `skip`. It uses semicolons, decimal commas, and UTF-8 text. Read the columns as text initially so that identifiers such as `"01"` keep their leading zero:


```r
raw <- read.csv2("Data/destatis-land-use-2024.csv",
                 colClasses = "character", na.strings = "",
                 fileEncoding = "UTF-8", check.names = FALSE)
dim(raw)
```

```
## [1] 17 64
```

```r
raw[1:3, c("Reference_year", "State_ID", "State_name")]
```

```
##   Reference_year State_ID         State_name
## 1           2024        0            Germany
## 2           2024       01 Schleswig-Holstein
## 3           2024       02            Hamburg
```

`read.csv2()` is a convenience form of `read.table()` with `header = TRUE`, `sep = ";"`, and `dec = ","`. `colClasses = "character"` postpones numeric conversion; `na.strings = ""` imports empty cells as missing values, and `check.names = FALSE` retains the teaching CSV's exact column names. These settings describe this file; the timber CSV in Assignment 03 has a different header arrangement and decimal separator.

Use the dictionary to distinguish measurements from metadata. `Reference_year` is the reporting year, `State_ID` the state identifier, and `State_name` the reporting area's name. A code identifies an area; it is not a measured amount.

### Select columns and explain their meaning

Keep `raw` unchanged. Select a small set of columns and assign shorter names for analysis. The names on the left below are our analysis names; the strings on the right are exact headers in the English teaching CSV:


```r
columns <- c(
  Year = "Reference_year",
  ID = "State_ID",
  Place = "State_name",
  Area_ha = "Total_area_ha",
  Settlement = "Settlement_pct_10000000",
  Transport = "Transport_pct_20000000",
  Vegetation = "Vegetation_pct_30000000",
  Agriculture = "Agriculture_pct_31000000",
  Forest = "Forest_pct_32000000",
  Water = "Water_pct_40000000"
)
land_use <- raw[unname(columns)]
names(land_use) <- names(columns)
```

`unname(columns)` supplies the original headers for column selection; `names(columns)` supplies the shorter analysis names. Selecting a data frame with one index, as in `raw[unname(columns)]`, selects columns and keeps all rows.

`Area_ha` is total area in hectares (1 ha = 10,000 m²). The other six measurement columns are **percentages of each area's total area**, not hectares. For example, `9.4` means 9.4%, rather than a fraction of 0.094. The eight-digit suffixes identify land-use categories.

`Settlement` includes recreational uses and excludes the separately reported `Transport` category. It is not a measure of sealed soil. `Agriculture` and `Forest` are components of the broader `Vegetation` category. Thus these columns describe different levels of a classification.

Convert only the numeric fields, keeping `ID` and `Place` as text. `setdiff()` selects all column names except those two; `type.convert()` interprets the selected text columns using decimal commas:


```r
numeric_columns <- setdiff(names(land_use), c("ID", "Place"))
land_use[numeric_columns] <- type.convert(
  land_use[numeric_columns], dec = ",", as.is = TRUE
)
str(land_use)
```

```
## 'data.frame':	17 obs. of  10 variables:
##  $ Year       : int  2024 2024 2024 2024 2024 2024 2024 2024 2024 2024 ...
##  $ ID         : chr  "0" "01" "02" "03" ...
##  $ Place      : chr  "Germany" "Schleswig-Holstein" "Hamburg" "Lower Saxony" ...
##  $ Area_ha    : int  35768346 1580430 75509 4770988 41994 3411244 2111564 1985796 3574785 7054178 ...
##  $ Settlement : num  9.5 9.4 46.3 9.5 44 16.9 9.5 8.9 9.6 7.9 ...
##  $ Transport  : num  5.1 4.4 12.4 5.2 12.3 7.1 6.7 6.5 5.6 4.7 ...
##  $ Vegetation : num  83.1 81.3 33.1 83.2 32.2 74.2 82.4 83.2 83.7 85.7 ...
##  $ Agriculture: num  50.2 68.1 22.7 57.7 26.8 46.6 41.1 40.3 44.6 46 ...
##  $ Forest     : num  29.9 10.3 5.6 21.7 1.4 24.8 40.1 40.5 37.9 35.4 ...
##  $ Water      : num  2.3 4.9 8.2 2.1 11.6 1.8 1.4 1.4 1.1 1.7 ...
```

Inspect the result: an unexpected text value can prevent a column from becoming numeric. Missing data are not zeros. A displayed zero may also represent a small amount rounded to the source's precision.

### Check which observations belong together

Germany (code `"0"`) is the national aggregate, not a seventeenth federal state. Select just the states before comparing their distributions:


```r
states <- land_use[land_use$ID != "0", ]
rownames(states) <- NULL
nrow(states)
```

```
## [1] 16
```

```r
anyDuplicated(states$ID)
```

```
## [1] 0
```

```r
summary(states[c("Settlement", "Transport", "Agriculture", "Forest")])
```

```
##    Settlement      Transport       Agriculture        Forest
##  Min.   : 5.60   Min.   : 3.100   Min.   : 4.00   Min.   : 1.40
##  1st Qu.: 7.85   1st Qu.: 4.400   1st Qu.:40.12   1st Qu.:20.40
##  Median : 9.50   Median : 5.400   Median :46.30   Median :25.80
##  Mean   :17.01   Mean   : 6.569   Mean   :44.49   Mean   :25.61
##  3rd Qu.:15.93   3rd Qu.: 6.800   3rd Qu.:54.62   3rd Qu.:35.33
##  Max.   :55.90   Max.   :14.700   Max.   :68.10   Max.   :40.50
```

There should be 16 rows and no duplicated state identifiers. These checks support a meaningful import; they do not replace reading the source definitions. An unweighted mean of the state percentages gives each state equal weight. It is not Germany's area-weighted percentage; the published national record answers that question.

Settlement, transport, vegetation, and water are the four main categories. Their rounded shares add to approximately 100%:


```r
main_categories <- c("Settlement", "Transport", "Vegetation", "Water")
range(rowSums(states[main_categories]))
```

```
## [1]  99.9 100.1
```

The small deviations from 100% reflect rounding. Adding `Agriculture` and `Forest` again would double-count parts of `Vegetation`. The four columns used in the overview boxplots are a selected set of non-overlapping categories, not an exhaustive partition of all land.

## Writing data to CSV files {#writing-data-to-csv-files}

Save prepared output separately from the source. `row.names = FALSE` avoids adding an extra index column:


```r
dir.create("Output", showWarnings = FALSE)
write.csv(states, "Output/land-use-2024-states.csv",
          row.names = FALSE, fileEncoding = "UTF-8")
```

This output uses commas between fields and decimal points. CSV stores text, so re-importing it requires attention to identifiers and types again.

## Alternative data I/O using RDS

The prepared file used in the next example is generated from **this same CSV** by the selection, renaming, conversion, and state filtering shown above:


```r
saveRDS(states, "Data/destatis-land-use-2024-states.rds", version = 2)
restored <- readRDS("Data/destatis-land-use-2024-states.rds")
identical(states, restored)
```

```
## [1] TRUE
```

RDS preserves the R object's column types. It does not by itself explain the source, units, or preparation choices; retain the dictionary and source notes with the data. You have now created the RDS needed for exploration; no further download is required to continue. The supplied [prepared RDS]({{ site.baseurl }}/assets/data/destatis-land-use-2024-states.rds) is an alternative if you need to start at the exploration page.

For an optional way to repeat the preparation, download the [preparation script]({{ site.baseurl }}/assets/data/prepare-land-use-2024.R) into `Data/`, then run:


```r
source("Data/prepare-land-use-2024.R")
prepare_land_use("Data")
```

This example gives an initial, documented preparation workflow. Unit 04 develops missing-value handling, more extensive cleaning, and reshaping. This small state table is for Unit 03; later regression exercises use a separate regional dataset with different categories and many more observations.

The import and preparation are complete. Next, [Visualization]({{ site.baseurl }}/unit03/unit03-03_visualization.html) introduces plot selection with small examples before we explore these prepared state data.
