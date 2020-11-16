#' Plot code frequency for a datavu column
#'
#' @param specified_file the file name; use datavyur::datavyu_col_search() to determine their names
#' @param units the units the data will be prepared in; either "m" (minutes), "s" (default; seconds), or "ms" (milli-seconds)
#' @inheritParams summarize_column
#' @importFrom magrittr "%>%"
#' @return a data frame
#' @export
#' @examples
#'

prep_time_series <- function(column,
                             code,
                             specified_file = NULL,
                             directory = NULL,
                             units = "s") {

  # finding directory option
  if (is.null(directory)) {
    if (is.null(directory)) {
      directory <- getOption("directory")
    } else {
      stop("No directory specified or set via options(directory = ''; please specify one")
    }
  }

  # argument check
  if (is.null(column)) {
    stop("Please specify a column name to tabulate via the `column_name` argument")
  }

  df_of_codes <- datavyur::import_column(column = column,
                                         folder = directory) %>%
    tibble::as_tibble() %>%
    dplyr::select(1:4, all_of(code))

  # all of this is for a single file
  if (!is.null(specified_file)) {
    df_of_codes <- df_of_codes %>%
      dplyr::filter(file == specified_file)

    # need to fix all of the object names below - for a single file
    df_of_codes <- df_of_codes %>%
      dplyr::select(all_of(code), dplyr::contains("onset"), dplyr::contains("offset")) %>%
      purrr::set_names(c("code", "onset", "offset"))

    if (units == "s") {
      d <- df_of_codes %>%
        dplyr::mutate(onset = round(onset / 1000), # allow manual specification of unitsing
                      offset = round(offset / 1000))
    } else if (units == "m") {
      d <- df_of_codes %>%
        dplyr::mutate(onset = round(onset / (1000 * 60)), # allow manual specification of unitsing
                      offset = round(offset / (1000 * 60)))
    } else if (units == "ms") {
      d <- df_of_codes
    }

    dd <- purrr::map2(d$onset, d$offset, time_seq)

    dd <- tibble::tibble(ts = unlist(dd))

    d <- d %>%
      tidyr::pivot_longer(cols = c("onset", "offset")) %>%
      dplyr::rename(ts = value)

    ddd <- dplyr::left_join(dd, d, by = "ts") %>%
      tidyr::fill(code) %>%
      dplyr::select(-name)

  }

  attributes(ddd)$units <- units

  ddd
}

