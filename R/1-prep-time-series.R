#' Plot code frequency for a datavu column
#'
#' @param specified_file the file name; see find_unique_files() to determine their names
#' @inheritParams summarize_column
#' @importFrom magrittr "%>%"
#' @return a data frame
#' @export
#' @examples
#'

prep_time_series <- function(column, specified_file = NULL, directory, code = NULL, round = "s") {

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

  # all of this is for a single file
  if (!is.null(specified_file)) {
    df_of_codes <- df_of_codes %>%
      dplyr::filter(file == specified_file)


    # need to fix all of the object names below
    df_of_codes <- df_of_codes %>%
      select(all_of(code), contains("onset"), contains("offset")) %>%
      set_names(c("code", "onset", "offset"))

    if (round == "s") {
      d <- df_of_codes %>%
        mutate(onset = round(onset / 1000), # allow manual specification of rounding
               offset = round(offset / 1000))
    } else if (round == "m") {
      d <- df_of_codes %>%
        mutate(onset = round(onset / (1000 * 60)), # allow manual specification of rounding
               offset = round(offset / (1000 * 60)))
    } else if (round == "ms") {
      d <- df_of_codes
    }

    dd <- map2(d$onset, d$offset, time_seq)

    dd <- tibble(ts = unlist(dd))

    d <- d %>%
      pivot_longer(cols = c("onset", "offset")) %>%
      rename(ts = value)

    ddd <- left_join(dd, d, by = "ts") %>%
      fill(code) %>%
      select(-name)

  }

  attributes(ddd)$round <- round

  ddd
}

