#' Calculate the duration of a code for a datavyu column
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

calc_duration <- function(column = NULL,
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

  index_for_onset <- str_detect(names(df_of_codes), "onset")
  names(df_of_codes)[index_for_onset] <- "onset"

  index_for_offset <- str_detect(names(df_of_codes), "offset")
  names(df_of_codes)[index_for_offset] <- "offset"

  # this is if folks do not provide a code name
  if (is.null(code)) {
    code <- names(df_of_codes)[str_detect(names(df_of_codes), "code01")]
    if (length(code) < 1) {
      stop("Please specify a code name to tabulate via the `code_name` argument")
    }
  }

  if (by_file == FALSE) {

    df_of_codes %>%
      group_by(!!sym(code)) %>%
      mutate(duration = if_else(offset > onset, offset - onset, onset - offset)) %>%
      summarize(sum_duration = sum(duration, na.rm = TRUE)) %>%
      mutate_at(vars(sum_duration), datavyur::ms2time)

  } else {

    list_of_times <- df_of_codes %>%
      group_by(file) %>%
      group_split()

    names(list_of_times) <- unique(df_of_codes$file)

    list_of_times %>%
      map_df(~., .id = "id") %>%
      select(-id) %>% # why is there this and file? not sure
      group_by(!!sym(code), file) %>%
      mutate(duration = if_else(offset > onset, offset - onset, onset - offset)) %>%
      summarize(sum_duration = sum(duration, na.rm = TRUE)) %>%
      mutate_at(vars(sum_duration), datavyur::ms2time)

  }
}

