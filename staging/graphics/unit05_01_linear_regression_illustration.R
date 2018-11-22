# Unit 05 Linear Regression Illustration
# Data Analysis (T. Nauss, C. Reudenbach)
# Images for slides
# 
# The code used for this visualization has been posted by Todos Logos on 
# Rbloggers
# https://www.r-bloggers.com/how-to-plot-points-regression-line-and-residuals/

library(calibrate)

independentendent <- anscombe$x1
dependent <- anscombe$y1

lmod <- lm(dependent ~ independentendent)

plot(independentendent, dependent, xlim=c(min(independentendent)-1, max(independentendent)+1), ylim=c(min(dependent)-1, max(dependent)+1))
abline(lmod, lwd=2, col = "blue")

res <- signif(residuals(lmod), 5)
pre <- predict(lmod) 
segments(independentendent, dependent, independentendent, pre, col="red", lwd = 2)

textxy(independentendent, dependent, res, cex=0.75)
textxy(10, 4, 
       bquote(paste("y"["i"], " = ", .(round(lmod$coefficients[1], 3)), 
                    " + ", .(round(lmod$coefficients[2], 3)), "* x"["i"])),
       cex=1)

dev.copy(jpeg, file.path(dirname(rstudioapi::getActiveDocumentContext()$path),
                         "linear_regression.jpg"), quality = 100)
dev.off()
