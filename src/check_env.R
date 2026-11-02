# Check the environment: load each package and print its version.

PACKAGES <- c(
  "tidyverse", "ggplot2", "dplyr", "readr", "readxl", "broom",
  "rmarkdown", "knitr", "languageserver",
  "car", "psych", "moments", "GGally", "janitor", "skimr"
)

cat(R.version.string, "\n\n")

failed <- character(0)
for (pkg in PACKAGES) {
  if (requireNamespace(pkg, quietly = TRUE)) {
    cat(sprintf("%-16s %s\n", pkg, as.character(packageVersion(pkg))))
  } else {
    cat(sprintf("%-16s MISSING\n", pkg))
    failed <- c(failed, pkg)
  }
}

if (length(failed) > 0) {
  cat(sprintf("\n%d package(s) failed to load: %s\n", length(failed),
              paste(failed, collapse = ", ")))
  quit(status = 1)
}
cat("\nAll packages loaded successfully.\n")
