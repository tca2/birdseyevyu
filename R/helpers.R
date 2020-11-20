time_seq <- function(onset, offset) {
  seq(from = onset, to = offset)
}

prep_multiple_ts_files <- function(d) {
  res <- purrr::map2(d$onset, d$offset, time_seq)
  dd <- tibble::tibble(ts = unlist(res))

  d <- d %>%
    tidyr::pivot_longer(cols = c("onset", "offset")) %>%
    dplyr::rename(ts = value)

  out <- dplyr::left_join(dd, d, by = "ts") %>%
    tidyr::fill(code) %>%
    tidyr::fill(file) %>%
    dplyr::select(-name)

  out

}
