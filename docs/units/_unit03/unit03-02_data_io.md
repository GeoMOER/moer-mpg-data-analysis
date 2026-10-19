---
title: Tabulated Data I/O
header:
  image: "/assets/images/teaser/holz.jpg"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Reading tabular data into a data frame or writing it to a file is a common task in data analysis. Use `read.table` to read data and `write.table` to write it.
```yaml
df <- read.table(<file>, header = FALSE, sep = "", 
                 dec = ".", skip = 0, ...)

write.table(df, file = <file>, sep = " ", dec = ".", ...)
```

Writing CSV files is a good choice for data exchange with software outside R. If you want to re-use the information stored in a data.frame or *any* other variable in R, writing the actual R object to a file connection will be of some benefit especially for more complex objects like model outputs or geo-datasets which do not represent the final information (because this would likely be shared with others using GeoTIFF or other widely recognized formats). To save an R object to a file connection, use the saveRDS function, to read it, use the readRDS function. The file extension "rds" is generally used for that format.
```yaml
saveRDS(df, file = <file>)

df = readRDS(<file>)
```
See the respective help pages for more details.

