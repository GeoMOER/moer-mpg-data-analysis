---
title: "Example: Lapply-loops"
toc: true
toc_label: In this example
---


As examples for the apply family we shortly introduce `lapply`.

## Basic structure
The `lapply` function can be your workhorse when it comes to loops over data 
frames but it can also drive you mad if you do not understand its way of handling
stuff. 

Remember: the function will always return a structured list with one return 
statement per sub-entry and the function can never change a data frame or any
other variable content defined outside the loop (no matter if it has the same
name or not).

Let's have a look at an example for which we will use the following data frame:

```r
a <- c("A", "B", "C", "A", "B", "A", "A")
b <- c("X", "X", "X", "X", "Y", "Y", "Y")
c <- c(1, 2, 3, 4, 5, 6, 7)
d <- c(10, 20, 30, 40, 50, 60, 70)
df <- data.frame(Cat1 = a, Cat2 = b, Val1 = c, Val2 = d)
```
We now want to build a new data frame with the same columns but the characters
of columns Cat1 and Cat2 should be converted to lower case and the values of
Val1 and Val2 should become their square root. This is the same task as used
in the for loop code examples.

In order to solve this problem with an `lapply` call, we have to define an 
appropriate functionwithin the () brackets of the `lapply` call structure. Since
we want to iterrate over all (four) columns of the data frame, we define the 
iteration sequence using the `ncol` function which in that specific case is the
same as `seq(4)` since we have four columns:

```r
result <- lapply(seq(ncol(df)), function(x){
  act_column <- df[,x]
  if(is.factor(act_column)){
    return(tolower(act_column))
  } else if(is.numeric(act_column)){
    return(sqrt(act_column))
  }
})
```
As you can see, the function we want to apply is passed within the outer () 
brackets and starts with the { bracket  in the first line. The actual body of 
the function (i.e. what controls what is done within it) starts in the second 
line and ends in line six. The function is closed in line seven with the 
closing } bracket and the `lapply` function call is closed direclty afterwards
with the closing ) bracket.

Let's have a look on what is returned, i.e. what is stored in the variable called
result:

```r
result
```

```
## [[1]]
## [1] "a" "b" "c" "a" "b" "a" "a"
## 
## [[2]]
## [1] "x" "x" "x" "x" "y" "y" "y"
## 
## [[3]]
## [1] 1.000000 1.414214 1.732051 2.000000 2.236068 2.449490 2.645751
## 
## [[4]]
## [1] 3.162278 4.472136 5.477226 6.324555 7.071068 7.745967 8.366600
```

```r
str(result)
```

```
## List of 4
##  $ : chr [1:7] "a" "b" "c" "a" ...
##  $ : chr [1:7] "x" "x" "x" "x" ...
##  $ : num [1:7] 1 1.41 1.73 2 2.24 ...
##  $ : num [1:7] 3.16 4.47 5.48 6.32 7.07 ...
```
Obviously it is a list with four sub-elements and each element contains a vector
which holds the modified content of one of the data frame rows. Since we 
originally wanted a data frame, we have to convert this list to a data frame
using:

```r
result_df <- data.frame(result)
result_df
```

```
##   c..a....b....c....a....b....a....a..
## 1                                    a
## 2                                    b
## 3                                    c
## 4                                    a
## 5                                    b
## 6                                    a
## 7                                    a
##   c..x....x....x....x....y....y....y..
## 1                                    x
## 2                                    x
## 3                                    x
## 4                                    x
## 5                                    y
## 6                                    y
## 7                                    y
##   c.1..1.4142135623731..1.73205080756888..2..2.23606797749979..
## 1                                                      1.000000
## 2                                                      1.414214
## 3                                                      1.732051
## 4                                                      2.000000
## 5                                                      2.236068
## 6                                                      2.449490
## 7                                                      2.645751
##   c.3.16227766016838..4.47213595499958..5.47722557505166..6.32455532033676..
## 1                                                                   3.162278
## 2                                                                   4.472136
## 3                                                                   5.477226
## 4                                                                   6.324555
## 5                                                                   7.071068
## 6                                                                   7.745967
## 7                                                                   8.366600
```

```r
str(result_df)
```

```
## 'data.frame':	7 obs. of  4 variables:
##  $ c..a....b....c....a....b....a....a..                                      : Factor w/ 3 levels "a","b","c": 1 2 3 1 2 1 1
##  $ c..x....x....x....x....y....y....y..                                      : Factor w/ 2 levels "x","y": 1 1 1 1 2 2 2
##  $ c.1..1.4142135623731..1.73205080756888..2..2.23606797749979..             : num  1 1.41 1.73 2 2.24 ...
##  $ c.3.16227766016838..4.47213595499958..5.47722557505166..6.32455532033676..: num  3.16 4.47 5.48 6.32 7.07 ...
```
Also it looks weird, it is a data frame but the column names are not nice. Let
us fix this:

```r
colnames(result_df) <- colnames(df)
str(result_df)
```

```
## 'data.frame':	7 obs. of  4 variables:
##  $ Cat1: Factor w/ 3 levels "a","b","c": 1 2 3 1 2 1 1
##  $ Cat2: Factor w/ 2 levels "x","y": 1 1 1 1 2 2 2
##  $ Val1: num  1 1.41 1.73 2 2.24 ...
##  $ Val2: num  3.16 4.47 5.48 6.32 7.07 ...
```
All problems solved.

## Using variables defined outside the lapply loop
If one additionally wants to include other variables defined outside the loop
into the lapply-loop, no problem. Since this type of function definition can not
be resused outside the loop anyway, one can just pass any variable from outside
the loop to the inside. Here is one example where we use a variable called 
var_outside:

```r
var_outside <- 10
result <- lapply(seq(ncol(df)), function(x){
  act_column <- df[,x]
  if(is.factor(act_column)){
    return(tolower(act_column))
  } else if(is.numeric(act_column)){
    sqrt_mult <- sqrt(act_column) * var_outside
    return(sqrt_mult)
  }
})
result <- as.data.frame(result)
colnames(result) <- colnames(df)
result
```

```
##   Cat1 Cat2     Val1     Val2
## 1    a    x 10.00000 31.62278
## 2    b    x 14.14214 44.72136
## 3    c    x 17.32051 54.77226
## 4    a    x 20.00000 63.24555
## 5    b    y 22.36068 70.71068
## 6    a    y 24.49490 77.45967
## 7    a    y 26.45751 83.66600
```

**Watch out:** Regarding the utilization of variables defined outside the loop 
within the loop, one special case must be kept in mind: it is not possible to 
change the content of any variable defined outside the loop with the apply
function. Here is one example where we store the result of the `lowercase` 
function in a variable called df before returning it. Remember that df is also
the data frame we modify! We also include another variable called test which
is used as intermediate storage for the `sqrt` return:

```r
test <- 1
result <- lapply(seq(ncol(df)), function(x){
  act_column <- df[,x]
  if(is.factor(act_column)){
    df <- tolower(act_column)
    return(df)
  } else if(is.numeric(act_column)){
    test <- sqrt(act_column) * var_outside
    return(test)
  }
})
result <- as.data.frame(result)
colnames(result) <- colnames(df)
result
```

```
##   Cat1 Cat2     Val1     Val2
## 1    a    x 10.00000 31.62278
## 2    b    x 14.14214 44.72136
## 3    c    x 17.32051 54.77226
## 4    a    x 20.00000 63.24555
## 5    b    y 22.36068 70.71068
## 6    a    y 24.49490 77.45967
## 7    a    y 26.45751 83.66600
```
The result is obviously correct. Now have a look at df and test:

```r
test
```

```
## [1] 1
```

```r
df
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
Although test is used as variable name for the lower case conversion and df
is used for the numeric computation, the content of the variables outside the 
loop has not changed.

Hence, if you realy want to change the content of a variable defined outside
the loop, use a `for` loop instead of `apply`.

## Returning data frames within the lapply loop
One last but important and heavily utilized procedure: In the above examples, the
function used within `lapply` returns a vector which allows an easy conversion
of the overall returned nested list from the `lapply` function by using
the `as.data.frame` function. In many cases, your function will return a data 
frame not a vector which makes the conversion a tiny bit more complicated.

Here is an example. In this case we combine columns Cat1 and Cat2 as well as 
Val1 and Val2 into new columns. Therefore it is feasable to change the 
control statement of the `apply` function, too so it gives us the number of the
individual rows (please note that this example can easily realized without any
loop so take it just as an illustration):

```r
result <- lapply(seq(nrow(df)), function(x){
  new_structure <- data.frame(Col1 = paste(df[x,1], df[x,2]),
                              Col2 = df[x,3] * df[x,4])
  return(new_structure)
})
str(result)
```

```
## List of 7
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ Col1: Factor w/ 1 level "A X": 1
##   ..$ Col2: num 10
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ Col1: Factor w/ 1 level "B X": 1
##   ..$ Col2: num 40
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ Col1: Factor w/ 1 level "C X": 1
##   ..$ Col2: num 90
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ Col1: Factor w/ 1 level "A X": 1
##   ..$ Col2: num 160
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ Col1: Factor w/ 1 level "B Y": 1
##   ..$ Col2: num 250
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ Col1: Factor w/ 1 level "A Y": 1
##   ..$ Col2: num 360
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ Col1: Factor w/ 1 level "A Y": 1
##   ..$ Col2: num 490
```
The result is a structured list with a data frame within each list element. To
build an overall data frame one basically just has to copy each row of the 
individual data frames below each other. This is done by the following statement:

```r
result <- do.call("rbind", result)
str(result)
```

```
## 'data.frame':	7 obs. of  2 variables:
##  $ Col1: Factor w/ 5 levels "A X","B X","C X",..: 1 2 3 1 4 5 5
##  $ Col2: num  10 40 90 160 250 360 490
```
