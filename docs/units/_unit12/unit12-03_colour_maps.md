---
title: "Example: Colors and Maps"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/unnamed-chunk-8-1.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Apply a sequential palette to country areas stored in a shapefile, a geographic data format. The map setup below is provided so that you can concentrate on the colors and class boundaries. Country values are **simulated random numbers**, not measured national statistics; the maps demonstrate classification and color choices.

## Set up

``` r
# Load the required packages
library("terra")
```

```
## terra 1.9.50
```

``` r
## Set seed to get the same results every time
set.seed(42)
```

## Download world map as an example
Download the data [here](https://naciscdn.org/naturalearth/50m/cultural/ne_50m_admin_0_countries.zip){:target="_blank"} or directly from within R.


``` r
dir.create("Data", showWarnings = FALSE)
download.file("https://naciscdn.org/naturalearth/50m/cultural/ne_50m_admin_0_countries.zip",
             destfile = "Data/countries.zip")
unzip("Data/countries.zip", exdir = "Data/countries")
```
The country boundaries come from [Natural Earth](https://www.naturalearthdata.com/), at 1:50 million scale. Natural Earth describes its map data as [public domain](https://www.naturalearthdata.com/about/terms-of-use/). The numerical values below are generated in R and do not come from Natural Earth.

## Plot with random numbers

``` r
## Read in shapefile
world <- terra::vect("Data/countries/ne_50m_admin_0_countries.shp")

## Generate random numbers that follow a normal distribution for each feature in the map
randomNumbers <- rnorm(nrow(world), 50, 16)

## Plot using the random numbers
plot(world, values = randomNumbers)
```

![World map of simulated normally distributed country values, displayed with the default color classes; these are not measured country statistics.]({{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-3-1.png)

## Plot with 10 hcl color classes {#plot-with-10-hcl-colour-classes}
Use ten **classes**, each covering a range of values and receiving one color. In `terra::plot()`, `breaks = 10` requests ten classes and `col` supplies their colors. The sequential palette runs from light for low values to dark for high values.


``` r
myColours <- hcl.colors(10, "YlGnBu", rev = TRUE)
map <- plot(world, values = randomNumbers, breaks = 10, col = myColours)
```

![World map of the same simulated values in ten equal-width HCL classes; countries in middle classes occur most often.]({{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-4-1.png)

Equal-width intervals are used by default. `map$breaks` contains the class boundaries used in the map. `cut()` assigns each value to an interval; `table()` counts the country features in each interval. Display these counts as a bar chart, with classes numbered from low to high. Read the numerical boundaries from the map legend.

``` r
class_counts <- table(cut(randomNumbers, breaks = map$breaks,
                          include.lowest = TRUE))
barplot(class_counts, col = myColours, names.arg = 1:10,
        xlab = "Map class (low to high)", ylab = "Number of country features",
        main = "Equal-width classes")
```

![Bar chart counts country features in each equal-width map class, with the largest counts in the middle classes.]({{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-5-1.png)

## Plot with equal count breaks
In the above map, some colors appear more often than others. If we want every color to appear about the same number of times, we can change the `breakby` parameter to get equal count breaks.


``` r
map <- plot(world, values = randomNumbers, breaks = 10, col = myColours, breakby = "cases")
```

![World map of the same simulated values using equal-count classes; numeric class widths vary to include similar numbers of countries.]({{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-6-1.png)

The frequency of observations within each color class is now about the same.

The two classifications answer different display questions. Equal-width classes divide the numerical range into the same-sized intervals, so the simulated values are concentrated in the middle classes. Equal-count classes vary their numerical widths to place similar numbers of country features in each class. This does not equalize the geographic area of the colors on the map. Read the numerical legend and the class-count bar charts together; color alone does not convey the class boundaries.


``` r
class_counts <- table(cut(randomNumbers, breaks = map$breaks,
                          include.lowest = TRUE))
barplot(class_counts, col = myColours, names.arg = 1:10,
        xlab = "Map class (low to high)", ylab = "Number of country features",
        main = "Equal-count classes")
```

![Equal-width bars represent the ten equal-count map classes; their similar heights show similar numbers of country features, although the numerical class intervals differ.]({{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-7-1.png)

The bars have equal width because they represent classes, not distances along the numerical scale. A frequency histogram with unequal numerical bin widths would give misleading areas; the [R histogram documentation](https://stat.ethz.ch/R-manual/R-devel/library/graphics/html/hist.html) explains when density rather than counts is needed.

## Compare the maps

Find one country feature whose color changes between the maps. Its simulated value has not changed: the class boundaries have. Explain how equal-width and equal-count classification change what stands out, and why similar class counts do not mean similar colored areas on the map.

## Save information in map

Exporting a geographic file is not needed for this color exercise. Keep your R Markdown code and figures so that the simulated values, class boundaries and palette can be reproduced together.
