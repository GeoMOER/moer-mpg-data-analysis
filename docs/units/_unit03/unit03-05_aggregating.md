---
title: "Example: Aggregation Statistics"
toc: true
toc_label: In this example
---



## Summarizing a data set

The most straight forward function which returns some aggregated statistical
information about a data set is `summary`.

```r
a <- c("A", "B", "C", "A", "B", "A", "A")
b <- c("X", "X", "X", "X", "Y", "Y", "Y")
c <- c(1, 2, 3, 4, 5, 6, 7)
d <- c(10, 20, 30, 40, 50, 60, 70)
df <- data.frame(Cat1 = a, Cat2 = b, Val1 = c, Val2 = d)
summary(df)
```

```
##  Cat1  Cat2       Val1          Val2   
##  A:4   X:4   Min.   :1.0   Min.   :10  
##  B:2   Y:3   1st Qu.:2.5   1st Qu.:25  
##  C:1         Median :4.0   Median :40  
##              Mean   :4.0   Mean   :40  
##              3rd Qu.:5.5   3rd Qu.:55  
##              Max.   :7.0   Max.   :70
```
It provides the minimum, maximum, mean and median value of each numerical column
along with the first and third quartile (i.e. the values separating 25% from 75%
and 75% from 100% of the data). Non-numeric columns are summarized by counting
the individual values (which will be ommitted after the first few rows so it
is only informative for columns with just a few different character values).

The information of `summary` can also be obtained by specific functions but these
will return only the same numbers if applied to a single column. For example the
`min` function will return the minimum value of all values supplied to it. This
leads to a return of 1 no matter if it is applied to column Val1 or to columns
Val1 and Val2:

```r
min(df[,3])
```

```
## [1] 1
```

```r
min(df[,3:4])
```

```
## [1] 1
```
The other functions included in summary are

```r
max(df$Val1)
```

```
## [1] 7
```

```r
quantile(df$Val1,  probs = c(0.25, 0.75))
```

```
## 25% 75% 
## 2.5 5.5
```

```r
mean(df$Val1)
```

```
## [1] 4
```

```r
median(df$Val1)
```

```
## [1] 4
```


## Aggregated statistics
If you are interested in aggregated statistics in terms of sums or means across
columns or rows, you can use one of the `rowSums`, `rowMeans`, `colSums`, or 
`colMeans` functions.

```r
df  # Just print the data frame so you can easily understand the results
```

```
##   Cat1 Cat2 Val1 Val2
## 1    A    X    1   10
## 2    B    X    2   20
## 3    C    X    3   30
## 4    A    X    4   40
## 5    B    Y    5   50
## 6    A    Y    6   60
## 7    A    Y    7   70
```

```r
rowSums(df[,3:4])
```

```
## [1] 11 22 33 44 55 66 77
```

```r
rowMeans(df[,3:4])
```

```
## [1]  5.5 11.0 16.5 22.0 27.5 33.0 38.5
```

```r
colSums(df[,3:4])
```

```
## Val1 Val2 
##   28  280
```

```r
colMeans(df[,3:4])
```

```
## Val1 Val2 
##    4   40
```

For other summary statistics across rows or if you want to define a grouping
variable which controls the summary statistics, the `aggregate` function is very
helpfull.

```r
aggregate(df[,3:4], by = list(df$Cat1), FUN = median)
```

```
##   Group.1 Val1 Val2
## 1       A  5.0   50
## 2       B  3.5   35
## 3       C  3.0   30
```
Please note that the grouping elements (parameter "by") have to supplied as list
so if you want to use a column of a data frame, use the `list` function to convert
the factor to a list.

Of course, one can also use more than one grouping variable.

```r
aggregate(df[,3:4], by = list(df$Cat1, df$Cat2), FUN = sum)
```

```
##   Group.1 Group.2 Val1 Val2
## 1       A       X    5   50
## 2       B       X    2   20
## 3       C       X    3   30
## 4       A       Y   13  130
## 5       B       Y    5   50
```

In some cases it is usefull to construct a specific aggregation key, so think of
that easy possibility if you run into problems. As one example: imagine that the
aggregate function can not use more than one grouping variable. To get the same
result as in the line above, one can define a key consisting of the entries of
column Cat1 and Cat2 (sorting is different but who cares):

```r
df$key <- paste0(df$Cat1, df$Cat2)
aggregate(df[,3:4], by = list(df$key), FUN = sum)
```

```
##   Group.1 Val1 Val2
## 1      AX    5   50
## 2      AY   13  130
## 3      BX    2   20
## 4      BY    5   50
## 5      CX    3   30
```
