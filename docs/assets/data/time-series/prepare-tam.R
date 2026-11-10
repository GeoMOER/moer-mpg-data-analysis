# Reproduce the calendar-preserving monthly temperature checkpoint.
# Rscript --vanilla prepare-tam.R [temperature-ZIP] [tam-output]
prepare_tam <- function(archive, output = 'tam.txt') {
  product <- grep('^produkt_tu_stunde_.*_03164\\.txt$',
                  unzip(archive, list = TRUE)$Name, value = TRUE)
  stopifnot(length(product) == 1)
  raw <- read.table(unz(archive, product), header = TRUE, sep = ';')
  raw$DATUM <- as.POSIXct(as.character(raw$MESS_DATUM), format = '%Y%m%d%H', tz = 'UTC')
  stopifnot(!anyNA(raw$DATUM), !anyDuplicated(raw$DATUM))
  calendar <- data.frame(DATUM = seq(as.POSIXct('2006-07-01', tz = 'UTC'),
    as.POSIXct('2022-12-31 23:00:00', tz = 'UTC'), by = 'hour'))
  dwd <- merge(calendar, raw, by = 'DATUM', all.x = TRUE, sort = TRUE)
  dwd$TT_TU[dwd$TT_TU == -999 & !is.na(dwd$TT_TU)] <- NA_real_
  month <- format(dwd$DATUM, '%Y%m', tz = 'UTC')
  tam <- aggregate(dwd$TT_TU, by = list(Date = month), FUN = mean)
  names(tam)[2] <- 'Ta'
  # mean() deliberately returns NA if any expected hourly temperature is missing.
  stopifnot(nrow(tam) == 198, !anyDuplicated(tam$Date))
  write.table(tam, output, sep = ';', row.names = FALSE, na = 'NA')
  invisible(tam)
}
if (sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  archive <- if (length(args)) args[1] else 'stundenwerte_TU_03164_20060701_20251231_hist.zip'
  output <- if (length(args) >= 2) args[2] else 'tam.txt'
  prepare_tam(archive, output)
}
