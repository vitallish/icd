% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class.R
\name{icd_classes_conflict}
\alias{icd_classes_conflict}
\title{Check whether there are any ICD class conflicts}
\usage{
icd_classes_conflict(x)
}
\arguments{
\item{x}{input object to test for class conflicts}
}
\description{
Some classes cannot be simultaneously true for one vector of ICD codes, e.g.
ICD-9-CM and ICD-9 from the WHO. This function returns \code{TRUE} if there
are any such combinations of incompatible classes. If the constructor
functions such as \code{icd9cm()} and \code{icd10()} are used, this should
never happen.
}
\examples{
bad_codes <- c("100", "A01", "V100", "E999.0")
class(bad_codes) <- c("icd9", "icd10cm")
stopifnot(icd:::icd_classes_conflict(bad_codes))
}
\keyword{internal}
