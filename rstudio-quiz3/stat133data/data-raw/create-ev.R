# Regenerates data/ev.rda from the "County" sheet of the ZEV project's source
# spreadsheet. Run from the package root: Rscript data-raw/create-ev.R

library(readxl)

ev <- read_excel(
  "../../../../../fall-2026-private/projects/3-electric-vehicles/data/New_ZEV_Sales_Last_updated_07-17-2026_ada.xlsx",
  sheet = "County"
)
ev <- as.data.frame(ev)

stopifnot(
  nrow(ev) == 77898,
  all(names(ev) == c("Data Year", "Quarter", "COUNTY", "FUEL_TYPE", "MAKE", "MODEL",
                      "Number of Vehicles"))
)

dir.create("data", showWarnings = FALSE)
save(ev, file = "data/ev.rda", compress = "xz")
