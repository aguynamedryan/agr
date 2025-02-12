#' @export
diebug <- function(..., .env = rlang::caller_env()) {
  if (getOption("diebug.debug", default = FALSE)) {
    message(...)
    eval(expression(browser(skipCalls = 3)), envir = .env)
  } else {
    stop(...)
  }
}
