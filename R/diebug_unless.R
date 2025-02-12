#' @export
diebug_unless <- function(cond, ..., .env = rlang::caller_env()) {
  if (!cond) {
    diebug(..., .env = .env)
  }
}
