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

# Clean the workspace first
rm(list=ls())

# Get helper function from the previous page
clrs_hcl2 <- function(n) {
  hcl(h = seq(0, 260, length.out = n), 
      c = 60, l = seq(10, 90, length.out = n), 
      fixup = TRUE)
}

## Set seed to get the same results every time
set.seed(42)
```

## Download world map as an example
Download the data [here](https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip){:target="_blank"} or directly from within R.

```r
download.file("https://naciscdn.org/naturalearth/50m/cultural/ne_50m_admin_0_countries.zip", 
             destfile = "countries.zip")
```
[NaturalEarthData](https://www.naturalearthdata.com/){:target="_blank"} has a nice collection of other free GIS data, too.

## Plot with random numbers
```r
## Read in shapefile
world <- terra::vect("countries/ne_50m_admin_0_countries.shp")

## Generate random numbers that follow a normal distribution for each feature in the map
randomNumbers <- rnorm(nrow(world), 50, 16)

## Plot using the random numbers
plot(world, values = randomNumbers)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

## Plot with 10 hcl colour classes
We would like to have 10 hcl colour classes. This can be achieved by adjusting the `breaks` (number of breaks) and `col` (colour) parameters.

```r
myColours <- rev(clrs_hcl2(10))
map <- plot(world, values = randomNumbers, breaks = 10, col = myColours)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

Equal interval breaks are used by default. The frequency of observations within each colour class is shown below.
```r
hist(randomNumbers, breaks = map$breaks, col = myColours)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

## Plot with equal count breaks
In the above map, some colours appear more often than others. If we want every colour to appear about the same number of times, we can change the `breakby` parameter to get equal count breaks.

```r
map <- plot(world, values = randomNumbers, breaks = 10, col = myColours, breakby = "cases")
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-6-1.png" style="display: block; margin: auto;" />

The frequency of observations within each colour class is now about the same.
```r
hist(randomNumbers, breaks = map$breaks, col = myColours, freq = TRUE)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-7-1.png" style="display: block; margin: auto;" />

## Save information in map
We can save the random numbers and the colour information in the map for later use.
```r
world$randomNumber <- randomNumbers
world$randomNumberColour <- myColours
terra::writeVector(world, "a whole new world.shp", overwrite = TRUE)
```
