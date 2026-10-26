---
title: Tabulated Data I/O
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Data input/output (I/O) moves information between files on disk and objects in R. For tabular data, each row represents an observation and each column represents a variable. Importing a file creates a data frame that you can inspect and analyze; exporting writes information back to disk.

## Tabular text files

A tabular text file stores column values separated by a character such as a comma, semicolon or tab. CSV is a common format for exchanging tables with other software. Inspect the file before importing it: identify its column separator, decimal character, header, introductory lines and text encoding.

| Task | General R function |
|---|---|
| Read a table from a text file | `read.table()` |
| Write a table to a text file | `write.table()` |

The following is a syntax sketch. Replace the example path and settings with those appropriate for your file:

```text
df <- read.table(file = "path/to/file.txt", header = TRUE, sep = ";", dec = ",")
write.table(df, file = "path/to/output.txt", sep = ";", dec = ",", row.names = FALSE)
```

`read.csv()` and `read.csv2()` are convenient variants of `read.table()` with defaults for common CSV arrangements. An import still needs checking: rows, column names, missing values, identifiers, numeric types and units should agree with the source.

## Saved R objects

An RDS file stores a single R object, including its types. For example, it can preserve a prepared data frame for later work in R. A CSV file stores text that another import must interpret again.

| Task | R function |
|---|---|
| Save an R object | `saveRDS()` |
| Restore that object | `readRDS()` |

```text
saveRDS(df, file = "path/to/prepared.rds")
df <- readRDS("path/to/prepared.rds")
```

Use text formats for exchanging tables, and RDS for preserving an R object for later use in R. Keep the source and preparation notes with either format so that the data remain understandable.

We will first [download and organize a small example file]({{ site.baseurl }}/unit03/unit03-02a_organize_your_data_files.html), then explain its import on the [R Syntax and Help page]({{ site.baseurl }}/unit03/unit03-02a_r_syntax_and_help.html). The [CSV I/O example]({{ site.baseurl }}/unit03/unit03-04_csv_io.html) subsequently applies the workflow to the official land-use data.

