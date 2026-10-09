---
title: "Example: Vector Basics"
toc: true
toc_label: In this example
header:
  image: "/assets/images/title/title_1600_500.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---



Vectors are the basis for many data types in R.

## Creating a vector
A vector is created using the `c` function. Here are some examples:

```r
my_vector_1 <- c(1,2,3,4,5)
print(my_vector_1)
```

```
## [1] 1 2 3 4 5
```

```r
my_vector_2 <- c(1:10)
print(my_vector_2)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```r
my_vector_3 <- c(10:5)
print(my_vector_3)
```

```
## [1] 10  9  8  7  6  5
```

```r
my_vector_4 <- seq(from=0, to=30, by=10)
print(my_vector_4)
```

```
## [1]  0 10 20 30
```
When you run code in the R console or an R Markdown chunk, you can display a variable's value by typing its name. We will do this in the following examples.

## Length of a vector
To get the length of a vector, use the `length` function:

```r
my_vector <- c(1:10)
length(my_vector)
```

```
## [1] 10
```

## Displaying and accessing the content of a vector
To access a value in a vector, put its position in square brackets. Indexing starts at 1:

```r
# get the value of the element(s) at the specified position(s)
my_vector[1]
```

```
## [1] 1
```

```r
my_vector[1:3]
```

```
## [1] 1 2 3
```

```r
my_vector[c(1,3)]
```

```
## [1] 1 3
```

## Changing, adding or deleting an element of a vector
To overwrite an element, access it using its index. To insert an element, combine the part of the vector before the insertion point, the new value, and the remaining part. Assign the combined vector to a new variable, or assign it to the original name to replace the existing vector. To delete an element, combine the parts before and after the value you want to remove.

```r
# modify an element at position 3
my_vector[3] <- 30

# add an element at position 4
my_added_vector <- c(my_vector[1:3], 20, my_vector[4:length(my_vector)])
my_added_vector
```

```
##  [1]  1  2 30 20  4  5  6  7  8  9 10
```

```r
# delete an element at position 4
my_deleted_vector <- c(my_vector[1:3], my_vector[5:length(my_vector)])
my_deleted_vector
```

```
## [1]  1  2 30  5  6  7  8  9 10
```

## Recycling of vectors
When you combine a shorter vector with a longer one, for example in an arithmetic operation, the shorter vector is recycled until it reaches the length of the longer vector. Its values are repeated as needed.

```r
my_short_vector <- c(1,2,3)
my_long_vector <- c(10,20,30,40,50,60)
my_sum_vector <- my_short_vector + my_long_vector
my_sum_vector
```

```
## [1] 11 22 33 41 52 63
```
For more information, see the accompanying Base R course on [data types](https://geomoer.github.io/moer-base-r/unit02/unit02-01_Intro.html){:target="_blank"} and [object types](https://geomoer.github.io/moer-base-r/unit03/unit03-01_Intro.html){:target="_blank"}.
Of course, looking into the package documentation or searching the web is always a good idea, too.
