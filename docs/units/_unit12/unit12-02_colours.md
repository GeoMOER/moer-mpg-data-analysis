---
toc: TRUE
title: "Example: Colors"
header:
  image: "/assets/images/teaser/unnamed-chunk-8-1.png"
  caption: 'Image: [**Environmental Informatics Marburg**](https://www.uni-marburg.de/en/fb19/disciplines/physisch/environmentalinformatics)'
---

Choose colors according to **what the variable means**. Start with these three cases:

| Data | Palette type | Example |
|---|---|---|
| Categories without an order | **Qualitative:** distinct colors without a low-to-high sequence. | Different land-use types. |
| Values ordered from low to high | **Sequential:** a clear progression in lightness. | Recreation share from small to large. |
| Values on either side of a meaningful reference | **Diverging:** two directions from a central color. | Temperature difference below or above zero. |

The base R function `hcl.colors(n, palette = ...)` supplies ready-made palettes: `n` is the number of colors. You do not need an additional package or a custom palette function. The following strips use equal-height bars only to display the colors; their heights are not data.


``` r
old_par <- par(no.readonly = TRUE)
par(mfrow = c(3, 1), mar = c(2, 1, 2, 1))
barplot(rep(1, 4), col = hcl.colors(4, "Dark 3"),
        names.arg = c("A", "B", "C", "D"), axes = FALSE,
        border = NA, main = "Qualitative: categories")
barplot(rep(1, 7), col = hcl.colors(7, "YlGnBu", rev = TRUE),
        names.arg = 1:7, axes = FALSE,
        border = NA, main = "Sequential: low to high")
barplot(rep(1, 7), col = hcl.colors(7, "Blue-Red 3"),
        names.arg = -3:3, axes = FALSE,
        border = NA, main = "Diverging: around zero")
```

![Three palette strips: Dark 3 distinguishes categories, YlGnBu runs from light to dark for increasing values, and Blue-Red 3 has a light center between blue and red extremes.]({{ site.baseurl }}/assets/images/rmd_images/e11-02/palette-types-1.png)

``` r
par(old_par)
```

Use `rev = TRUE` to reverse a palette when needed. Match its direction to the numerical legend. A diverging palette is useful only when its center has a meaning in your data; a light midpoint alone does not make it appropriate for ordered values.

## Why avoid a rainbow for ordered values?

The rainbow's lightness rises and falls. Equal numerical changes can look very different depending on their position, and apparent boundaries can draw attention away from the actual pattern. Compare it with a sequential palette:


``` r
old_par <- par(no.readonly = TRUE)
par(mfrow = c(2, 1), mar = c(2, 1, 2, 1))
barplot(rep(1, 10), col = rainbow(10), names.arg = 1:10,
        axes = FALSE, border = NA, main = "Rainbow")
barplot(rep(1, 10), col = hcl.colors(10, "YlGnBu", rev = TRUE),
        names.arg = 1:10, axes = FALSE, border = NA,
        main = "Sequential: low to high")
```

![Rainbow colors have uneven apparent transitions; the sequential YlGnBu strip progresses from pale yellow to dark blue.]({{ site.baseurl }}/assets/images/rmd_images/e11-02/ordered-palettes-1.png)

``` r
par(old_par)
```

HCL-based palettes aim to make color differences easier to interpret, but **HCL does not guarantee perfect perceptual uniformity or accessibility**. A constant-lightness palette can become nearly indistinguishable in grayscale. Conversely, a smooth grayscale ramp does not prove that all viewers can distinguish the colors. Choose a palette suited to the data, inspect the result and use labels, symbols or line types alongside color. The [R palette documentation](https://stat.ethz.ch/R-manual/R-devel/library/grDevices/html/palettes.html) describes the available palette types.

## Try it on a familiar figure

Take a plot from an earlier unit. Decide whether its colors represent categories, ordered values or deviations from a reference. Choose one palette, then check that the legend and labels let a reader recover that meaning. Keep units visible and explain your choice in one sentence. The next page applies this choice to map classes.
