---
title: "R Syntax and Help"
toc: true
toc_label: On this page
permalink: /unit03/unit03-02a_r_syntax_and_help.html
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Use <a href="{{ site.baseurl }}/assets/data/example.txt" download="example.txt">example.txt</a>, saved in your project's `Data/` folder on the [previous page]({{ site.baseurl }}/unit03/unit03-02a_organize_your_data_files.html). Keep your project folder as the working directory. Here you will use R's documentation to choose the import settings for that file and inspect the result.

## Open the help page

Enter either of these commands in the R console:

```r
?read.table
help("read.table")
```

In RStudio, these commands open documentation in the **Help** pane. The heading identifies `read.table` and its package, **utils**; **Data Input** is the title. Several functions share the page, so find `read.table` in **Usage**.

<span id="find-your-way-around-the-help-page"></span>
<span id="defaults-are-starting-settings"></span>

Use the Base R guides for the general foundations:

- [R Syntax: read a function call from left to right](https://geomoer.github.io/moer-base-r/unit01/unit01-04a_r_syntax.html#read-a-function-call-from-left-to-right) explains parentheses, argument names and values, quotation marks, commas, and assignment with `<-`.
- [R Help-Files: a quick route through the help](https://geomoer.github.io/moer-base-r/unit01/unit01-06_helpfiles.html#find-your-way-around-the-help-page) connects **Usage**, **Arguments** and **Value**; its [default-value guide](https://geomoer.github.io/moer-base-r/unit01/unit01-06_helpfiles.html#defaults-are-starting-settings) explains omitted arguments and `...`.

If these ideas are new, work through those guides first. The syntax lesson supplies its own comma-separated practice file. Return here to apply the same approach to your **semicolon-separated** `Data/example.txt`; keep this course's project and file layout.

## Read a function call from left to right

Use the file's contents to choose the inputs:

```r
read.table(file = "Data/example.txt", header = TRUE, sep = ";", dec = ",")
```

The result is a data frame with three rows and two columns: `tree` and `height_m`.

| Setting | Why it fits this file |
|---|---|
| `file = "Data/example.txt"` | Gives the path to the local file prepared on the preceding page. |
| `header = TRUE` | Uses the first line as column names. |
| `sep = ";"` | Reads semicolons as field separators. |
| `dec = ","` | Converts heights such as `18,5` into numeric values in R. |

The comma **after** `sep = ";"` separates arguments in R code; the comma **inside** `dec = ","` describes decimal notation in the file. Keep these two roles apart when adapting an import.

<span id="named-and-positional-arguments"></span>
For [named and positional arguments](https://geomoer.github.io/moer-base-r/unit01/unit01-04a_r_syntax.html#named-and-positional-arguments), compare the syntax guide with this call: `file` is named here, and its value is the path to your own course file.

## Store and inspect the result

Store the imported table so you can use it in further calls:

```r
trees <- read.table(
  file = "Data/example.txt",
  header = TRUE,
  sep = ";",
  dec = ","
)
dim(trees)
str(trees)
```

`dim(trees)` returns **3 rows and 2 columns**. `str(trees)` shows that `tree` contains text and `height_m` contains numbers. Check that the heights are **18.5, 21.0 and 16.2 meters**: the file uses decimal commas, while R prints decimal points. `trees <-` stores the returned data frame under the name `trees`.

The [next example]({{ site.baseurl }}/unit03/unit03-04_csv_io.html) applies this workflow to a real land-use dataset. It introduces the additional import choices that dataset needs and follows its preparation through to an RDS file.

## Exercise: Read the help for read.table() {#try-reading-the-help-yourself}

Use `?read.table` to answer these questions before running another import:

1. Which argument skips introductory lines, and what is its default?
2. Which argument limits the number of data rows read?
3. Why does the course example explicitly set `header = TRUE` and `sep = ";"`?
4. What kind of object does `read.table()` return, and where is it stored in the example?

Use the [official online help for read.table()](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html) if installed help is unavailable. The [official help() documentation](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/help.html) describes the help system itself.
