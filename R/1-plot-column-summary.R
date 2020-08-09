#' Plot code duration for a datavu column
#'
#' @param datavyu_object a datavyu object created by `summarize_column()`
#' @return A ggplot2 plot
#' @examples
#'
#' freq_summary <- summarize_column(column = "LogClass_AS_ActivityFormat",
#'                                  directory = "ex-data/datavyu_output_07-06-2020_14-46")
#'
#' freq_summary_by_file <- summarize_column(column = "LogClass_AS_ActivityFormat",
#'                                          directory = "ex-data/datavyu_output_07-06-2020_14-46",
#'                                          by_file = TRUE)
#'
#' plot_column_summary(freq_summary)
#' plot_column_summary(freq_summary_by_file)
#'
#' duration_summary <- summarize_column(column = "LogClass_AS_ActivityFormat",
#'                                      directory = "ex-data/datavyu_output_07-06-2020_14-46",
#'                                      what = "duration")
#'
#' duration_summary_by_file <- summarize_column(column = "LogClass_AS_ActivityFormat",
#'                                              directory = "ex-data/datavyu_output_07-06-2020_14-46",
#'                                              what = "duration",
#'                                              by_file = TRUE)
#'
#' plot_column_summary(duration_summary)
#' plot_column_summary(duration_summary_by_file)
#'

plot_column_summary <- function(datavyu_object) {

  if (attributes(datavyu_object)$type == "frequency") {

    plot_frequency(datavyu_object)

  } else if (attributes(datavyu_object)$type == "duration") {

    plot_duration(datavyu_object)

  }

}
