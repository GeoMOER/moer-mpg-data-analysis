# Source: Destatis, land-use survey 2024, worksheet csv-33111-03.
# See destatis-land-use-2024-source.txt and the bilingual dictionary.
# From the project folder: Rscript Data/prepare-land-use-2024.R Data
# Creates Data/destatis-land-use-2024-states.rds from the teaching CSV.

prepare_land_use <- function(data_dir = "Data") {
  raw <- read.csv2(file.path(data_dir, "destatis-land-use-2024.csv"),
                   colClasses = "character", na.strings = "",
                   fileEncoding = "UTF-8", check.names = FALSE)
  columns <- c(
    Year = "Bezugszeitraum",
    ID = "Schluesselnummer_Land",
    Place = "Regionale_Gliederung",
    Area_ha = "Bodenflaeche_insgesamt_in_Hektar",
    Settlement = "Anteil_der_Flaeche_fuer_Siedlung_in_Prozent_10000000",
    Transport = "Anteil_der_Flaeche_fuer_Verkehr_in_Prozent_20000000",
    Vegetation = "Anteil_der_Flaeche_fuer_Vegetation_in_Prozent_30000000",
    Agriculture = "Anteil_der_Flaeche_fuer_Landwirtschaft_in_Prozent_31000000",
    Forest = "Anteil_der_Flaeche_fuer_Wald_in_Prozent_32000000",
    Water = "Anteil_der_Flaeche_fuer_Gewaesser_in_Prozent_40000000"
  )
  stopifnot(nrow(raw) == 17L, ncol(raw) == 64L,
            all(unname(columns) %in% names(raw)))
  land_use <- raw[unname(columns)]
  names(land_use) <- names(columns)
  numeric_columns <- setdiff(names(land_use), c("ID", "Place"))
  land_use[numeric_columns] <- type.convert(
    land_use[numeric_columns], dec = ",", as.is = TRUE
  )
  stopifnot(all(vapply(land_use[numeric_columns], is.numeric, logical(1))),
            all(land_use$Year == 2024), !anyNA(land_use$ID))
  states <- land_use[land_use$ID != "0", ]
  rownames(states) <- NULL
  stopifnot(nrow(states) == 16L, !anyDuplicated(states$ID),
            setequal(states$ID, sprintf("%02d", 1:16)))
  percentages <- states[c("Settlement", "Transport", "Vegetation",
                          "Agriculture", "Forest", "Water")]
  stopifnot(!anyNA(percentages),
            all(as.matrix(percentages) >= 0 & as.matrix(percentages) <= 100))
  saveRDS(states, file.path(data_dir, "destatis-land-use-2024-states.rds"),
          version = 2)
  invisible(states)
}

if (sys.nframe() == 0L) {
  args <- commandArgs(trailingOnly = TRUE)
  prepare_land_use(if (length(args)) args[1] else "Data")
}
