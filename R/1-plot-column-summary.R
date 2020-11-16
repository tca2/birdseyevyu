#' Plot code duration for a datavyu column
#'
#' @param datavyu_object a datavyu object created by `summarize_column()`
#' @return A ggplot2 plot
#' @export
#' @examples
#' \dontrun{
#' freq_summary <- summarize_column(column = "childhands", code = "childhands.hand", directory = system.file("extdata", "datavyu_output_11-16-2020_13-26", package = "datavyu"))
#'
#' freq_summary_by_file <- summarize_column(column = "childhands", code = "childhands.hand", directory = "ex-data/datavyu_output_11-16-2020_13-26",
#'                                          by_file = TRUE)
#'
#' plot_column_summary(freq_summary)
#' plot_column_summary(freq_summary_by_file)
#'
#' duration_summary <- summarize_column(column = "childhands", code = "childhands.hand", directory = "ex-data/datavyu_output_11-16-2020_13-26",
#'                                      summary = "duration")
#'
#' duration_summary_by_file <- summarize_column(column = "childhands", code = "childhands.hand", directory = "ex-data/datavyu_output_11-16-2020_13-26",
#'                                              summary = "duration",
#'                                              by_file = TRUE)
#'
#' plot_column_summary(duration_summary)
#' plot_column_summary(duration_summary_by_file)
#' }

plot_column_summary <- function(datavyu_object) {

  if (attributes(datavyu_object)$type == "frequency") {

    plot_frequency(datavyu_object)

  } else if (attributes(datavyu_object)$type == "duration") {

    plot_duration(datavyu_object)

  }

}
