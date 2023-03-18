#' Calculate Biomass by land type
#'
#' Estimate soil organic carbon content split by land type.
#'
#' @param subtype "aboveground" or "belowground"
#' @return data
#'
#' @author Jan Philipp Dietrich
#' @examples
#' \dontrun{
#' a <- calcOutput("BiomassbyLandType", subtype = "aboveground")
#' }
#' @seealso \code{\link{calcOutput}}

calcBiomassByLandType <- function(subtype) {

  name <- subtype

  subtype <- toolSubtypeSelect(subtype, c(aboveground = "abovegroundBiomass",
                                          belowground = "belowgroundBiomass"))

  terra::terraOptions(tempdir = withr::local_tempdir(tmpdir = getConfig("tmpfolder")), todisk = TRUE, memfrac = 0.5)
  withr::defer(terra::terraOptions(tempdir = tempdir()))

  message("Please be patient, this will take a while.")

  # read in biomass data
  biomass <- readSource("Spawn", subtype = subtype, convert = FALSE)
  weight  <- calcOutput("LandTypeAreas", categories = "CropGrassForestOthervegResidual", aggregate = FALSE) + 10^-10
  message("Relevant data read in.")

  out <- toolAggregateByLandType(biomass, weight)

  # set values to 0 for cells with negligible weight
  # doing so removes values for cells with missing land area for the
  # the given type and thereby make the computed data unrealiable
  out$x[round(out$weight, 6) == 0] <- 0

  return(list(x = out$x,
              weight = out$weight,
              description = paste("Average", name, "biomass content by land type"),
              unit = "Mg C ha-1",
              min = 0,
              structure.spatial = "-?[0-9]*p[0-9]*\\.-?[0-9]*p[0-9]*\\.[A-Z]{3}",
              structure.data = "(cropland|grassland|other)",
              isocountries = FALSE))
}