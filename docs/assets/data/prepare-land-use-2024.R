# Source: Destatis, land-use survey 2024, worksheet csv-33111-03.
# English teaching CSV; see the source notes and column crosswalk.
# From the project folder: Rscript Data/prepare-land-use-2024.R Data
# Creates Data/destatis-land-use-2024-states.rds from the teaching CSV.

prepare_land_use <- function(data_dir = "Data") {
  raw <- read.csv2(file.path(data_dir, "destatis-land-use-2024.csv"),
                   colClasses = "character", na.strings = "",
                   fileEncoding = "UTF-8", check.names = FALSE)
  columns <- c(
    Year = "Reference_year",
    ID = "State_ID",
    Place = "State_name",
    Area_ha = "Total_area_ha",
    Settlement = "Settlement_pct_10000000",
    Transport = "Transport_pct_20000000",
    Vegetation = "Vegetation_pct_30000000",
    Agriculture = "Agriculture_pct_31000000",
    Forest = "Forest_pct_32000000",
    Water = "Water_pct_40000000"
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
