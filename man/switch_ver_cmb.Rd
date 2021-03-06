% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/guess.R
\name{switch_ver_cmb}
\alias{switch_ver_cmb}
\title{guess icd-9 or icd-10 or other type, and switch to call the given function}
\usage{
switch_ver_cmb(x, funs, ...)
}
\arguments{
\item{x}{data frame of patient data}

\item{funs}{named list of functions to call, with the names being at a
minimum 'icd9' and 'icd10', and 'icd9cm' or 'icd10cm' being used first if
provided.}

\item{...}{further arguments, perhaps including \code{icd_name}}
}
\description{
guess icd-9 or icd-10 or other type, and switch to call the given function
}
\keyword{internal}
