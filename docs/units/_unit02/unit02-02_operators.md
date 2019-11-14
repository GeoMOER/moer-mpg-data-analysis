---
title: Operators
---

Control structures require logical or maybe also boolean operators which test simple relationships between two or more variables. Depending on the test results, control structures can be used to decide how the program should go on.

### Logical operators
The basis for deciding between different options during runtime are logical operators. Such operators compare two variables and return *true* or *false* depending on the result of the comparison.

The following logical operators are commonly used:
* x < y: test if x is smaller than y
* x > y: test if x is larger than y
* x == y: test if x is exactly equal to y
* x >= y: test if x is larger or equal than y
* x <= y: test if x is smaller or equal than y
* x != y: test if x is not equal to y

### Boolean Operators
To make decisions based on a comparison of more than two variables, one can combine logical operators using boolean operators. As for logical operators, boolean operators return *true* or *false*.
The following boolean operators are commonly used:

* AND
* OR

The result of boolean operators can be visualized in a truth table.


| a    | b    | AND  | OR   |
| True | True | True | True | 
| True | False | False | True | 
| False | True | False | True | 
| False | False | False | False | 

For more boolean operators and respective truth tables, see the [truth tables](https://en.wikipedia.org/wiki/Truth_table){:target="_blank"} entry at Wikipedia.

## If-then-else
If-then-else decisions are useful if your computation needs different workflows for different variable values.
```yaml
# Pseudocode
if("<some logical (and boolean) expression>"){
    "<do something>"
} else {
    "<do something else>"
}
```

## Loops
Except for the lapply-loop (representative for R's entire *apply* family), the following loops exist in all programming languages.

### For-loop
Useful if your computation needs the same sequential workflow for different variables or subsets.
```yaml
# Pseudocode
for(<iteration variable> in <control vector>){
    <do something using the iteration variable>
}
```

### Lapply-loop
The *apply* family of loops is special to R. One of the most used loops of this family is `lapply`. It is largely compareable to a for-loop but calls a function for each iteration and returns a list of the function's results. Hence, it is useful if your computation needs the same sequential workflow for different variables or subsets *and* you want the results returned in a list.
```yaml
# Pseudocode
lapply(<control vector>, function(<iteration variable>){
    <do something using the iteration variable>
    return(<result>)
})
```

### While-loop
Useful if your computation needs the same sequential workflow for a variable or subsets but you only know how often it is needed when the loop is already running.
```yaml
# Pseudocode
while("<some logical expression with iteration variable>"){
    <do something using iteration variable and update it>
}
```

## What loop to choose?
{% include figure image_path="/assets/images/unit02-which-loop-to-choose.jpg" alt="Flow chart showing a decision tree which helps to choose the right loop." %}
