---
title: Tabulated Data I/O
---

Reading or writing tabulated data into or from a data frame is a quite common task in data analysis. You could use the read.table function for this.
```yaml
df <- read.table(<file>, header = FALSE, sep = “”, 
                 dec = “.”, skip = 0, ...)

write.table(df, file = <file>, sep = “ “, dec = “.”, ...)
```

Writing into CSV files is a good choice for data exchange into the non-R world. If you want to re-use the information stored in a data.frame or *any* other variable in R, writing the actual R object to a file connection will be of some benefit especially for more complex objects like model outputs or geo-datasets which do not represent the final information (because this would likely be shared to others using GeoTiff or other well recognized formats). To save an R object to a file connection, use the saveRDS function, to read it, use the readRDS function. The file extension "rds" is generally used for that format.
```yaml
saveRDS(df, file = <file>)

df = readRDS(<file>)
```
See the respective help pages for more details.

