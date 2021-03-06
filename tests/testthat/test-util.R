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

context("util")

test_that("trim with empty inputs", {
  expect_equal(trim(character(0)), character(0))
  expect_equal(trim(""), "")
})

test_that("trim with acceptable inputs", {
  expect_equal(trim(NA_character_), NA_character_)
  # not necesarily desirable, but this states the expectation.
  expect_equal(trim(NA_integer_), NA_character_)
  expect_equal(trim("jack"), "jack")
  expect_equal(trim("jack "), "jack")
  expect_equal(trim(" jack "), "jack")
  expect_equal(trim(" jack"), "jack")
  expect_equal(trim("jack\t"), "jack")
  expect_equal(trim("\tjack\t"), "jack")
  expect_equal(trim("\tjack"), "jack")
  expect_equal(trim("ja ck"), "ja ck")
  expect_equal(trim("ja ck "), "ja ck")
  expect_equal(trim(" ja ck "), "ja ck")
  expect_equal(trim(" ja ck"), "ja ck")

  expect_equal(trim(c(" ja ck\t", "hayley ")),
               c("ja ck", "hayley"))

  # trim and trimCpp should do the same thing, for non-NA
  expect_identical(trim(c("123", " a s d f ")),
                   trimCpp(c("123", " a s d f ")))

  # strim (trim a single string)
  expect_equal(strim(NA_integer_), NA_character_)
  expect_equal(strim(NA_character_), NA_character_)
  expect_equal(strim("jack"), "jack")
  expect_equal(strim("jack "), "jack")
  expect_equal(strim(" jack "), "jack")
  expect_equal(strim(" jack"), "jack")
  expect_equal(strim("jack\t"), "jack")
  expect_equal(strim("\tjack\t"), "jack")
  expect_equal(strim("\tjack"), "jack")
  expect_equal(strim("ja ck"), "ja ck")
  expect_equal(strim("ja ck "), "ja ck")
  expect_equal(strim(" ja ck "), "ja ck")
  expect_equal(strim(" ja ck"), "ja ck")
  # is this what I want?
  expect_error(strim(c("jack", " an other ")))
  # strim and strimCpp should do the same thing, for non-NA input
  expect_identical(strim(" a s d f "), strimCpp(" a s d f "))

})

test_that("get visit name from a matrix should fail", {
  expect_error(get_visit_name(matrix(c(1, 2, 3, 4), nrow = 2)))
})

test_that("string pair match extraction", {
  expect_error(str_pair_match())
  expect_error(str_pair_match(pattern = "(abc)def(ghi)"))
  expect_error(str_pair_match(string = "bougie"))
  expect_error(str_pair_match(pattern = c("(a)b(c)", "(d)e(f)"),
                              string = "abc"))
  expect_error(str_pair_match(pattern = c("(a)b(c)", "(d)e(f)"),
                              string = c("abc", "def")))

  expect_error(str_pair_match(pattern = "[", string = "abc")) # invalid regex
  # only one parenthesis
  expect_error(str_pair_match(pattern = "(a).*", string = "abc"))
  expect_error(str_pair_match(pattern = ".*(j)", string = "abc"))
  expect_equal(str_pair_match(pattern = "(a*)b(c*)", string = "abc"), c(a = "c"))
  expect_equal(str_pair_match(pattern = "([^mackarel]*)(spain)",
                              string = "togospain"),
               c(togo = "spain"))
  expect_equal(str_pair_match(pattern = "([^mackarel]*)(spain)",
                              string = c("togospain", "djiboutispain")),
               c(togo = "spain", djibouti = "spain"))
  expect_equal(str_pair_match(pattern = "(a*)b(c*)", string = c("abc", "aabcc")),
               c(a = "c", aa = "cc"))
})

test_that("str_pair_match error if more than two outputs", {
  expect_error(str_pair_match(string = "hadoop", pattern = "(ha)(do)(op)"))
  # no error if explicit
  str_pair_match(string = "hadoop", pattern = "(ha)(do)(op)", pos = c(1, 2))
})

test_that("logical to binary for a matrix works", {
  expect_identical(logical_to_binary(matrix(c(T, F, T, F), nrow = 2)),
                   matrix(c(1L, 0L, 1L, 0L), nrow = 2))
})

test_that("chapter to desc range works for icd9", {
  expect_identical(chapter_to_desc_range.icd9("jack (110-120)"),
                   list(Jack = c(start = "110", end = "120"))
  )
  expect_identical(chapter_to_desc_range.icd9("jack (V10-V20)"),
                   list(Jack = c(start = "V10", end = "V20"))
  )
  expect_identical(chapter_to_desc_range.icd9("jack (E990-E991)"),
                   list(Jack = c(start = "E990", end = "E991"))
  )
  expect_identical(chapter_to_desc_range.icd9("jack (110)"),
                   list(Jack = c(start = "110", end = "110"))
  )
  expect_identical(chapter_to_desc_range.icd9("jack (V10)"),
                   list(Jack = c(start = "V10", end = "V10"))
  )
  expect_identical(chapter_to_desc_range.icd9("jack (E990)"),
                   list(Jack = c(start = "E990", end = "E990"))
  )
})

test_that("chapter to desc range works for icd10", {
  expect_identical(chapter_to_desc_range.icd10("jack (A10-A20)"),
                   list(Jack = c(start = "A10", end = "A20"))
  )
  expect_identical(chapter_to_desc_range.icd10("jack (V10-V20)"),
                   list(Jack = c(start = "V10", end = "V20"))
  )
  expect_identical(chapter_to_desc_range.icd10("jack (E99)"),
                   list(Jack = c(start = "E99", end = "E99"))
  )
})

test_that("title case works", {
  expect_identical(to_title_case("jack"), "Jack")
  expect_identical(to_title_case("jack wasey"), "Jack Wasey")
  expect_identical(to_title_case("a [HIV] b"), "A [HIV] B")
  expect_identical(to_title_case("Arthropod-borne Viral Fevers And Viral Hemorrhagic Fevers"),
                   "Arthropod-Borne Viral Fevers And Viral Hemorrhagic Fevers")
  expect_identical(to_title_case("ill-defined"), "Ill-Defined")
  expect_identical(to_title_case("body mass index [bmi]"), "Body Mass Index [Bmi]")
  expect_identical(to_title_case("body mass index [BMI]"), "Body Mass Index [BMI]")
})

context("heuristics for determining the field names of an input data frame")

test_that("well structured data frame, ICD & visit guessed", {
  expect_equal(get_visit_name(simple_poa_pts), "visit_id")
  expect_equal(get_icd_name(simple_poa_pts), "code")
  expect_equal(get_visit_name(complex_poa_pts), "visit_id")
  expect_equal(get_icd_name(complex_poa_pts), "icd9")
  expect_equal(get_visit_name(test_twenty), "visit_id")
  expect_equal(get_icd_name(test_twenty), "icd9Code")
})

test_that("ambiguous icd_name gives warning", {
  two_code_pt <-  data.frame(
    visit_id = "V111111",
    icd9 = "441",
    icd10 = "A11",
    poa = "N"
  )
  expect_warning(get_icd_name(two_code_pt))
})

test_that("icd name heuristic works for various", {
  guesses <- c("icd.?(9|10)", "icd.?(9|10).?Code", "icd",
               "diagnos", "diag.?code", "diag", "i(9|10)", "code")
  x <- simple_pts
  for (n in c("icd-10", "icd9", "diag", "diag1", "DIAGCODE", "i9code", "code", "diagnosis")) {
    names(x)[2] <- n
    expect_equal(get_icd_name(x), n)
  }
})

test_that("error if an unnamed data frame is used to guess field", {
  x <- unname(simple_pts)
  expect_error(get_visit_name(x))
  expect_error(get_icd_name(x))
})

test_that("icd9 field guessed from data if name fails, any order", {
  x <- simple_poa_pts
  x10 <- x
  x10[[2]] <- icd10_each_ahrq_cmb[1:4]
  names(x)[2] <- "not_helpful"
  names(x10)[2] <- "not_helpful"
  expect_equal(get_icd_name(x), "not_helpful")
  perms <- matrix(nrow = 3, data = c(
    1, 2, 3,
    1, 3, 2,
    2, 1, 3,
    2, 3, 1,
    3, 1, 2,
    3, 2, 1)
  )
  apply(perms, 2, function(y) {
    expect_equal(get_icd_name(x[y]), "not_helpful")
    expect_equal(get_icd_name(x10[y]), "not_helpful")
  })
})

test_that("get_icd_name: icd field not present at all", {
  x <- simple_pts
  x[2] <- NULL
  expect_error(get_icd_name(x))
  names(x)[2] <- "icd"
  expect_error(get_icd_name(x))
  x[[2]] <- as.icd9(x[[2]])
  expect_error(get_icd_name(x), regexp = NA)
})
