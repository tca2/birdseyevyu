#' Calculate code frequencies for a datavu column
#'
#' @param column the column as a character string
#' @param code the code as a character string
#' @param folder the path to the folder as a character string
#' @param by_file whether or not to calculate the frequencies by file (logical)
#' @return A data frame generated with the janitor package
#' @examples
#' calc_frequencies(column = "LogClass_AS_ActivityFormat",
#'                  folder = "example-data/datavyu_output_07-06-2020_14-46",
#'                  by_file = TRUE)
#'

calc_frequencies <- function(column = NULL,
                             code = NULL,
                             folder = NULL,
                             by_file = FALSE) {

  # argument check
  if (is.null(column)) {
    stop("Please specify a column name to tabulate via the `column_name` argument")
  }

  df_of_codes <- datavyur::import_column(column = column,
                                         folder = folder) %>%
    as_tibble()

  # this is if folks do not provide a code name
  if (is.null(code)) {
    code <- names(df_of_codes)[str_detect(names(df_of_codes), "code01")]
    if (length(code) < 1) {
      stop("Please specify a code name to tabulate via the `code_name` argument")
    }
  }

  if (by_file == FALSE) {

    df_of_codes %>%
      janitor::tabyl(all_of(code)) %>%
      dplyr::arrange(dplyr::desc(n))

  } else {

    list_of_freqs <- df_of_codes %>%
      group_by(file) %>%
      group_split() %>%
      map(janitor::tabyl, all_of(code))

    names(list_of_freqs) <- unique(df_of_codes$file)

    list_of_freqs %>%
      map_df(~., .id = "id") %>%
      rename(file = id)

  }
}
