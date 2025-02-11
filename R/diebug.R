diebug <- function(message = NULL, env = rlang::caller_env()) {
  if (getOption("diebug.debug", default = FALSE)) {
    if (!is.null(message)) {
      message(message)
    }
    eval(expression(browser(skipCalls = 3)), envir = env)
  } else {
    if (!is.null(message)) {
      stop(message)
    } else {
      stop()
    }
  }
}
