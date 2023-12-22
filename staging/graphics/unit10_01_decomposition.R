m <- decompose(co2)

# dev.copy(jpeg, file.path(dirname(rstudioapi::getActiveDocumentContext()$path),
#                          "time_series_decomposition.jpg"), quality = 100)

png("time_series_decomposition.png", width = 960, height = 960, pointsize = 24)
plot(m)
dev.off()
