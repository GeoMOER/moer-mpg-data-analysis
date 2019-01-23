if(Sys.info()["sysname"] == "Windows"){
  filepath_base <- "D:/active/moc/msc-phygeo-data-analysis/"
} else {
  filepath_base <- "/media/permanent/active/moc/msc-phygeo-data-analysis/"
}

path_data <- paste0(filepath_base, "data/")
path_dwd <- paste0(path_data, "dwd/3164_coelbe/")
path_rdata <- paste0(path_data, "rdata/")
path_temp <- paste0(filepath_base, "temp/")

library(forecast)

# dwd_ta <- read.table(paste0(path_dwd, "produkt_temp_Terminwerte_20060701_20151231_03164.txt"),
#                             header = TRUE, sep = ";", dec = ".")
# colnames(dwd_ta)[c(3,7)] <- paste0(colnames(dwd_ta)[c(3,7)], "_TARH")
# 
# dwd_rr <- read.table(paste0(path_dwd, "produkt_synop_Terminwerte_20060701_20151231_03164.txt"),
#                             header = TRUE, sep = ";", dec = ".")
# colnames(dwd_rr)[c(3,7)] <- paste0(colnames(dwd_rr)[c(3,7)], "_RR")
# 
# dwd <- merge(dwd_ta, dwd_rr, all.x = TRUE, all.y = TRUE)

dwd <- read.table(paste0(path_dwd, "produkt_temp_Terminwerte_20060701_20151231_03164.txt"),
                  header = TRUE, sep = ";", dec = ".")



dwd$DATUM <- strptime(paste0(dwd$MESS_DATUM, "00"), format = "%Y%m%d%H%M", tz = "UTC")

start <- strptime("201209010000", format = "%Y%m%d%H%M", tz = "UTC")
end <- strptime("201209302300", format = "%Y%m%d%H%M", tz = "UTC")

dwd_sub <- dwd[dwd$DATUM >= start & dwd$DATUM <= end,]

plot(dwd_sub$DATUM, 
     dwd_sub$LUFTTEMPERATUR, 
     xlab = "Time", ylab = "Air temperature, °C",
     type = "l", col = "red")

acf(dwd_sub$LUFTTEMPERATUR, main = "Air temperature, 2012-09-01 to 2012-09-30")
pacf(dwd_sub$LUFTTEMPERATUR, main = "Air temperature, 2012-09-01 to 2012-09-30")


dwd_agg <- aggregate(dwd$LUFTTEMPERATUR, by = list(substr(dwd$MESS_DATUM, 1, 6)), FUN = mean)
dwd_ts <- ts(dwd_agg$x, start = c(2006, 07), end = c(2015, 12), frequency = 12 )
arimamod <- auto.arima(dwd_ts)

plot(forecast(arimamod))
  
