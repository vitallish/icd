#!/bin/bash

# Copyright (C) 2014 - 2015  Jack O. Wasey
#
# This file is part of icd9.
#
# icd9 is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# icd9 is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with icd9. If not, see <http:#www.gnu.org/licenses/>.

# build_and_test_icd9 with R-devel and clang 3.7 with sanitizers, libc (and libomp)
# This file is run within the container.

ICD9_GIT_BRANCH=issue75

cd /tmp
git clone -b $ICD9_GIT_BRANCH https://github.com/jackwasey/icd9.git
R CMD build --no-build-vignettes icd9
ICD9_PKG=`ls -t /tmp/icd9*tar.gz | tail -1`
R CMD INSTALL $ICD9_PKG || cat /tmp/icd9.Rcheck/00check.log
R CMD check $ICD9_PKG
# potentially just do testthat tests and run examples instead of full package check?
