#' ---
#' title: "Update and Install R Packages"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::github_document:
#'     toc: true
#' ---
#'
#' This script peforms the following:
#'
#'   - sets library path to `{HOME}/R/{PLATFORM}-library/{R.VERSION}`
#'     (e.g., `"/home/jek/R/x86_64-pc-linux-gnu-library/3.6"`)
#'   - updates installed packages,
#'   - checks if packages in the `packages` list are already installed in the current system,
#'   - installs only the packages in the `packages` list that are not installed in the current system, and
#'   - checks and installs jeksterslab packages if `jeksterslab` is `TRUE`.
#'
#' If `{HOME}/.Renviron` exist
#' the script appends the environment variable `R_LIBS_USER={HOME}/R/{PLATFORM}-library/{R.VERSION}`.
#' If it does not, the script creates it and appends the environment variable.
#'
<<<<<<< HEAD
=======
#' ## Option to install Jeksterslab R packages in `{HOME}/scripts/r`
#'
#+ jeksterslab
jeksterslab <- TRUE
#'
>>>>>>> 13901dd7bb3e39b8273a07fae7b7cd780f7c53ed
#' ## Set the Library Path
#'
#' The library path is set to `{HOME}/R/{PLATFORM}-library/{R.VERSION}`
#'
#+ libpath
platform <- R.version[["platform"]]
major <- R.version[["major"]]
minor <- sub(
  pattern = ".[1-9]",
  replacement = "",
  R.version[["minor"]]
)
version <- paste0(
  major,
  ".",
  minor
)
libpath <- file.path(
  Sys.getenv("HOME"),
  "R",
  paste0(
    platform,
    "-library"
  ),
  version
)
if (!dir.exists(libpath)) {
  dir.create(
    libpath,
    recursive = TRUE
  )
}
.libPaths(
  c(
<<<<<<< HEAD
    libpath,
=======
    "libpath",
>>>>>>> 13901dd7bb3e39b8273a07fae7b7cd780f7c53ed
    .libPaths()
  )
)
R_LIBS_USER <- paste0(
  "R_LIBS_USER",
  "=",
  libpath
)
cat(
  paste(
    "Library path:",
    libpath,
    "\n"
  )
)
#'
#' Generate `{HOME}/.Renviron` with the environment variable `R_LIBS_USER={HOME}/R/{PLATFORM}-library/{R.VERSION}`.
#'
#+ Renviron
dotRenviron <- file.path(
  Sys.getenv("HOME"),
  ".Renviron"
)
if (file.exists(dotRenviron)) {
  content <- readLines(dotRenviron)
  pattern <- "^R_LIBS_USER=.*"
  if (
    any(
      grepl(
        pattern = pattern,
        x = content
      )
    )
  ) {
    R_LIBS_USER <- sub(
      pattern = pattern,
      replacement = R_LIBS_USER,
      x = content
    )
  }
}
writeLines(
  text = R_LIBS_USER,
  con = dotRenviron
)
#'
#' ## Update and install packages
#'
#+ install, results="hide"
packages <- c(
  # distribution
  "extraDistr",
  # package development tools
  "devtools",
  "testthat",
  "roxygen2",
  "styler",
  "rprojroot",
  "here",
  "qpdf",
  "usethis",
  "pkgdown",
  # serialization
  "yaml",
  "rjson",
  # http request
  "curl",
  # benchmark
  "microbenchmark",
  # reporting
  "rmarkdown",
  "knitr",
  "printr",
  "pkgdown",
  # tidyverse
  "tidyverse",
  # SEM
  "lavaan",
  "OpenMx",
  "metaSEM",
  "semPlot",
  "semTools",
  # wrangling
  "tidyr",
  "dplyr",
  "readxl",
  # graphics
  "ggplot2",
  "gridExtra",
  "scatterplot3d",
  "plotly",
  # simulate nonnormal data from correlation matrix
  "fungible",
  "psych",
  # learning linear algebra
  "matlib",
  "matrixcalc",
  "mosaic",
  # python
  "reticulate"
)
if (is.vector(packages)) {
  packages <- as.list(packages)
}
<<<<<<< HEAD
github <- c(
  # personal packages
  "jeksterslabds/jeksterslabRutils",
  "jeksterslabds/jeksterslabRpkg",
  "jeksterslabds/jeksterslabRlib"
)
=======
# github <- c(
#  # continuous integration
#  "ropenscilabs/travis",
#  # personal packages
#  "jeksterslabds/jeksterslabRutils",
#  "jeksterslabds/jeksterslabRpkg",
#  "jeksterslabds/jeksterslabRlib"
# )
>>>>>>> 13901dd7bb3e39b8273a07fae7b7cd780f7c53ed
update.packages(
  ask = FALSE,
  lib = libpath,
  repos = "https://cran.rstudio.org"
)
invisible(
  lapply(
    X = packages[!packages %in% rownames(installed.packages())],
    FUN = install.packages,
    lib = libpath,
    ask = FALSE,
    repos = "https://cran.rstudio.org",
    dependencies = TRUE,
    type = "source"
  )
)
<<<<<<< HEAD
suppressMessages(
  library(
    devtools,
    lib.loc = libpath
  )
)
install_github(
  github,
  ref = "master"
)
=======
# suppressMessages(
#  library(
#    devtools,
#    lib.loc = libpath
#  )
# )
# install_github(github)
>>>>>>> 13901dd7bb3e39b8273a07fae7b7cd780f7c53ed
