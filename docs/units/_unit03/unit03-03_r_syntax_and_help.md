---
title: "R Syntax and Help"
toc: true
toc_label: In this example
permalink: /unit03/unit03-02a_r_syntax_and_help.html
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

You have downloaded `example.txt` and saved it in your project's `Data/` folder on the [previous page]({{ site.baseurl }}/unit03/unit03-02a_organize_your_data_files.html). Here we read a function call from left to right and use its help page to understand the inputs. Keep your project folder as the working directory.

## Open the help page

Enter either of these commands in the R console:

```r
?read.table
help("read.table")
```

In RStudio, these commands open documentation in the **Help** pane. You can also read the [official online help for read.table()](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/read.table.html). Prefer the installed help for details specific to your R version.

The heading identifies `read.table` and its package, **utils**; **Data Input** is the title. Several functions share this page, including `read.csv()` and `read.csv2()`. Locate your function in **Usage**.

## Read a function call from left to right

Read the small file you downloaded:

```r
read.table(file = "Data/example.txt", header = TRUE, sep = ";", dec = ",")
```

The result is a data frame with three rows and two columns: `tree` and `height_m`.

| Read next | What it does |
|---|---|
| `read.table` | Names the function to call. The dot is part of its name. |
| `(` | Opens the round brackets, or parentheses, around the inputs. |
| `file` | Names the first argument supplied in this call. |
| `=` | Connects the argument name to the value you supply. |
| `"Data/example.txt"` | Supplies the file path as a character string, enclosed in quotes. |
| `,` | Separates this argument from the next one. |
| `header = TRUE` | Repeats the pattern: an argument name, an equals sign, and a logical value. |
| `,` | Separates the next argument. |
| `sep = ";"` | Supplies the separator argument. Its value is a string containing one semicolon. |
| `,` | Separates the final argument. |
| `dec = ","` | Supplies a string containing the decimal character used in the file. |
| `)` | Closes the call after the final argument. There is no trailing comma. |

The repeating pattern is **argument name = value**, with commas between arguments. Input names such as `header` are also called *formal arguments* or *parameters*; `TRUE` is the value supplied here.

Quotes and capitalization matter. `TRUE` is logical; `"TRUE"` is text. `0` is numeric; `"0"` is text. Write argument names such as `header` without quotes. R distinguishes uppercase and lowercase letters.

### Named and positional arguments

For `read.table()`, you can leave the first argument unnamed because `file` is first in the documented argument order. These two calls read the same local file with the same settings:

```r
read.table(file = "Data/example.txt", header = TRUE, sep = ";", dec = ",")
read.table("Data/example.txt", header = TRUE, sep = ";", dec = ",")
```

Unnamed arguments are matched by position; named arguments identify their inputs explicitly. The named arguments above can appear in a different order. Use full names to make your calls easy to compare with the help page.

## Find your way around the help page

The main sections answer different questions. Their presence and order can vary between functions.

| Section | Question to ask | What to look for in `?read.table` |
|---|---|---|
| **Description** | What does the function do? | It imports tabular information into a data frame. |
| **Usage** | How can I call it? | Argument names, their order, and defaults; find the `read.table` entry among the related functions. |
| **Arguments** | What does each input mean, and which values are accepted? | `file` identifies the input, `header` controls column names, `sep` separates fields, and `dec` specifies the decimal character. |
| **Details** | Which rules or special cases affect the result? | How the file is interpreted and how imported columns are converted. |
| **Value** | What will the function return? | A data frame that you can assign to an object. |
| **Note**, **Warning**, or a topic such as **Memory usage** | What limitations should I consider? | Additional cautions, for example when importing a large file. |
| **References** | Where does the documented method come from? | Background literature where provided. |
| **See Also** | Which related functions might help? | Links to other functions and documentation. |
| **Examples** | What does a concrete use look like? | Code you can inspect and adapt after checking its inputs and any accompanying comments. |

Start with **Description**, connect **Usage** to **Arguments**, and check **Value**. Consult **Details** for unresolved questions.

### Defaults are starting settings

In **Usage**, an entry such as `skip = 0` gives an argument and its default value. If you omit `skip`, the function normally starts without skipping lines. `dec = "."` uses decimal points, and `sep = ""` means separation by whitespace, such as spaces or tabs.

Check the argument description as well: although **Usage** shows `header = FALSE`, `read.table()` can infer a header for some file layouts. Set `header` explicitly when you know whether your file has column names.

Supply the settings your file needs; you do not have to specify every argument in **Usage**. A filename is a value you choose for your own input.

In the `read.csv()` and `read.csv2()` entries, `...` indicates that additional arguments can be passed to `read.table()`. Replace it with the actual named arguments you need.

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

`dim(trees)` returns **3 rows and 2 columns**. `str(trees)` shows that `tree` contains text and `height_m` contains numbers. Line breaks and indentation make a longer call readable; the parentheses and commas still define the call.

`trees <-` stores the returned data frame in `trees`. The assignment arrow is outside the call; the equals signs inside connect argument names to values. `dim(trees)` passes that object as an unnamed argument to another function, which returns its dimensions.

| Setting | Why it fits this file |
|---|---|
| `file = "Data/example.txt"` | Gives the path to the local file prepared on the preceding page. |
| `header = TRUE` | Uses the first line as column names. |
| `sep = ";"` | Reads semicolons as field separators. |
| `dec = ","` | Converts heights such as `18,5` into numeric values in R. |

Notice the two roles of commas: the comma **after** `sep = ";"` separates arguments in R code; the comma **inside** `dec = ","` describes decimal notation in the data file. There is no argument separator after the final argument.

The [next example]({{ site.baseurl }}/unit03/unit03-04_csv_io.html) applies this workflow to a real land-use dataset. It introduces the additional import choices that dataset needs and follows its preparation through to an RDS file.

## Try reading the help yourself

Use `?read.table` to answer these questions before running another import:

1. Which argument skips introductory lines, and what is its default?
2. Which argument limits the number of data rows read?
3. Why does the course example explicitly set `header = TRUE` and `sep = ";"`?
4. What kind of object does `read.table()` return, and where is it stored in the example?

For another guided view of the same help page, see [R Help-Files?! in the Base R course](https://geomoer.github.io/moer-base-r/unit01/unit01-06_helpfiles.html). The [official help() documentation](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/help.html) describes the help system itself.
