create_datavyu_class <- function(x) {
  structure(x, class = c("tibble", "data.frame", "datavyu"))
}
