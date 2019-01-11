# 08-01
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Images for slides
# 

library(mgcv)
y <- anscombe$y2
x1 <- anscombe$x1

set.seed(2)
x3 <- anscombe$x3 + sample(seq(-1, 1, 0.1), nrow(anscombe))

y <- c(anscombe$y1, anscombe$y2)
x <- c(x1, x3)
df <- data.frame(y = y, x = x)

gammod <- gam(y ~ x, data = df, familiy = gaussian())


knots <- seq(1, 19)

palette <- colorRampPalette(colors=c("blue", "green", "red"))
cols <- palette(length(knots))

dev.copy(jpeg, file.path(dirname(rstudioapi::getActiveDocumentContext()$path),
                         "gam.jpg"), quality = 100)

plot(df$x, df$y)

for(i in seq(length(knots))){
  gammod <- gam(y ~ s(x, k = knots[i], fx = TRUE), data = df)
  px <- seq(min(df$x), max(df$x), 0.1)
  gampred <- predict(gammod, list(x = px))
  lines(px, gampred, col = cols[i], lty=2)
}

#legend(13, 7.5, paste("knots", knots, sep = " "), col = cols, lty=2, cex=0.5)

dev.off()


