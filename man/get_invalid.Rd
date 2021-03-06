% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/valid.R, R/z-deprecated.R
\name{get_invalid}
\alias{get_invalid}
\alias{get_invalid.default}
\alias{get_invalid.icd9}
\alias{get_invalid.icd10}
\alias{get_invalid.comorbidity_map}
\alias{icd_get_invalid.comorbidity_map}
\alias{icd_get_invalid.icd9}
\alias{icd_get_invalid.icd_comorbidity_map}
\alias{icd_get_valid.icd9}
\title{Get invalid ICD codes}
\usage{
get_invalid(...)

\method{get_invalid}{default}(x, short_code = guess_short(x), ...)

\method{get_invalid}{icd9}(x, short_code = guess_short(x), ...)

\method{get_invalid}{icd10}(x, short_code = guess_short(x), ...)

\method{get_invalid}{comorbidity_map}(x, short_code = guess_short(x),
  ...)

icd_get_invalid.comorbidity_map(...)

icd_get_invalid.icd9(...)

icd_get_invalid.icd_comorbidity_map(...)

icd_get_valid.icd9(...)
}
\arguments{
\item{x}{vector of ICD codes, or list of vectors of ICD codes forming a
comorbidity map}
}
\description{
Returns subset of codes which are not in valid short_code or
  decimal format.
}
\section{Methods (by class)}{
\itemize{
\item \code{default}: Default method when ICD version or short versus
decimal not known.

\item \code{icd9}: Get invalid ICD-9 codes from vector of codes

\item \code{icd10}: Get invalid ICD-10 codes from vector of codes

\item \code{comorbidity_map}: Get invalid elements of a comorbidity map
}}

\section{Deprecated function names}{
 Future versions of \pkg{icd} will drop
  the \code{icd_} prefix. For example, \code{charlson} should be used in
  favor of \code{icd_charlson}. To distinguish \pkg{icd} function calls,
  consider using the prefix \code{icd::} instead, e.g., \code{icd::charlson}.
  Functions which specifically operate on either ICD-9 or ICD-10 codes or
  their sub-types will retain the prefix. E.g.
  \code{\link{icd9_comorbid_ahrq}}. \pkg{icd} specific classes also retain
  the prefix, e.g., \code{\link{icd_wide_data}}.
}

\keyword{internal}
