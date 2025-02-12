inside_package <- function(package_name, code) {
  rlang::env_unlock(env = asNamespace(package_name))
  rlang::env_binding_unlock(env = asNamespace(package_name))
  result <- code
  rlang::env_binding_lock(env = asNamespace(package_name))
  rlang::env_lock(asNamespace(package_name))
  result
}

# Found here: https://stackoverflow.com/a/62563023
#' @export
override_method <- function(
    package_name,
    method_name,
    method_def) {
  inside_package(package_name, {
    assign(method_name, method_def, envir = asNamespace(package_name))
  })
}
