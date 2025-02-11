#' @export
diebug_if <- function(cond, message = NULL, env = rlang::caller_env()) {
  if (cond) {
    diebug(message = message, env = env)
  }
}
