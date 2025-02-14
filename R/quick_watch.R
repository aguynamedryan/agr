library(fs)
library(later)
library(purrr)
library(stringr)
library(here)

to_test <- function(path) {
  file.path("tests", "testthat", paste0("test-", str_replace(basename(path), "test-", "")))
}

to_r <- function(path) {
  file.path("R", str_replace(basename(path), "test-", ""))
}

to_snap <- function(path) {
  file_name <- path |>
    tools::file_path_sans_ext() |>
    basename() |>
    str_replace("test-", "") |>
    paste0(".md")
  p <- file.path("tests", "testthat", "_snaps", file_name)
  if (file.exists(here::here(p))) {
    p
  } else {
    NULL
  }
}

convert_path <- function(path, kind = c("test", "r", "snap")) {
  kind <- match.arg(kind)
  if (kind == "test") {
    to_test(path)
  } else if (kind == "r") {
    to_r(path)
  } else if (kind == "snap") {
    to_snap(path)
  }
}
assemble_paths <- function(..., .env = parent.frame()) {
  list(...) |> purrr::reduce(function(all_paths, path) {
    l <- list()
    l[[convert_path(path, kind = "test")]] <- c(convert_path(path, kind = "r"), convert_path(path, kind = "snap"))
    c(all_paths, l)
  }, .init = list())
}

#' @export
quick_watch <- function(...) {
  do.call(watcher, assemble_paths(...))
}
