---
title: "Example: List Basics"
toc: true
toc_label: In this example
---


Lists are one of the most flexible data structures in R.

## Creation of a list
A list is created with the `list` function. Here are some examples:

```r
my_list_1 <- list(c(1,2,3,4,5))
my_list_1
```

```
## [[1]]
## [1] 1 2 3 4 5
```

```r
my_list_2 <- list(x=c(2.5, 3.5), y=c(5, 10))
my_list_2
```

```
## $x
## [1] 2.5 3.5
## 
## $y
## [1]  5 10
```

```r
my_list_3 <- list(name=c("A", "B", "C"), my_list_2)
my_list_3
```

```
## $name
## [1] "A" "B" "C"
## 
## [[2]]
## [[2]]$x
## [1] 2.5 3.5
## 
## [[2]]$y
## [1]  5 10
```
Lists can also be structured (i.e. lists in lists) which looks like that:

```r
my_list_4 <- list(c(1,2,3,4,5), c("A", "B", "C"))
my_list_4
```

```
## [[1]]
## [1] 1 2 3 4 5
## 
## [[2]]
## [1] "A" "B" "C"
```


## Structure of a list
To get the length of a list, use the `length` function as for vectors. For 
information on the structure, use the `str` function:

```r
length(my_list_3)
```

```
## [1] 2
```

```r
str(my_list_3)
```

```
## List of 2
##  $ name: chr [1:3] "A" "B" "C"
##  $     :List of 2
##   ..$ x: num [1:2] 2.5 3.5
##   ..$ y: num [1:2] 5 10
```
In case of structured lists, the `length` function returns the dimension of the
outer list:

```r
length(my_list_4)
```

```
## [1] 2
```

```r
str(my_list_4)
```

```
## List of 2
##  $ : num [1:5] 1 2 3 4 5
##  $ : chr [1:3] "A" "B" "C"
```
## Displaying and accessing the content of a list
In order access elements of a list, you have to supply the  position of the 
element in the vector within double square brackets (not in simple brackets 
as it is the case for vectors). Think about it as if you have to access the list
and then the vector within the list element which contains the
values. To finally access an element of the vector, one bracket pair is enough.

```r
my_list_2[[1]]
```

```
## [1] 2.5 3.5
```

```r
my_list_2[[1]][2]
```

```
## [1] 3.5
```

```r
my_list_3[[2]][[1]][1]
```

```
## [1] 2.5
```
## Changing, adding or deleting an element of a list
To add an element, you have to add a new vector to the list at a specified 
position. To overwrite an element of a list, you have to get it using the logic
of accessing the value(s) of a list presented above:

```r
# add an element to a list
my_list <- list(c(1,2,3,4,5))
my_list
```

```
## [[1]]
## [1] 1 2 3 4 5
```

```r
my_list[[2]] <- c("A", "B")
my_list
```

```
## [[1]]
## [1] 1 2 3 4 5
## 
## [[2]]
## [1] "A" "B"
```

```r
# overwrite a list element
my_list[[2]] <- c("G", "H")
my_list
```

```
## [[1]]
## [1] 1 2 3 4 5
## 
## [[2]]
## [1] "G" "H"
```
To actually delete an element, it has to be set to `NULL`.

```r
my_list[[2]] <- NULL
my_list
```

```
## [[1]]
## [1] 1 2 3 4 5
```
For more information have a look at e.g. the respective [data type](http://www.statmethods.net/input/datatypes.html){:target="_blank"} 
site at Quick R. There you will also find an overview of how to get [information about an object](http://www.statmethods.net/input/contents.html){:target="_blank"}. 
Of course, looking into the package documentation or search the web is always a good idea, too.
