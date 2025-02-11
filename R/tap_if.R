tap_if <- function(.data, cond, env = rlang::caller_env()) {
  tap_env <- modifyList(as.list(env), list(.data = .data))
  cond <- rlang::enexpr(cond)
  if (eval(cond, envir = tap_env)) {
    eval(expression(browser(skipCalls = 3)), envir = tap_env)
  }
  return(.data)
}
