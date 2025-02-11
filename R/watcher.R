library(fs)
library(later)
library(purrr)

#' @export
watcher <- function(...) {
  paths_to_watch <- list(...) |> purrr::imap(function(paths, name) {
    c(paths, name)
  })

  # Function to run tests with error handling
  run_tests <- function(test_file) {
    cat("Running tests for", test_file, "...\n")
    tryCatch(
      {
        testthat::test_file(test_file)
      },
      error = function(e) {
        cat("Error running tests for", test_file, ":", e$message, "\n")
      }
    )
  }

  # Initial run
  purrr::walk(names(paths_to_watch), run_tests)

  # Watch for changes
  watch_files <- function() {
    last_mtimes <- purrr::map(paths_to_watch, ~ purrr::map_dbl(.x, ~ file_info(.x)$modification_time))

    later::later(function() {
      current_mtimes <- purrr::map(paths_to_watch, ~ purrr::map_dbl(.x, ~ file_info(.x)$modification_time))

      purrr::iwalk(paths_to_watch, function(paths, test_file) {
        if (!all(current_mtimes[[test_file]] == last_mtimes[[test_file]])) {
          run_tests(test_file)
          last_mtimes[[test_file]] <<- current_mtimes[[test_file]]
        }
      })
      watch_files()
    }, delay = 1)
  }

  watch_files()
}
