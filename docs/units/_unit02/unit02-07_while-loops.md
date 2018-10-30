---
title: "Example: While-loops"
toc: true
toc_label: In this example
---

As for loops, while loops are repeating structures which enable the execution of 
certain code blocks for multiple times. The difference is that for while loops 
the number of necessary repititions is not known at the starting time of the loop.


While loops are executed until a termination condition is reached. In the 
following example, this condition is given by `a > b`:

```r
a <- 7
b <- 10
while(a <= b){
  print(a)
  a <- a + 1
}
```

```
## [1] 7
## [1] 8
## [1] 9
## [1] 10
```
Obviously, this condition is executed 4 times (i.e. a = 7, 8, 9, 10). After that
`a + 1` gives 11 which is larger than b and the termination condition is reached.

As for any other loop, nested loops are also possible.

```r
a <- 7
b <- 10
c <- 10
while(a <= b){
  print(paste0("Outer loop value of a: ", a))
  while(c > a){
    print(paste0("   Inner loop value of c: ", c))
    c <- c - 1 
  }
  c <- 10
  a <- a + 1
  
}
```

```
## [1] "Outer loop value of a: 7"
## [1] "   Inner loop value of c: 10"
## [1] "   Inner loop value of c: 9"
## [1] "   Inner loop value of c: 8"
## [1] "Outer loop value of a: 8"
## [1] "   Inner loop value of c: 10"
## [1] "   Inner loop value of c: 9"
## [1] "Outer loop value of a: 9"
## [1] "   Inner loop value of c: 10"
## [1] "Outer loop value of a: 10"
```
Variable `c` has to be reseted to its initial value every time the inner loop
is completed. Otherwise it would not start a second time since the termination
condition is already reached. Of course this behaviour can also be usefull for
a variety of problems.

