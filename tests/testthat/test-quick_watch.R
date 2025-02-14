test_that("to_test works", {
  expect_equal(to_test("test-quick_watch.R"), "tests/testthat/test-quick_watch.R")
  expect_equal(to_test("tests/testthat/test-quick_watch.R"), "tests/testthat/test-quick_watch.R")
  expect_equal(to_test("quick_watch.R"), "tests/testthat/test-quick_watch.R")
})

test_that("to_r works", {
  expect_equal(to_r("test-quick_watch.R"), "R/quick_watch.R")
  expect_equal(to_r("tests/testthat/test-quick_watch.R"), "R/quick_watch.R")
  expect_equal(to_r("quick_watch.R"), "R/quick_watch.R")
})

test_that("to_snap works", {
  to_snap("test-quick_watch.R") |>
    expect_snapshot_value(style = "json2")
  expect_equal(to_snap("test-quick_watch.md"), "tests/testthat/_snaps/quick_watch.md")
  expect_equal(to_snap("tests/testthat/test-quick_watch.md"), "tests/testthat/_snaps/quick_watch.md")
  expect_equal(to_snap("quick_watch.md"), "tests/testthat/_snaps/quick_watch.md")
})

test_that("assemble_paths works", {
  expect_equal(assemble_paths("test-quick_watch.R"), list("tests/testthat/test-quick_watch.R" = c("R/quick_watch.R", "tests/testthat/_snaps/quick_watch.md")))
})
