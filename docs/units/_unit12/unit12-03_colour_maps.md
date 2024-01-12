---
title: "Example: Colours and maps"
toc: true
toc_label: In this example
header:
  image: "/assets/images/teaser/unnamed-chunk-8-1.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

This is a short example on how to use the hcl colour palette for colouring features of a shapefile.


## Load the required packages
```r
library("terra")
library("classInt")
```

## Always clean the workspace first
```r
rm(list=ls())
```

## Get helper functions (those from the previous page)
```r
clrs_hcl2 <- function(n) {
  hcl(h = seq(0, 260, length.out = n), 
      c = 60, l = seq(10, 90, length.out = n), 
      fixup = TRUE)
}

pal <- function(col, border = "transparent", ...) {
  n <- length(col)
  plot(0, 0, type="n", xlim = c(0, 1), ylim = c(0, 1),
       axes = FALSE, xlab = "", ylab = "", ...)
  rect(0:(n-1)/n, 0, 1:n/n, 1, col = col, border = border)
}

# If you want to reverse the colour palette, do it like this
pal(rev(clrs_hcl2(10)))
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

## World map as an example
Download the data [here](https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip){:target="_blank"} or directly from within R.

```r
download.file("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip", 
              destfile = "countries.zip")
```
[NaturalEarthData](https://www.naturalearthdata.com/){:target="_blank"} has a nice collection of other free GIS data, too.


## Example script for plotting with random colours
```r
## Read in shapefile
world <- terra::vect("countries/ne_50m_admin_0_countries.shp")

## Do the reality check and plot the map
plot(world)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

```r
## Let's generate some random values for each feature for plotting later
## note that no seed is set here, so every call will result in a different result
world$random <- sample(1:100, nrow(world), replace = TRUE)

## Use new field with random values for colour plotting
plot(world, col = world$random)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-6-1.png" style="display: block; margin: auto;" />

## Example script for plotting with classified hcl colours
If we want to do classified plotting, i.e. assign a particular colour to each class, we need to classify our data first and then assign colours to each class.

```r
## Choose the number of desired classes
n <- 10

## Classify the randomly generated data (or any numeric attribute) with some method.
## In this case equaly spaces classed, i.e. all classed have equal widths.
## See ?classIntervals for more options.
intervalls <- classInt::classIntervals(world$random, n = n, style = "equal")

intervalls$brks # shows the calculated breaks

## Assign each class within the feature the a colour according to the previous classification.
## The colours are produced with the self-defined clrs_hcl2() function from above.
## Execute all parts of the code line below to see what they do and what they contain.
## Noteworthy, the values of the object "colours" are the colours definded in the hexadecimal
## system and there are as many entries as there are values in the original data
## (attribute "random" in this case). One colour for each value.
colours <- classInt::findColours(intervalls, rev(clrs_hcl2(n)), cutlabels = FALSE)

## Add the colour code to the attribute table of the spatial object
world$colours <- colours

## Use the new field with the colour code for plotting
plot(world, col = world$colours)
add_legend("left", legend = names(attr(colours, "table")), 
           fill = attr(colours, "palette"), 
           border = attr(world$colours, "palette"), 
           bty = "n", title = "Legend", cex = 0.45, y.intersp = 0.7)
```

<img src="{{ site.baseurl }}/assets/images/rmd_images/e12-03/unnamed-chunk-7-1.png" style="display: block; margin: auto;" />

Clearly, the above examples are not ready for publication but intended to demonstrate a schematic workflow for classifying and colouring maps, be it vector or raster.
