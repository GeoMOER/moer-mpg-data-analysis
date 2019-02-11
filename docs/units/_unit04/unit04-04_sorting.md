---
title: "Example: Sorting"
toc: true
toc_label: In this example
---


#### Sorting vectors or lists
Vectors can be sorted using the `sort` function. If you want to sort a list,
you have to access the actual elements since sort requires atomic vectors.

```r
x <- c(7,5,8,2,10)
sort(x)
```

```
## [1]  2  5  7  8 10
```

```r
l <- list(x)
sort(l[[1]])
```

```
## [1]  2  5  7  8 10
```


#### Sorting data frames
The logic of sorting data frames is different from the `sort` function shown
above. Instead of directly getting a sorted output, one has to get the 
permutation of the ordering i.e. a vector which gives the position of the 
elements in ascending or descending order. This is realized by the `order` 
function, which can also be applied to vectors or lists.

```r
y <- c("Z", "D", "R", "A", "O")
z <- c(10, 40, 20, 30, 50)
df <- data.frame(X = x, Y = y, Z = z)
df
```

```
##    X Y  Z
## 1  7 Z 10
## 2  5 D 40
## 3  8 R 20
## 4  2 A 30
## 5 10 O 50
```

```r
df[order(df$X),]  # order by column X
```

```
##    X Y  Z
## 4  2 A 30
## 2  5 D 40
## 1  7 Z 10
## 3  8 R 20
## 5 10 O 50
```

```r
df[order(df$Y),]  # order by column Y
```

```
##    X Y  Z
## 4  2 A 30
## 2  5 D 40
## 5 10 O 50
## 3  8 R 20
## 1  7 Z 10
```

```r
df[order(df$Y, df$Z),]  # order by column Y and Z
```

```
##    X Y  Z
## 4  2 A 30
## 2  5 D 40
## 5 10 O 50
## 3  8 R 20
## 1  7 Z 10
```

```r
# sorting would only be applicable for one row/column (i.e. one vector)
sort(df[,2])
```

```
## [1] A D O R Z
## Levels: A D O R Z
```

```r
# for the vector and list example above, the followig would apply
x[order(x)]
```

```
## [1]  2  5  7  8 10
```

```r
l[[1]][order(l[[1]])]
```

```
## [1]  2  5  7  8 10
```
Please note that the above examples are not the only way and that you might
find other solutions for the same problem - this is something quite typical for
very high level programming languages. Just to illustrate it, here comes the
`with` function which evaluates an expression for the given data structure which
requires that e. g. for a data frame it is placed at the position of the 
respective dimension inside the square brackets.

```r
# sort a data frame by column X and Z
df[with(df, order(X, Z)), ]
```

```
##    X Y  Z
## 4  2 A 30
## 2  5 D 40
## 1  7 Z 10
## 3  8 R 20
## 5 10 O 50
```


#### Sorting factors
A quick note on sorting factors. Factors are categorial variables which can take
on a value which is part of a predefined (and limited) set. Factors consist
of two parts, the actual value at some position and the set of possible values
called levels. This implies that two aspects of a factor can be ordered separately:
the factor values which we see when printing the content of a data frame and
the levels which we do not see when we print it (but which might affect the
printig and plotting or some statistical operations).

Characters like the ones of vector y are genreally converted to factor variables
in data frames.

Lets have a look at the data frame df again:

```r
df
```

```
##    X Y  Z
## 1  7 Z 10
## 2  5 D 40
## 3  8 R 20
## 4  2 A 30
## 5 10 O 50
```

```r
str(df)
```

```
## 'data.frame':	5 obs. of  3 variables:
##  $ X: num  7 5 8 2 10
##  $ Y: Factor w/ 5 levels "A","D","O","R",..: 5 2 4 1 3
##  $ Z: num  10 40 20 30 50
```

```r
levels(df$Y) 
```

```
## [1] "A" "D" "O" "R" "Z"
```

```r
df$Y  # alternatively to levels(df$Y) to print both the values and the levels
```

```
## [1] Z D R A O
## Levels: A D O R Z
```
As you see, column Y is not sorted but looking at its structure we see that the
column is of type Factor and using the `levels` function, we note that the
factor levels are obviously ordered in an increasing order.

Let's sort column Y in a decreasing order and have a look at the factor levels
afterwards.

```r
df <- df[order(df$Y, decreasing = TRUE),]
levels(df$Y)
```

```
## [1] "A" "D" "O" "R" "Z"
```

```r
df$Y
```

```
## [1] Z R O D A
## Levels: A D O R Z
```
Obviously, the value ordering in column Y has changed but not the ordering of
its levels. To actually change the ordering of factor levels, we have to sort 
them explicitly.

```r
df$Y <- factor(df$Y, levels(df$Y)[order(levels(df$Y), decreasing = TRUE)])
levels(df$Y)
```

```
## [1] "Z" "R" "O" "D" "A"
```

```r
df$Y
```

```
## [1] Z R O D A
## Levels: Z R O D A
```


For more information have a look at e.g. the respective 
[sorting](http://www.statmethods.net/management/sorting.html) site at Quick R, 
have a look into the package documentation or search the web.
