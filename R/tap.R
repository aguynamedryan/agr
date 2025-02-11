# Ok, this is the new and improved tap function
# We capture the calling environment and append the .data value to it
# Then we call browser in an eval so it sees the variables in the new environment
# and we pass in skipCalls = 3 to show us where in the actual code we evoked tap
tap <- function(.data, env = rlang::caller_env()) {
  tap_env <- modifyList(as.list(env), list(.data = .data))
  eval(expression(browser(skipCalls = 3)), envir = tap_env)
  return(.data)
}
