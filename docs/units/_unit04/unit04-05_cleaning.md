---
title: "Example: Cleaning Columns"
toc: true
toc_label: In this example
---


Cleaning data frames involves quite different aspects like splitting cell entries, converting data types or the conversion of "wide" to "long" format. 
In general, the aim is to come up with a data frame, that has [Wickham 2014](https://www.jstatsoft.org/article/view/v040i01):

* a separate column for each variable (which has exactly one kind of information, e.g. not major and minor subject)
* a separate row for each observation
* a separate data frame for each kind of observation

The following examples are based on a data set showing the percentage fraction of settlement, recreational, agricultural, and forest areas for each rural district in Germany. The data has been provided through the [Regional Database Germany](https://www.regionalstatistik.de/genesis/online/) and formed also the basis for the visual data exploration example.

### Reading data and first look

```r
lu <- read.table(file.path(envrmt$path_csv, "AI001_gebiet_flaeche.txt"),
                 skip = 4, header = TRUE, sep = ";", dec = ",")
head(lu)
```

```
##      X   X.1                                            X.2
## 1 1996    DG                                    Deutschland
## 2 1996    01                             Schleswig-Holstein
## 3 1996 01001                    Flensburg, Kreisfreie Stadt
## 4 1996 01002       Kiel, Landeshauptstadt, Kreisfreie Stadt
## 5 1996 01003           Lübeck, Hansestadt, Kreisfreie Stadt
## 6 1996 01004                   Neumünster, Kreisfreie Stadt
##   Anteil.Siedlungs..und.Verkehrsfläche.an.Gesamtfl.
## 1                                              11,8
## 2                                              10,8
## 3                                              47,3
## 4                                              52,1
## 5                                              30,2
## 6                                              46,4
##   Anteil.Erholungsfläche.an.Gesamtfläche
## 1                                    0,7
## 2                                    0,7
## 3                                    5,1
## 4                                    1,3
## 5                                    2,9
## 6                                    4,9
##   Anteil.Landwirtschaftsfläche.an.Gesamtfläche
## 1                                         54,1
## 2                                         73,0
## 3                                         25,1
## 4                                         34,7
## 5                                         39,7
## 6                                         46,9
##   Anteil.Waldfläche.an.Gesamtfläche
## 1                              29,4
## 2                               9,3
## 3                               6,0
## 4                               3,3
## 5                              12,9
## 6                               3,4
```

Let's have a closer look on the structure before we go on.

```r
str(lu)
```

```
## 'data.frame':	5250 obs. of  7 variables:
##  $ X                                                : int  1996 1996 1996 1996 1996 1996 1996 1996 1996 1996 ...
##  $ X.1                                              : Factor w/ 525 levels "01","01001","01002",..: 525 1 2 3 4 5 6 7 8 9 ...
##  $ X.2                                              : Factor w/ 518 levels "      Aachen, Kreis",..: 518 516 114 192 244 285 85 166 293 319 ...
##  $ Anteil.Siedlungs..und.Verkehrsfläche.an.Gesamtfl.: Factor w/ 581 levels ".","10,0","10,1",..: 20 10 366 412 200 357 2 576 581 2 ...
##  $ Anteil.Erholungsfläche.an.Gesamtfläche           : Factor w/ 126 levels ".","0,0","0,1",..: 9 9 79 15 57 77 7 7 13 12 ...
##  $ Anteil.Landwirtschaftsfläche.an.Gesamtfläche     : Factor w/ 683 levels ".","10,0","10,5",..: 413 603 119 213 263 340 653 482 652 620 ...
##  $ Anteil.Waldfläche.an.Gesamtfläche                : Factor w/ 592 levels ".","0,6","0,7",..: 217 586 522 226 44 227 224 169 230 583 ...
```

As one can see, 

* the column names are far from optimal,
* the numerical values are stored as factors because there are not numbers in each cell but also - and this can not be seen from the view rows printed above - some "." as the only cell content; as a consequence, the `data.frame` function uses factors during the initialization of the data frame which basically means that the values are reprsented by some kind of special character data type,
* the "Anteil*" column names are actually values, not variable names.

Please remember: this is just one example out of an almoust infinite amount of data sets. The following tasks might not be necessary at all for a specific data set. Of course, the following might also not be enough to clean a given data set.

### Renaming columns
Let's start with renaming the column names:

```r
names(lu) <- c("Year", "ID", "Place", "Settlement", "Recreation", 
               "Agriculture", "Forest")
str(lu)
```

```
## 'data.frame':	5250 obs. of  7 variables:
##  $ Year       : int  1996 1996 1996 1996 1996 1996 1996 1996 1996 1996 ...
##  $ ID         : Factor w/ 525 levels "01","01001","01002",..: 525 1 2 3 4 5 6 7 8 9 ...
##  $ Place      : Factor w/ 518 levels "      Aachen, Kreis",..: 518 516 114 192 244 285 85 166 293 319 ...
##  $ Settlement : Factor w/ 581 levels ".","10,0","10,1",..: 20 10 366 412 200 357 2 576 581 2 ...
##  $ Recreation : Factor w/ 126 levels ".","0,0","0,1",..: 9 9 79 15 57 77 7 7 13 12 ...
##  $ Agriculture: Factor w/ 683 levels ".","10,0","10,5",..: 413 603 119 213 263 340 653 482 652 620 ...
##  $ Forest     : Factor w/ 592 levels ".","0,6","0,7",..: 217 586 522 226 44 227 224 169 230 583 ...
```

### Converting data types
Once this is done, we can continoue with converting the numerical values to actual numerical data types. Factors work in such a way that a list of strings (i.e. factors) is referenced by an id (e.g. if the string we want to save in a cell is "test" and if "test" is on position three of the factor vector, not the character string "test" but the number 3 is stored in the respective cell and referenced to the string). Hence, we canot directly convert factors to numerical values because in this case we would just convert the reference id number but we have to convert the factor to a character first and then convert this character to a numeric values (if possible). Since in the present context, "." are also found in the columns, we will set each cell which contains just one "." to NA first and then convert the cell to numeric.


```r
for(c in colnames(lu)[4:7]){
  lu[, c][lu[, c] == "."] <- NA  
  lu[, c] <- as.numeric(sub(",", ".", as.character(lu[, c])))
}

str(lu)
```

```
## 'data.frame':	5250 obs. of  7 variables:
##  $ Year       : int  1996 1996 1996 1996 1996 1996 1996 1996 1996 1996 ...
##  $ ID         : Factor w/ 525 levels "01","01001","01002",..: 525 1 2 3 4 5 6 7 8 9 ...
##  $ Place      : Factor w/ 518 levels "      Aachen, Kreis",..: 518 516 114 192 244 285 85 166 293 319 ...
##  $ Settlement : num  11.8 10.8 47.3 52.1 30.2 46.4 10 9.4 9.9 10 ...
##  $ Recreation : num  0.7 0.7 5.1 1.3 2.9 4.9 0.5 0.5 1.1 1 ...
##  $ Agriculture: num  54.1 73 25.1 34.7 39.7 46.9 78.6 61 78.5 74.7 ...
##  $ Forest     : num  29.4 9.3 6 3.3 12.9 3.4 3.1 24.5 3.7 9 ...
```

### Converting wide to long format
Finally, let's remove any column name which is actually not a variable name but a value from the header line and include it within the data frame. This is to be known as converting the data frame from "wide" to "long" format (you have to load the `reshape2` library for this example first):


```r
lu_long <- melt(lu, id.vars = c("Year", "ID", "Place"))
head(lu_long)
```

```
##   Year    ID                                          Place   variable
## 1 1996    DG                                    Deutschland Settlement
## 2 1996    01                             Schleswig-Holstein Settlement
## 3 1996 01001                    Flensburg, Kreisfreie Stadt Settlement
## 4 1996 01002       Kiel, Landeshauptstadt, Kreisfreie Stadt Settlement
## 5 1996 01003           Lübeck, Hansestadt, Kreisfreie Stadt Settlement
## 6 1996 01004                   Neumünster, Kreisfreie Stadt Settlement
##   value
## 1  11.8
## 2  10.8
## 3  47.3
## 4  52.1
## 5  30.2
## 6  46.4
```
The column (i.e. variable) names passed to the parameter `id.vars` are those columns which represent actual variables within their names. The columns Stellement, Recreation, Agriculture or Forest can owever be summarized to one variable since they all represent land cover. The values which have been stored within these columns have been transfered to a seperate column (called `values` in this case).

### Split multiple information within one column
The content of column "Place"" could be regarded as both human readable information or additional machine readable data source. If we go for the latter, mixing names (e.g. Flensburg, Kiel) and types (e.g. citiy, county) is not a good option. It seems that the different kinds of information are comma separated so let's split the column entries using "," as a separator and have a closer look on the results.

```r
place <- strsplit(as.character(lu$Place), ",")
head(place)
```

```
## [[1]]
## [1] "Deutschland"
## 
## [[2]]
## [1] "  Schleswig-Holstein"
## 
## [[3]]
## [1] "      Flensburg"   " Kreisfreie Stadt"
## 
## [[4]]
## [1] "      Kiel"        " Landeshauptstadt" " Kreisfreie Stadt"
## 
## [[5]]
## [1] "      Lübeck"      " Hansestadt"       " Kreisfreie Stadt"
## 
## [[6]]
## [1] "      Neumünster"  " Kreisfreie Stadt"
```

```r
max(sapply(place, length))
```

```
## [1] 3
```
As one can see, splitting by comma is a good option to separate the content. However, the original information obvioulsy is comprised  by either one, two or three (see result of the `max` function) information parts. Hence, an appropriate next step would be the compilation of a data frame with three columns and a fill-up strategy which makes sure that if 

* one information part is stored in the cell, the part is saved in the first column of the target data frame,
* two information parts are stored in the cell, they are saved in the first and second column of the target data frame,
* three information parts are stored in the cell, they are saved in the first, second and third column of the target data frame.

If the second or third column is not filled by an information part, NA is stored in the respective cells instead. Let's do it (the `gsub` function is used to delete leading white spaces):

```r
place_df <- lapply(place, function(i){
  p1 <- sub("^\\s+", "", i[1])  # Trim leading white spaces
  if(length(i) > 2){
    p2 <- sub("^\\s+", "", i[2])
    p3 <- sub("^\\s+", "", i[3])
  } else if (length(i) > 1){
    p2 <- sub("^\\s+", "", i[2])
    p3 <- NA
  } else {
    p2 <- NA
    p3 <- NA
  }
  data.frame(A = p1,
             B = p2,
             C = p3)
})
place_df <- do.call("rbind", place_df)
place_df$ID <- lu$ID 
place_df$Year <- lu$Year
head(place_df)
```

```
##                    A                B                C    ID Year
## 1        Deutschland             <NA>             <NA>    DG 1996
## 2 Schleswig-Holstein             <NA>             <NA>    01 1996
## 3          Flensburg Kreisfreie Stadt             <NA> 01001 1996
## 4               Kiel Landeshauptstadt Kreisfreie Stadt 01002 1996
## 5             Lübeck       Hansestadt Kreisfreie Stadt 01003 1996
## 6         Neumünster Kreisfreie Stadt             <NA> 01004 1996
```
We add the information from column ID and Year since we need it later for merging it with the long version of the land cover data frame.

While column is filed in any case, let's have a look at the different entries in column B and C:

```r
unique(place_df[, 2])
```

```
##  [1] NA                  "Kreisfreie Stadt"  "Landeshauptstadt" 
##  [4] "Hansestadt"        "Landkreis"         "Stat. Region"     
##  [7] "Regierungsbezirk"  "Kreis"             "krfr. Stadt"      
## [10] "Universitätsstadt" "Regionalverband"   "Stadt"            
## [13] "NUTS 2-Region"     "krsfr. Stadt"
```

```r
unique(place_df[, 3])
```

```
## [1] NA                 "Kreisfreie Stadt"
```
Obviously, the only information stored in the third column is "Kreisfreie Stadt". What is stored in the second column for these cases?

```r
unique(place_df$B[!is.na(place_df$C)])
```

```
## [1] "Landeshauptstadt"  "Hansestadt"        "Universitätsstadt"
```
OK, if the place is one of "Landeshauptstadt", "Hansestadt" or "Universitaetsstadt", then the third column contains the information "Kreisfreie Stadt". Hence, if we want to group by "Kreisfreie Stadt", we actually would need the third column. 

One strategy could be to make a structure which shows the name in the first column, the general type of the place in the second column and additional (not mandatory information) in the third column. If one follows this strategy, the content of column two and three has to be switched for the rows with a non-NA entry in the third column:

```r
place_df[!is.na(place_df$C),] <- place_df[!is.na(place_df$C), c(1,3,2, 4, 5)]
```
Although it might look a little weird, it is very easy and straight forward. We subset our data frame to rows which are not NA in the third column (i.e. column C) on both sides of the equal sign and defign the order of column entries to 1, 3, 2 and then 4 and 5 for ID and year. This gives us what we want.

```r
head(place_df)
```

```
##                    A                B                C    ID Year
## 1        Deutschland             <NA>             <NA>    DG 1996
## 2 Schleswig-Holstein             <NA>             <NA>    01 1996
## 3          Flensburg Kreisfreie Stadt             <NA> 01001 1996
## 4               Kiel Kreisfreie Stadt Landeshauptstadt 01002 1996
## 5             Lübeck Kreisfreie Stadt       Hansestadt 01003 1996
## 6         Neumünster Kreisfreie Stadt             <NA> 01004 1996
```
Finished? No, There are at least some entries without any kind of type information in column B. In fact, there are quite many of them:

```r
unique(lu$Place[is.na(place_df$B)])
```

```
##   [1] Deutschland                                      
##   [2]   Schleswig-Holstein                             
##   [3]   Hamburg                                        
##   [4]   Niedersachsen                                  
##   [5]   Bremen                                         
##   [6]   Nordrhein-Westfalen                            
##   [7]       Rhein-Kreis Neuss                          
##   [8]       Städteregion Aachen (einschl. Stadt Aachen)
##   [9]       Rhein-Erft-Kreis                           
##  [10]       Oberbergischer Kreis                       
##  [11]       Rheinisch-Bergischer Kreis                 
##  [12]       Rhein-Sieg-Kreis                           
##  [13]       Ennepe-Ruhr-Kreis                          
##  [14]       Hochsauerlandkreis                         
##  [15]       Märkischer Kreis                           
##  [16]   Hessen                                         
##  [17]       Hochtaunuskreis                            
##  [18]       Main-Kinzig-Kreis                          
##  [19]       Main-Taunus-Kreis                          
##  [20]       Odenwaldkreis                              
##  [21]       Rheingau-Taunus-Kreis                      
##  [22]       Wetteraukreis                              
##  [23]       Lahn-Dill-Kreis                            
##  [24]       Vogelsbergkreis                            
##  [25]       Schwalm-Eder-Kreis                         
##  [26]       Werra-Meißner-Kreis                        
##  [27]   Rheinland-Pfalz                                
##  [28]       Rhein-Hunsrück-Kreis                       
##  [29]       Rhein-Lahn-Kreis                           
##  [30]       Westerwaldkreis                            
##  [31]       Eifelkreis Bitburg-Prüm                    
##  [32]       Donnersbergkreis                           
##  [33]       Rhein-Pfalz-Kreis                          
##  [34]   Baden-Württemberg                              
##  [35]       Rems-Murr-Kreis                            
##  [36]       Hohenlohekreis                             
##  [37]       Main-Tauber-Kreis                          
##  [38]       Ostalbkreis                                
##  [39]       Neckar-Odenwald-Kreis                      
##  [40]       Rhein-Neckar-Kreis                         
##  [41]       Enzkreis                                   
##  [42]       Ortenaukreis                               
##  [43]       Schwarzwald-Baar-Kreis                     
##  [44]       Zollernalbkreis                            
##  [45]       Alb-Donau-Kreis                            
##  [46]       Bodenseekreis                              
##  [47]   Bayern                                         
##  [48]       Ingolstadt                                 
##  [49]       Rosenheim                                  
##  [50]       Landshut                                   
##  [51]       Passau                                     
##  [52]       Straubing                                  
##  [53]       Amberg                                     
##  [54]       Regensburg                                 
##  [55]       Weiden i.d.OPf.                            
##  [56]       Bamberg                                    
##  [57]       Bayreuth                                   
##  [58]       Coburg                                     
##  [59]       Hof                                        
##  [60]       Ansbach                                    
##  [61]       Erlangen                                   
##  [62]       Fürth                                      
##  [63]       Nürnberg                                   
##  [64]       Schwabach                                  
##  [65]       Aschaffenburg                              
##  [66]       Schweinfurt                                
##  [67]       Würzburg                                   
##  [68]       Augsburg                                   
##  [69]       Kaufbeuren                                 
##  [70]       Kempten (Allgäu)                           
##  [71]       Memmingen                                  
##  [72]   Saarland                                       
##  [73]       Saarpfalz-Kreis                            
##  [74]   Berlin                                         
##  [75]   Brandenburg                                    
##  [76]   Mecklenburg-Vorpommern                         
##  [77]       Landkreis Bad Doberan                      
##  [78]       Landkreis Demmin                           
##  [79]       Landkreis Güstrow                          
##  [80]       Landkreis Ludwigslust                      
##  [81]       Landkreis Mecklenburg-Strelitz             
##  [82]       Landkreis Müritz                           
##  [83]       Landkreis Nordvorpommern                   
##  [84]       Landkreis Nordwestmecklenburg              
##  [85]       Landkreis Ostvorpommern                    
##  [86]       Landkreis Parchim                          
##  [87]       Landkreis Rügen                            
##  [88]       Landkreis Uecker-Randow                    
##  [89]       Landkreis Mecklenburgische Seenplatte      
##  [90]       Landkreis Rostock                          
##  [91]       Landkreis Vorpommern-Rügen                 
##  [92]       Landkreis Vorpommern-Greifswald            
##  [93]       Landkreis Ludwigslust-Parchim              
##  [94]   Freistaat Sachsen                              
##  [95]       Vogtlandkreis                              
##  [96]       Mittlerer Erzgebirgskreis                  
##  [97]       Niederschlesischer Oberlausitzkreis        
##  [98]       Weißeritzkreis                             
##  [99]       Muldentalkreis                             
## [100]       Erzgebirgskreis                            
## [101]   Sachsen-Anhalt                                 
## [102]       Altmarkkreis Salzwedel                     
## [103]       Burgenlandkreis                            
## [104]       Saalekreis                                 
## [105]       Salzlandkreis                              
## [106]       Saalkreis                                  
## [107]       Bördekreis                                 
## [108]       Ohrekreis                                  
## [109]   Thüringen                                      
## [110]       Wartburgkreis                              
## [111]       Unstrut-Hainich-Kreis                      
## [112]       Kyffhäuserkreis                            
## [113]       Ilm-Kreis                                  
## [114]       Saale-Holzland-Kreis                       
## [115]       Saale-Orla-Kreis                           
## 518 Levels:       Aachen, Kreis ... Deutschland
```

```r
sum(is.na(place_df$B))
```

```
## [1] 1180
```

Let's take care of all the entries with "*kreis" first:

```r
for(r in seq(nrow(place_df))){
  if(is.na(place_df$B[r]) &
     grepl("kreis", tolower(place_df$A[r]))){
    place_df$B[r] <- "Landkreis"
  }
}
unique(lu_long$Place[is.na(place_df$B)])
```

```
##  [1] Deutschland                                      
##  [2]   Schleswig-Holstein                             
##  [3]   Hamburg                                        
##  [4]   Niedersachsen                                  
##  [5]   Bremen                                         
##  [6]   Nordrhein-Westfalen                            
##  [7]       Städteregion Aachen (einschl. Stadt Aachen)
##  [8]   Hessen                                         
##  [9]   Rheinland-Pfalz                                
## [10]   Baden-Württemberg                              
## [11]   Bayern                                         
## [12]       Ingolstadt                                 
## [13]       Rosenheim                                  
## [14]       Landshut                                   
## [15]       Passau                                     
## [16]       Straubing                                  
## [17]       Amberg                                     
## [18]       Regensburg                                 
## [19]       Weiden i.d.OPf.                            
## [20]       Bamberg                                    
## [21]       Bayreuth                                   
## [22]       Coburg                                     
## [23]       Hof                                        
## [24]       Ansbach                                    
## [25]       Erlangen                                   
## [26]       Fürth                                      
## [27]       Nürnberg                                   
## [28]       Schwabach                                  
## [29]       Aschaffenburg                              
## [30]       Schweinfurt                                
## [31]       Würzburg                                   
## [32]       Augsburg                                   
## [33]       Kaufbeuren                                 
## [34]       Kempten (Allgäu)                           
## [35]       Memmingen                                  
## [36]   Saarland                                       
## [37]   Berlin                                         
## [38]   Brandenburg                                    
## [39]   Mecklenburg-Vorpommern                         
## [40]   Freistaat Sachsen                              
## [41]   Sachsen-Anhalt                                 
## [42]   Thüringen                                      
## 518 Levels:       Aachen, Kreis ... Deutschland
```

```r
sum(is.na(place_df$B))
```

```
## [1] 420
```
This reduces the amount of missing type information considerably. What is left are federal states and some cities. To disentangle states from cities, we will make use of the ID column which we included in our place information. As it looks like, federal states have a two digit ID and the country has the ID "DG".

```r
head(place_df)
```

```
##                    A                B                C    ID Year
## 1        Deutschland             <NA>             <NA>    DG 1996
## 2 Schleswig-Holstein             <NA>             <NA>    01 1996
## 3          Flensburg Kreisfreie Stadt             <NA> 01001 1996
## 4               Kiel Kreisfreie Stadt Landeshauptstadt 01002 1996
## 5             Lübeck Kreisfreie Stadt       Hansestadt 01003 1996
## 6         Neumünster Kreisfreie Stadt             <NA> 01004 1996
```
Let's add the appropriate information in the second column (since the ID column is stored as a factor, we need to convert the variable to a character first in order to count the number of characters):

```r
place_df$B[is.na(place_df$B) & nchar(as.character(place_df$ID) == 2)] <- "Bundesland"
place_df$B[place_df$ID == "DG"] <- "Land"
head(place_df)
```

```
##                    A                B                C    ID Year
## 1        Deutschland             Land             <NA>    DG 1996
## 2 Schleswig-Holstein       Bundesland             <NA>    01 1996
## 3          Flensburg Kreisfreie Stadt             <NA> 01001 1996
## 4               Kiel Kreisfreie Stadt Landeshauptstadt 01002 1996
## 5             Lübeck Kreisfreie Stadt       Hansestadt 01003 1996
## 6         Neumünster Kreisfreie Stadt             <NA> 01004 1996
```

```r
sum(is.na(place_df$B))
```

```
## [1] 0
```
That's it, no more missing information in the second column.

```r
sum(is.na(place_df$B))
```

```
## [1] 0
```

As a last step, we have to merge the separated place information back into the original data frame. For this example, we use the one in long format.

```r
lu_long_final <- merge(lu_long, place_df, by = c("ID", "Year"))
```
For illustration purposes, we just show some rows below:

```r
lu_long_final[c(1,50, 600),]
```

```
##        ID Year                             Place    variable value
## 1      01 1996                Schleswig-Holstein  Recreation   0.7
## 50  01001 2004       Flensburg, Kreisfreie Stadt Agriculture  28.0
## 600 01061 2014              Steinburg, Landkreis      Forest   9.4
##                      A                B    C
## 1   Schleswig-Holstein       Bundesland <NA>
## 50           Flensburg Kreisfreie Stadt <NA>
## 600          Steinburg        Landkreis <NA>
```

Since column "Place" is no longer needed, let's just delete it:

```r
lu_long_final$Place <- NULL
lu_long_final[c(1,50, 600),]
```

```
##        ID Year    variable value                  A                B    C
## 1      01 1996  Recreation   0.7 Schleswig-Holstein       Bundesland <NA>
## 50  01001 2004 Agriculture  28.0          Flensburg Kreisfreie Stadt <NA>
## 600 01061 2014      Forest   9.4          Steinburg        Landkreis <NA>
```
