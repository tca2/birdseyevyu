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

prep_time_series <- function(column, code = NULL, directory, by_file = FALSE) {

  # argument check
  if (is.null(column)) {
    stop("Please specify a column name to tabulate via the `column_name` argument")
  }

  df_of_codes <- datavyur::import_column(column = column,
                                         folder = directory) %>%
    tibble::as_tibble() %>%
    janitor::clean_names()

  # this is if folks do not provide a code name
  if (is.null(code)) {
    code <- names(df_of_codes)[stringr::str_detect(names(df_of_codes), "code01")]
    if (length(code) < 1) {
      stop("Please specify a code name to tabulate via the `code_name` argument")
    }
  }

  df_of_codes %>%
    select(code, contains("onset"), contains("offset")) %>%
    set_names(c("code", "onset", "offset"))

}

# prep_time_series(column = "LogClass_AS_ActivityFormat",
#                       directory = "ex-data/datavyu_output_07-06-2020_14-46") %>% View()
#   pivot_longer(cols = c(2, 3)) %>%
#   rename(time = value) %>%
#   select(-name) %>%
#   mutate(key = rep(1:(nrow(.)/2), each = 2))
#
# tsibble(d, index = time, key = key) %>%
#   mutate(time = time / 1000) %>%
#   fill_gaps()
