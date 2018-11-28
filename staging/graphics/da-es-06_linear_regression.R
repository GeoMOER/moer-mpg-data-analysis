# da-06
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Images for slides
# 
# The code used for this visualization has been posted by Todos Logos on 
# Rbloggers
# https://www.r-bloggers.com/how-to-plot-points-regression-line-and-residuals/

library(calibrate)

independent <- anscombe$x1
dependent <- anscombe$y1

plot(independent, dependent)
for(i in seq(length(independent))){
  abline(lm(dependent[-i] ~ independent[-i]), col = "red")
}

dev.copy(jpeg, "cross_validation.jpg", quality = 100)
dev.off()
