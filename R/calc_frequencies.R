#' Calculate code frequencies for a datavu column
#'
#' @param column the column as a character string
#' @param code the code as a character string
#' @param directory the path to the directory as a character string
#' @param by_file whether or not to calculate the frequencies by file (logical)
#' @return A data frame generated with the janitor package

calc_frequencies <- function(column,
                             code,
                             directory = NULL,
                             by_file = FALSE) {

  # argument check
  if (is.null(column)) {
    stop("Please specify a column name to tabulate via the `column_name` argument")
  }

  df_of_codes <- datavyur::import_datavyu(column = column,
                                         folder = directory) %>%
    tibble::as_tibble() %>%
    dplyr::select(1:4, all_of(code))

  if (by_file == FALSE) {

    out <- df_of_codes %>%
      janitor::tabyl(all_of(code)) %>%
      dplyr::arrange(dplyr::desc(n)) %>%
      as_tibble()

  } else {

    list_of_freqs <- df_of_codes %>%
      dplyr::group_by(file) %>%
      dplyr::group_split() %>%
      purrr::map(janitor::tabyl, all_of(code))

    names(list_of_freqs) <- unique(df_of_codes$file)

    out <- list_of_freqs %>%
      purrr::map_df(~., .id = "id") %>%
      dplyr::rename(file = id) %>%
      tibble::as_tibble()

  }

  out

}
