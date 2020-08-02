#' Summarize a datavyu column
#'
#' @param column the column as a character string
#' @param code the code as a character string
#' @param directory the path to the directory as a character string
#' @param by_file whether or not to calculate the frequencies by file (logical)
#' @param what either "frequency" or "duration"
#' @return A data frame generated with the janitor package
#' @export
#' @examples
#' summarize_column(column = "LogClass_AS_ActivityFormat",
#'                  directory = "example-data/datavyu_output_07-06-2020_14-46")
#'
#' summarize_column(column = "LogClass_AS_ActivityFormat",
#'                  directory = "example-data/datavyu_output_07-06-2020_14-46",
#'                  by_file = TRUE)
#'
#' summarize_column(column = "LogClass_AS_ActivityFormat",
#'                  directory = "example-data/datavyu_output_07-06-2020_14-46",
#'                  by_file = TRUE,
#'                  what = "duration")

summarize_column <- function(column = NULL,
                             code = NULL,
                             directory = NULL,
                             by_file = FALSE,
                             what = "frequency") {

  if (what == "frequency") {

    freq_output <- calc_frequencies(column = column,
                                    code = code,
                                    directory = directory,
                                    by_file = by_file)

    attributes(freq_output)$type <- what
    attributes(freq_output)$by_file <- by_file

    freq_output

  } else if (what == "duration") {

    duration_output <- calc_duration(column = column,
                  code = code,
                  directory = directory,
                  by_file = by_file)

    attributes(duration_output)$type <- what
    attributes(duration_output)$by_file <- by_file

    duration_output
  }
}
