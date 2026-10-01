#' California Zero-Emission Vehicle (ZEV) Registrations, by County
#'
#' New ZEV registration counts from the California Energy Commission, at the
#' county level, as used in the "3-electric-vehicles" (ZEV) project. This is
#' the \code{"County"} sheet of
#' \code{New_ZEV_Sales_Last_updated_07-17-2026_ada.xlsx}, loaded here as an R
#' object so it is available in the PrairieLearn RStudio workspace via
#' \code{data(ev)} without needing \code{readxl}, a file path, or internet
#' access during the quiz.
#'
#' Column names are left exactly as in the source spreadsheet, including
#' spaces (e.g. \code{`Data Year`}, \code{`Number of Vehicles`}), so
#' backtick-quoting practice from the project still applies. Each row is a
#' count for a unique Year x Quarter x County x Fuel Type x Make x Model
#' combination; \code{`Number of Vehicles`} must be summed, not counted, to
#' get totals.
#'
#' @format A data frame with 77,898 rows and 7 variables:
#' \describe{
#'   \item{`Data Year`}{Numeric. Calendar year.}
#'   \item{Quarter}{Numeric. Quarter of the year (1-4).}
#'   \item{COUNTY}{Character. California county name, or "Out Of State".}
#'   \item{FUEL_TYPE}{Character. One of "Electric", "PHEV", "Hydrogen".}
#'   \item{MAKE}{Character. Vehicle manufacturer.}
#'   \item{MODEL}{Character. Vehicle model.}
#'   \item{`Number of Vehicles`}{Numeric. Count of new registrations for that combination.}
#' }
#' @source California Energy Commission, \code{New_ZEV_Sales_Last_updated_07-17-2026_ada.xlsx},
#'   sheet "County".
"ev"
