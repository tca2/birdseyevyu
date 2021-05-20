time_seq <- function(onset, offset) {
  seq(from = onset, to = offset)
}

#' Prep multiple files
#'
#' @param d input
#' @return output
#' @importFrom rlang .data

prep_multiple_ts_files <- function(d) {
  res <- purrr::map2(d$onset, d$offset, time_seq)
  dd <- tibble::tibble(ts = unlist(res))

  d <- d %>%
    tidyr::pivot_longer(cols = c("onset", "offset")) %>%
    dplyr::rename(ts = .data$value)

  out <- dplyr::left_join(dd, d, by = "ts") %>%
    tidyr::fill(.data$code) %>%
    tidyr::fill(.data$file) %>%
    dplyr::select(-.data$name)

  out

}

# split_time <- function(x) {
#   stringr::str_split(x, ":")
# }
#
# parse_duration <- function(x) {
#   lubridate::dhours(as.integer(x[1])) +
#     lubridate::dminutes(as.integer(x[2])) +
#     lubridate::dseconds(as.integer(x[3])) +
#     lubridate::dmilliseconds(as.integer(x[4]))
# }
#
# character_string_to_duration <- function(x) {
#   split_character_string <- split_time(x)
#   parse_duration(split_character_string[[1]])
# }
