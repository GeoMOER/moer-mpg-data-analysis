---
title: "Example: Colors and maps"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/unnamed-chunk-8-1.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This is a short example on how to use the hcl color palette for coloring features of a shapefile. Country values are **simulated random numbers**, not measured national statistics; the maps demonstrate classification and color choices.

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
Download the data [here](https://naciscdn.org/naturalearth/50m/cultural/ne_50m_admin_0_countries.zip){:target="_blank"} or directly from within R.

```r
download.file("https://naciscdn.org/naturalearth/50m/cultural/ne_50m_admin_0_countries.zip", 
             destfile = "countries.zip")
unzip("countries.zip", exdir = "countries")
```
The country boundaries come from [Natural Earth](https://www.naturalearthdata.com/), at 1:50 million scale. Natural Earth describes its map data as [public domain](https://www.naturalearthdata.com/about/terms-of-use/). The numerical values below are generated in R and do not come from Natural Earth.

## Plot with random numbers
```r
## Read in shapefile
world <- terra::vect("countries/ne_50m_admin_0_countries.shp")

## Generate random numbers that follow a normal distribution for each feature in the map
randomNumbers <- rnorm(nrow(world), 50, 16)

## Plot using the random numbers
plot(world, values = randomNumbers)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-3-1.png" alt="World map of simulated normally distributed country values, displayed with the default color classes; these are not measured country statistics." style="display: block; margin: auto;" />

## Plot with 10 hcl color classes {#plot-with-10-hcl-colour-classes}
We would like to have 10 hcl color classes. This can be achieved by adjusting the `breaks` (number of breaks) and `col` (color) parameters.

```r
myColours <- rev(clrs_hcl2(10))
map <- plot(world, values = randomNumbers, breaks = 10, col = myColours)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-4-1.png" alt="World map of the same simulated values in ten equal-width HCL classes; countries in middle classes occur most often." style="display: block; margin: auto;" />

Equal interval breaks are used by default. The frequency of observations within each color class is shown below.
```r
hist(randomNumbers, breaks = map$breaks, col = myColours)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-5-1.png" alt="Histogram for the equal-width map classes peaks near the middle, with fewer simulated values in the end classes." style="display: block; margin: auto;" />

## Plot with equal count breaks
In the above map, some colors appear more often than others. If we want every color to appear about the same number of times, we can change the `breakby` parameter to get equal count breaks.

```r
map <- plot(world, values = randomNumbers, breaks = 10, col = myColours, breakby = "cases")
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-6-1.png" alt="World map of the same simulated values using equal-count classes; numeric class widths vary to include similar numbers of countries." style="display: block; margin: auto;" />

The frequency of observations within each color class is now about the same.

The two classifications answer different display questions. Equal-width classes divide the numerical range into the same-sized intervals, so the simulated values are concentrated in the middle classes. Equal-count classes vary their numerical widths to place similar numbers of country features in each class. This does not equalize the geographic area of the colors on the map. Read the numerical legend and the histograms together; color alone does not convey the class boundaries.

```r
hist(randomNumbers, breaks = map$breaks, col = myColours, freq = TRUE)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-7-1.png" alt="Equal-count histogram has bins of different widths but similar counts, illustrating the class definition used in the preceding map." style="display: block; margin: auto;" />

## Save information in map
We can save the random numbers and the colors assigned by the equal-count breaks in the map for later use. Each feature receives the color of its value's class.
```r
world$randomNumber <- randomNumbers
color_class <- cut(randomNumbers, breaks = map$breaks,
                   include.lowest = TRUE, labels = FALSE)
world$randomNumberColour <- myColours[color_class]
terra::writeVector(world, "a whole new world.shp", overwrite = TRUE)
```
