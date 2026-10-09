---
title: "Example: Data Frame Basics"
toc: true
toc_label: In this example
header:
  image: "/assets/images/title/title_1600_500.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---


Data frames are one of the most heavily used data structures in R.

## Creation of a data frame
A data frame is created from scratch by supplying vectors to the `data.frame`
function. Here are some examples:

```r
x <- c(2.5, 3.5, 3.4)
y <- c(5, 10, 1)
my_df <- data.frame(x, y)
my_df
```

```
##     x  y
## 1 2.5  5
## 2 3.5 10
## 3 3.4  1
```

```r
colnames(my_df) <- c("Floats", "Integers")

my_other_df <- data.frame(X = c(2, 3, 4), Y = c("A", "B", "C"))
my_other_df
```

```
##   X Y
## 1 2 A
## 2 3 B
## 3 4 C
```
The `colnames` function allows you to supply column names to an existing data frame. You can also set column names directly in `data.frame()`, as shown by the named arguments `X` and `Y` above.


## Dimensions of a data frame
To get the dimensions of a data frame, use the `ncol` (number of columns), 
`nrow` (number of rows) or `str` (structure) function:

```r
ncol(my_other_df)
```

```
## [1] 2
```

```r
nrow(my_other_df)
```

```
## [1] 3
```

```r
str(my_other_df)
```

```
## 'data.frame':	3 obs. of  2 variables:
##  $ X: num  2 3 4
##  $ Y: chr  "A" "B" "C"
```


## Displaying and accessing the content of a data frame

Access values in a data frame using indices in square brackets (e.g., `df[3,4]`) or a column name after a `$` sign (e.g., `df$columnName`). Here is an example:


```r
my_other_df[1,]  # Shows first row
```

```
##   X Y
## 1 2 A
```

```r
my_other_df[,2]  # Shows second column
```

```
## [1] "A" "B" "C"
```

```r
my_other_df$Y  # Shows second column
```

```
## [1] "A" "B" "C"
```

A data frame has rows and columns. With two indices, use `df[rows, columns]`: the first index selects rows, and the second selects columns. Leaving an index empty selects all entries in that dimension. With a single index, `df[index]` selects columns.

In the examples below, `df` represents a data frame, `x` represents a row number, and `y` represents a column number.

Here are some possible combinations:

 * Single row, all columns: `df[x,]`
 * Single column, all rows: `df[,y]`
 * Single row and column: `df[x,y]`
 * All except one row, all columns: `df[-x,]`
 * Selected rows, all columns: `df[c(x1, x2, x3),]`
 * Consecutive rows, all columns: `df[c(x1:x2),]`

Use positive indices to select rows or columns and negative indices to exclude them. To select or exclude several rows or columns, supply a vector of indices using `c()`.

```r
my_other_df[c(1,3),]  # Shows rows 1 and 3
```

```
##   X Y
## 1 2 A
## 3 4 C
```

```r
my_other_df[c(1,2),]  # Shows rows 1 to 2
```

```
##   X Y
## 1 2 A
## 2 3 B
```

To display the first or last rows, use `head` or `tail`. By default, these functions display six rows. You can change this number with the second argument. Let us look at the first two rows:

```r
head(my_other_df, 2)
```

```
##   X Y
## 1 2 A
## 2 3 B
```

And now let's look at the last two rows:

```r
tail(my_other_df, 2)
```

```
##   X Y
## 2 3 B
## 3 4 C
```

## Changing, adding or deleting an element of a data frame
In order to change an element of a data frame (individual value or entire
vectors like rows or columns), you have to access it following the logic above.
To add or delete a column, you have to supply/remove a vector to the specified
position.

Other more specific changes will be covered later. 

```r
# overwrite an element
my_other_df$X[3] <- 400  # same as my_other_df[3,1] <- 400
my_other_df
```

```
##     X Y
## 1   2 A
## 2   3 B
## 3 400 C
```

```r
# change an entire column
my_other_df[,1] <- c("200", "300", "401")  # same as my_other_df$X <- c("200", "300", "401")
my_other_df
```

```
##     X Y
## 1 200 A
## 2 300 B
## 3 401 C
```

The values are in quotation marks, so `X` becomes a character column.

```r
# add a new column
my_other_df$z <- c(255, 300, 100)
my_other_df
```

```
##     X Y   z
## 1 200 A 255
## 2 300 B 300
## 3 401 C 100
```

```r
# delete a column
my_other_df$z <- NULL
my_other_df
```

```
##     X Y
## 1 200 A
## 2 300 B
## 3 401 C
```
As for lists, to actually delete an element, it has to be set to `NULL`.

For more information, see the accompanying Base R course on [data types](https://geomoer.github.io/moer-base-r/unit02/unit02-01_Intro.html){:target="_blank"} and [object types](https://geomoer.github.io/moer-base-r/unit03/unit03-01_Intro.html){:target="_blank"}. Package documentation is another useful resource.
