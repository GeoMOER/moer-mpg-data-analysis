# Unit 05 Linear Regression Illustration
# Data Analysis (T. Nauss, C. Reudenbach)
# Images for slides
# 
# The code used for this visualization has been posted by Todos Logos on 
# Rbloggers
# https://www.r-bloggers.com/how-to-plot-points-regression-line-and-residuals/

independentendent <- anscombe$x1
dependent <- anscombe$y1

lmod <- lm(dependent ~ independentendent)

png("linear_regression.png", width = 960, height = 960, pointsize = 24)

plot(independentendent, dependent, xlim=c(min(independentendent)-1, max(independentendent)+1), ylim=c(min(dependent)-1, max(dependent)+1),
     xlab = "independent", ylab = "dependent")
abline(lmod, lwd=2, col = "blue")

res <- round(residuals(lmod), 2)
pre <- predict(lmod) 
segments(independentendent, dependent, independentendent, pre, col="red", lwd = 2)

# Label signed residuals; place the rightmost labels to the left to avoid clipping.
text(independentendent, dependent, res,
     pos = ifelse(independentendent > 12, 2, 4), cex = 0.65)
text(11, 4, paste("Fitted y =", round(coef(lmod)[1], 3),
                  "+", round(coef(lmod)[2], 3), "* x"), cex = 0.8)

# dev.copy(jpeg, file.path(dirname(rstudioapi::getActiveDocumentContext()$path),
#                          "linear_regression.jpg"), quality = 100)
dev.off()
