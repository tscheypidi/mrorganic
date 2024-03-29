% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/readSpawn.R
\name{readSpawn}
\alias{readSpawn}
\title{Read Spawn}
\usage{
readSpawn(subtype)
}
\arguments{
\item{subtype}{Subtype to be read in. Available types are
"abovegroundBiomass", "abovegroundBiomassUncertainty",
"belowgroundBiomass" and "belowgroundBiomassUncertainty".}
}
\value{
data
}
\description{
Read Spawn data
}
\examples{
\dontrun{
a <- readSource("Spawn", "abovegroundBiomass")
}
}
\seealso{
\code{\link{readSource}}
}
\author{
Jan Philipp Dietrich
}
