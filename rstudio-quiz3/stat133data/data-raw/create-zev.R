# Regenerates data/zev.rda from the "County" sheet of the ZEV project's source
# spreadsheet. Run from the package root: Rscript data-raw/create-zev.R

library(readxl)

zev <- read_excel(
  "../../../../../fall-2026-private/projects/3-electric-vehicles/data/New_ZEV_Sales_Last_updated_07-17-2026_ada.xlsx",
  sheet = "County"
)
zev <- as.data.frame(zev)

stopifnot(
  nrow(zev) == 77898,
  all(names(zev) == c("Data Year", "Quarter", "COUNTY", "FUEL_TYPE", "MAKE", "MODEL",
                       "Number of Vehicles"))
)

dir.create("data", showWarnings = FALSE)
save(zev, file = "data/zev.rda", compress = "xz")
