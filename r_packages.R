#' ---
#' title: "R Packages"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::github_document:
#'     toc: true
#' ---
#'
#+ user_lib
source("https://raw.githubusercontent.com/jeksterslabds/jeksterslabRutils/master/R/util_txt2file.R")
source("https://raw.githubusercontent.com/jeksterslabds/jeksterslabRterm/master/R/term_user_lib.R")
term_user_lib()
#'
#+ r_packages
repos <- "https://cran.rstudio.org"
if (!require("devtools")) {
  install.packages(
    "devtools",
    repos = repos
  )
}
if (!require("styler")) {
  install.packages(
    "styler",
    repos = repos
  )
}
if (!require("rmarkdown")) {
  install.packages(
    "rmarkdown",
    repos = repos
  )
}
remotes::install_github(
  c(
    "jalvesaq/colorout",
    "jeksterslabds/jeksterslabRutils",
    "jeksterslabds/jeksterslabRpkg",
    "jeksterslabds/jeksterslabRterm",
    "jeksterslabds/jeksterslabRlib",
    "jeksterslabds/jeksterslabRdoc",
    "jeksterslabds/jeksterslabRds"
  )
)
