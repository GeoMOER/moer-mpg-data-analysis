---
title: Decisions and Loops
---

Decision structures are like junctions in the analysis workflow and decide which way to go during runtime. Loops are the workhorses for repeating the same computations on different subsets of the data.

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