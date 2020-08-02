#' Plot datavyu output
#' @param datavyu_object a datavyu object created by `summarize_column()`
#' @export

plot.datavyu <- function(datavyu_object) {
  if (attributes(datavyu_object)$type == "frequency") {
    plot_frequencies(datavyu_object)
  } else if (attributes(datavyu_object)$type == "duration") {
    plot_durations(datavyu_object)
  }
}

#' Summarize datavyu output
#' @param datavyu_object a datavyu object created by `summarize_column()`
#' @export

summary.datavyu <- function(datavyu_object) {



}


#' Print datavyu output
#' @param datavyu_object a datavyu object created by `summarize_column()`
#' @export

print.datavyu <- function(datavyu_object) {



}
