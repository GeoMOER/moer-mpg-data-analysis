---
title: "Example: Colours and maps"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/unnamed-chunk-8-1.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This is a short example on how to use the hcl colour palette for colouring features of a shapefile.

## Set up
```r
# Load the required packages
library("terra")
library("classInt")

# Clean the workspace first
rm(list=ls())

# Get helper function from the previous page
clrs_hcl2 <- function(n) {
  hcl(h = seq(0, 260, length.out = n), 
      c = 60, l = seq(10, 90, length.out = n), 
      fixup = TRUE)
}

## Set the seed to get the same results every time
set.seed(42)
```

## Download world map as an example
Download the data [here](https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip){:target="_blank"} or directly from within R.

```r, eval = FALSE
download.file("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip", 
              destfile = "countries.zip")
```
[NaturalEarthData](https://www.naturalearthdata.com/){:target="_blank"} has a nice collection of other free GIS data, too.

## Plot with random colours
```r
## Read in shapefile
world <- terra::vect("countries/ne_50m_admin_0_countries.shp")

## Generate random values that follow a normal distribution for each feature in the map
randomNumbers <- as.integer(rnorm(nrow(world), 50, 16))

## Plot using the random values as colours
plot(world, col = randomNumbers)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

There are so many colours in the map and it looks messy.
```r
length(unique(randomNumbers))
```

```
## [1] 66
```

## Plot using hcl colours with equal interval classes
If we want to do classified plotting, i.e. assign a particular colour to each class, we need to classify our data first and then assign colours to each class.

```r
# number of classes
n <- 10

# Classify the randomly generated data using 10 equal interval classes
intervals <- classInt::classIntervals(randomNumbers, n = n, style = "equal")

# assign colours to the intervals
myColours <- classInt::findColours(intervals, rev(clrs_hcl2(n)), cutlabels = FALSE)

# Plot using the new colours
plot(world, col = myColours)
add_legend(
    "left", legend = names(attr(myColours, "table")), 
    fill = attr(myColours, "palette"), 
    border = attr(myColours, "palette"), 
    bty = "n", title = "Legend", cex = 0.8, y.intersp = 0.7
)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

We used 10 equal interval classes. The frequency of colours is shown below.
```r
hist(randomNumbers, breaks = intervals$brks, col = attr(myColours, "palette"))
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-6-1.png" style="display: block; margin: auto;" />

## Plot using hcl colours with equal count classes
In the above map, some colours appeared more often than others. If we want every colour to appear about the same number of times, we can divide the values into equal count classes.

```r
# Classify the randomly generated data using 10 equal count classes
intervals <- classInt::classIntervals(randomNumbers, n = n, style = "quantile")

# assign colours to the intervals
myColours <- classInt::findColours(intervals, rev(clrs_hcl2(n)), cutlabels = FALSE)

# Plot using the new colours
plot(world, col = myColours)
add_legend("left", legend = names(attr(myColours, "table")), 
           fill = attr(myColours, "palette"), 
           border = attr(myColours, "palette"), 
           bty = "n", title = "Legend", cex = 0.8, y.intersp = 0.7)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-7-1.png" style="display: block; margin: auto;" />

We used 10 equal count classes. The frequency of colours is now about the same.
```r
hist(randomNumbers, breaks = intervals$brks, col = attr(myColours, "palette"), freq = TRUE)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-8-1.png" style="display: block; margin: auto;" />

## Save colours in map
We can save the colour information in the map for later use.
```r
world$colours <- myColours
terra::writeVector(world, "world with color.shp", overwrite = TRUE)
```