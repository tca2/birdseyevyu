#' Find unique columns in a directory
#'
#' @param directory the path to the directory as a character string; can be set with options(directory = "")
#' @return A vector with the unique columns in a directory
#' @export
#' @examples
#' find_unique_files("ex-data/datavyu_output_07-06-2020_14-46")

find_unique_files <- function(directory = NULL) {

  if (is.null(directory)) {
    if (is.null(directory)) {
      stop("No directory specififed or set via options(directory = ''; please specify one")
    } else {
      directory <- getOption("directory")
    }
  }

  datavyur::datavyu_col_search(folder = directory) %>%
    pull(file) %>%
    unique()

}
