#' Summarize a datavyu column
#'
#' @param column the column as a character string
#' @param code the code as a character string; defaults to code01
#' @param directory the path to the directory as a character string; can be set with options(directory = "")
#' @param by_file whether or not to calculate the frequencies by file (logical)
#' @param summary either "frequency" or "duration"
#' @return A data frame generated with the janitor package
#' @export
#' @examples
#' summarize_column(column = "LogClass_AS_ActivityFormat",
#'                  directory = "ex-data/datavyu_output_07-06-2020_14-46")
#'
#' summarize_column(column = "LogClass_AS_ActivityFormat",
#'                  directory = "ex-data/datavyu_output_07-06-2020_14-46",
#'                  by_file = TRUE)
#'
#' summarize_column(column = "LogClass_AS_ActivityFormat",
#'                  directory = "ex-data/datavyu_output_07-06-2020_14-46",
#'                  by_file = TRUE,
#'                  summary = "duration")

summarize_column <- function(column = NULL,
                             code = NULL,
                             directory = NULL,
                             by_file = FALSE,
                             summary = "frequency") {

  if (is.null(directory)) {
    if (is.null(directory)) {
      directory <- getOption("directory")
    } else {
      stop("No directory specified or set via options(directory = ''; please specify one")
    }
  }

  if (summary == "frequency") {

    freq_output <- calc_frequencies(column = column,
                                    code = code,
                                    directory = directory,
                                    by_file = by_file)

    attributes(freq_output)$type <- summary
    attributes(freq_output)$by_file <- by_file

    freq_output

  } else if (summary == "duration") {

    duration_output <- calc_duration(column = column,
                                     code = code,
                                     directory = directory,
                                     by_file = by_file)

    attributes(duration_output)$type <- summary
    attributes(duration_output)$by_file <- by_file

    duration_output
  }
}
