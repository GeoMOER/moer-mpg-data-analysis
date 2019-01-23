m <- decompose(co2)

dev.copy(jpeg, file.path(dirname(rstudioapi::getActiveDocumentContext()$path),
                         "time_series_decomposition.jpg"), quality = 100)
plot(m)


dev.off()
