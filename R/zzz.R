# Copyright (C) 2014 - 2018  Jack O. Wasey
#
# This file is part of icd.
#
# icd is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# icd is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with icd. If not, see <http:#www.gnu.org/licenses/>.

# nocov start

.onAttach <- function(libname, pkgname) {
  if (system.file(package = "icd9") != "")
    packageStartupMessage(paste(
      "The 'icd9' package is now deprecated, and should be removed to avoid",
      "conflicts with 'icd'. The 'icd' package up to version 2.1 contains",
      "tested versions of all the deprecated function names which overlap with",
      "those in the old 'icd9' package, e.g. 'icd9ComorbidAhrq'. It is",
      "strongly recommended to run the command: remove.packages(\"icd9\")"))
}

.onUnload <- function(libpath) {
  library.dynam.unload("icd", libpath)
}

release_questions <- function() {
  c(
    # commands:
    "update_everything(), then copy data to icd.data package",
    "aspell_package_Rd_files('.')",
    "tools/package-registration.r",
    # documentation:
    "Check all TODO comments, make into github issues",
    "Do all examples look ok (not just run without errors)?",
    "Have all the fixed github issues been closed",
    "Does every file have correct licence information?",
    # code quality:
    "Is every SEXP PROTECT()ed and UNPROTECT()ed, when appropriate?",
    "Are all public S3 classes all exported? use devtools::missing_s3()",
    "use LLVM static scan build, scan-build before compiler in .R/Makevars",
    # testing and compilation and different platforms:
    "Have you run tests in tests-deprecated and tests-build-code?",
    "Are there no skipped tests which should be run?",
    "Does it compile, test and check fine on travis and appveyor?",
    "Have you checked on Windows, win_builder,
      Mac, Ubuntu, UBSAN rocker, and updated my docker image which
      resembles a CRAN maintainers environment?",
    # final manual check:
    "Are all NOTES from R CMD check documented in cran-comments.md",
    "Have all unnecessary files been ignored in built archive?")
}
# nocov end
