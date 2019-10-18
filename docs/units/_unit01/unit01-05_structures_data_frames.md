---
title: "Example: Data Frame Basics"
toc: true
toc_label: In this example
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
The `colnames` function allows to supply column names to an existing data
frame. Alternatively, the column names can be set within the `data.frame` 
function by assign the vector elements to a variable (capital X and Y in the example above).


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
##  $ Y: Factor w/ 3 levels "A","B","C": 1 2 3
```


## Displaying and accessing the content of a data frame

The content of a data frame is accessed by either a position information 
given in square brackets (e.g. `df[3,4]`) or a column name given after a $ sign
(e.g. `df$columnName`). Here is an example:




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
## [1] A B C
## Levels: A B C
```

```r
my_other_df$Y  # Shows second column
```

```
## [1] A B C
## Levels: A B C
```

If position information is used, the ordering matters. If you think of a data
frame like a table, then the following applies:

 * In a 1-D data frame, the first dimension is the row
 * In a 2-D data frame, the first dimension is the row, the second the column

Higher dimensions follow the same logic.

Here are some possible combinations:

 * Single row, all columns: `df[x,]`                <!--with $x \in \text{number of rows}$ IMPLEMENT LATEX MATH TO JEKYLL -->
 * Single column, all rows: `df[,y]`                <!--with $x \in \text{number of columns}$ -->
 * Single row and column: `df[x,y]`                 <!--with $x, y \in \text{number of rows, columns}$ -->
 * All except one row, all columns: `df[-x,y]`      <!--with $x \in \text{number of rows}$ -->
 * Selected rows, all columns: `df[c(x1, x2, x3),]` <!--with $x1, x2, x3 \in \text{number of rows}$ -->
 * Continous rows, all columns: `df[c(x1:x2),]`     <!--with $x1, x2 \in \text{number of rows}$ -->

In summary, dimensions like rows or columns which should be selected have positive 
numbers, dimensions that should be hidden have negative numbers, and if all entries of
a dimension should be selected one just leaves the field empty. If more than
one dimension should be shown or hidden, one has to supply these information with a 
vector defined by the `c` function.


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

If you are interested in the first or last rows, you can also use the `head` or
`tail` functions. The default number of lines to be displayed is five but this can be changed with the
second argument. Let us have a look at the first two rows:

```r
head(my_other_df, 2)
```

```
##   X Y
## 1 2 A
## 2 3 B
```

And now on the last two rows:

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
# change an entire dimension
my_other_df[,1] <- c("200", "300", "401")  # same as my_other_df$X <- 400
my_other_df
```

```
##     X Y
## 1 200 A
## 2 300 B
## 3 401 C
```

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

For more information have a look at e.g. the respective [data type](http://www.statmethods.net/input/datatypes.html){:target="_blank"} site at Quick R. There you will also find an overview on how to get [information about an object](http://www.statmethods.net/input/contents.html){:target="_blank"}. Of course, looking into the package documentation or search the web is always a good idea, too.
