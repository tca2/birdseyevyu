#' Plot code frequency for a datavu column
#'
#' @param column the column as a character string
#' @param code the code as a character string; defaults to code01
#' @param directory the path to the directory as a character string
#' @param by_file whether or not to calculate the frequencies by file (logical)
#' @param what either "frequency" or "duration"
#' @return A data frame generated with the janitor package
#' @export
#' @examples
#' summarize_column(column = "LogClass_AS_ActivityFormat",
#'                  directory = "example-data/datavyu_output_07-06-2020_14-46")
#'

plot_time_series <- function(column, code = NULL, directory, by_file = FALSE) {

}

