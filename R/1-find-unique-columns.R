#' Find unique columns in a directory
#'
#' @param directory the path to the directory as a character string; can be set with options(directory = "")
#' @return A vector with the unique columns in a directory
#' @export
#' @examples
#' find_unique_columns("ex-data/datavyu_output_07-06-2020_14-46")

find_unique_columns <- function(directory = NULL) {

  if (is.null(directory)) {
    if (is.null(directory)) {
      directory <- getOption("directory")
    } else {
      stop("No directory specified or set via options(directory = ''; please specify one")
    }
  }

  datavyur::datavyu_col_search(folder = directory) %>%
    dplyr::pull(column) %>%
    unique()

}
