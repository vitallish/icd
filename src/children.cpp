// Copyright (C) 2014 - 2018  Jack O. Wasey
//
// This file is part of icd.
//
// icd is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// icd is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with icd. If not, see <http://www.gnu.org/licenses/>.

#include "icd_types.h"                   // for CV, VecStr
#include <iterator>                      // for advance
#include <vector>                        // for vector

// [[Rcpp::export(icd10cm_children_defined_cpp)]]
CV icd10cmChildrenDefined(CV &x, Rcpp::List icd10cm2016, Rcpp::IntegerVector nc) {
  CV allCodes = icd10cm2016["code"];
  Rcpp::IntegerVector matchesNa = Rcpp::match(x, allCodes);
  Rcpp::IntegerVector matches = matchesNa[!is_na(matchesNa)]; // 1-based index (R style)
  VecStr kids;
  if (matches.length() == 0) {
    if (x.length() > 0) {
      Rcpp::warning("None of the provided ICD-10 codes matched the master ICD-10-CM list (currently 2016)");
    }
    return(CV(0));
  }
  kids.reserve(x.length() * 10);
  CV tmp = icd10cm2016[0];
  int last_row = tmp.length(); // zero-based index
  int check_row; // zero-based index
  int parent_len; // number of characters in original parent code
  for (int i = 0; i != matches.length(); ++i) {
    check_row = matches[i] + 1 - 1; // check the row after the parent (may be off end of vector)
    parent_len = nc[matches[i] - 1];
    while (check_row < last_row && nc[check_row] > parent_len)
      ++check_row;

    CV::iterator it = allCodes.begin();
    std::advance(it, matches[i] - 1);
    CV::iterator it2 = allCodes.begin();
    std::advance(it2, check_row);
    kids.insert(kids.end(), it, it2);
  }
  return Rcpp::wrap(kids);
}
