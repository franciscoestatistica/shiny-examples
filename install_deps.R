#!/usr/bin/env Rscript

# This script installs some development packages that are needed for various
# apps. It can be sourced from RStudio, or run with Rscript.


is_installed <- function(pkg) {
  if (system.file(package = pkg) == "")
    FALSE
  else
    TRUE
}

# Install a package or packages if not already installed.
install_if_needed <- function(pkgs) {
  pkgs <- sort(unique(pkgs))
  message("Trying to install: ", paste0(pkgs, collapse = ", "))
  installed_idx <- vapply(pkgs, is_installed, TRUE)
  needed <- pkgs[!installed_idx]
  if (length(needed) > 0) {
    message("Installing needed packages from CRAN: ", paste(needed, collapse = ", "))
    install.packages(needed)
  }
}

# Core packages
install_if_needed(c("devtools", "rsconnect", "packrat", "knitr", "renv"))

# Some packages must be installed from GitHub
devtools::install_github(c(
  # For 087-crandash
  "hadley/shinySignals",
  "jcheng5/bubbles",
  "jcheng5/googleCharts",
  "rstudio/shinyvalidate"
  # , "rstudio/shiny"
))

# Autodetect packages needed for the examples (will install from CRAN)
install_if_needed(packrat:::dirDependencies("."))
