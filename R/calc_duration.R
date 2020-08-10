#' Calculate the duration of a code for a datavyu column
#'
#' @param column the column as a character string
#' @param code the code as a character string
#' @param directory the path to the directory as a character string
#' @param by_file whether or not to calculate the frequencies by file (logical)
#' @return A data frame generated with the janitor package

calc_duration <- function(column = NULL,
                          code = NULL,
                          directory = NULL,
                          by_file = FALSE) {

  # argument check
  if (is.null(column)) {
    stop("Please specify a column name to tabulate via the `column_name` argument")
  }

  df_of_codes <- datavyur::import_column(column = column,
                                         folder = directory) %>%
    tibble::as_tibble() %>%
    janitor::clean_names()

  # this is if a code name is not provided
  if (is.null(code)) {
    code <- names(df_of_codes)[stringr::str_detect(names(df_of_codes), "code01")]
    if (length(code) < 1) {
      stop("Please specify a code name to tabulate via the `code_name` argument")
    }
  }

  index_for_onset <- stringr::str_detect(names(df_of_codes), "onset")
  names(df_of_codes)[index_for_onset] <- "onset"

  index_for_offset <- stringr::str_detect(names(df_of_codes), "offset")
  names(df_of_codes)[index_for_offset] <- "offset"

  if (by_file == FALSE) {

    df_of_codes %>%
      dplyr::group_by(!!rlang::sym(code)) %>%
      dplyr::mutate(duration = dplyr::if_else(offset > onset, offset - onset, onset - offset)) %>%
      dplyr::summarize(sum_duration = sum(duration, na.rm = TRUE)) %>%
      dplyr::mutate(percent = sum_duration / sum(sum_duration)) %>%
      dplyr::arrange(desc(sum_duration)) %>%
      dplyr::mutate_at(dplyr::vars(sum_duration), datavyur::ms2time) %>%
      dplyr::rename(duration = sum_duration) %>%
      tibble::as_tibble()

  } else {

    list_of_times <- df_of_codes %>%
      dplyr::group_by(file) %>%
      dplyr::group_split()

    names(list_of_times) <- unique(df_of_codes$file)

    list_of_times %>%
      purrr::map_df(~., .id = "id") %>%
      dplyr::select(-id) %>% # why is there this and file? not sure
      dplyr::group_by(file, !!rlang::sym(code)) %>%
      dplyr::mutate(duration = dplyr::if_else(offset > onset, offset - onset, onset - offset)) %>%
      dplyr::summarize(sum_duration = sum(duration, na.rm = TRUE)) %>%
      dplyr::arrange(file, desc(sum_duration)) %>%
      dplyr::mutate(percent = sum_duration / sum(sum_duration)) %>%
      dplyr::mutate_at(dplyr::vars(sum_duration), datavyur::ms2time) %>%
      dplyr::rename(duration = sum_duration) %>%
      tibble::as_tibble()

  }
}
