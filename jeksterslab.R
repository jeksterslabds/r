#' ---
#' title: "Check and install all Jeksterslab R Packages in {HOME}/scripts/r"
#' author: "Ivan Jacob Agaloos Pesigan"
#' date: "`r Sys.Date()`"
#' output:
#'   rmarkdown::html_vignette:
#'     toc: true
#' ---
#'
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
cat(libpath)
#'
#' ## Set Package Path
#'
#' Package path is set to `{HOME}/scripts/r/{PACKAGE}`
#'
#+ pkgpath
pkg <- c(
  "jeksterslabRutils",
  "jeksterslabRlib",
  "jeksterslabRdoc"
)
pkgpath <- file.path(
  Sys.getenv("HOME"),
  "scripts",
  "r",
  pkg
)
#'
#' ## Load `styler` and `devtools`
#'
#+ require
suppressMessages(
  invisible(
    lapply(
      X = c(
        "styler",
        "devtools"
      ),
      FUN = require,
      lib.loc = libpath,
      quietly = TRUE,
      character.only = TRUE
    )
  )
)
#'
#' ## Recursively style all packages and scripts in `{HOME}/scripts/r`
#'
#+ style, results="hide"
style_dir(
  file.path(
    Sys.getenv("HOME"),
    "scripts",
    "r"
  )
)
#'
#' ## Check and install packages
#'
#+ install, results="hide"
exe <- function(pkgpath) {
  check(pkgpath)
  install(
    pkgpath,
    args = paste(
      "-l",
      shQuote(libpath)
    )
  )
}
invisible(
  lapply(
    X = pkgpath,
    FUN = exe
  )
)
