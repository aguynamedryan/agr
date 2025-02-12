#' @export
diebug_if <- function(cond, ..., .env = rlang::caller_env()) {
  if (cond) {
    diebug(..., .env = .env)
  }
}
