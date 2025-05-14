inside_package <- function(package_name, code) {
  pkg_ns <- asNamespace(package_name)
  # Unlock all bindings in the namespace
  rlang::env_binding_unlock_all(env = pkg_ns)
  result <- code
  # Lock all bindings in the namespace
  rlang::env_binding_lock_all(env = pkg_ns)
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
