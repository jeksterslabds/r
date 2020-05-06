repos <- "https://cran.rstudio.org"
if (!require("remotes")) {
  install.packages(
    "remotes",
    repos = repos
  )
}
remotes::install_github(
  "jeksterslabds/jeksterslabR"
)
