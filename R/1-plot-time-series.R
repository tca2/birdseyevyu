#' Plot code frequency for a datavu column
#'
#' @param datavyu_ts_object the output from prep_time_series()
#' @return A ggplot2 plot
#' @param normalize_ts whether or not to normalize the time stamps to start at 0; defaults to FALSE
#' @export
#' @importFrom rlang .data
#' @examples
#' \dontrun{
#' prepared_time_series <- prep_time_series(column = "childhands", code = "childhands.hand",
#'   specified_file = "dyad1", directory = "ex-data/datavyu_output_11-16-2020_13-26")
#'   plot_time_series(prepared_time_series)
#' }

plot_time_series <- function(datavyu_ts_object, normalize_ts = FALSE) {

  if (attributes(datavyu_ts_object)$multiple_files == FALSE) {

    if (normalize_ts == TRUE) {

      datavyu_ts_object <- datavyu_ts_object %>%
        dplyr::group_by(file) %>%
        dplyr::mutate(ts = .data$ts - dplyr::first(.data$ts))

    }

    units <- attributes(datavyu_ts_object)$units

    datavyu_ts_object %>%
      ggplot2::ggplot(ggplot2::aes(x = .data$ts, y = 1, color = .data$code)) +
      ggplot2::geom_point() +
      ggplot2::ylab(NULL) +
      ggplot2::xlab("Time (m)") +
      ggplot2::theme(axis.title.y = ggplot2::element_blank(),
                     axis.text.y = ggplot2::element_blank(),
                     axis.ticks.y = ggplot2::element_blank()) +
      ggplot2::scale_y_discrete(breaks = NULL) +
      ggplot2::labs(subtitle = stringr::str_c("Units: ", units)) +
      ggplot2::theme(text = ggplot2::element_text(family = "Times", size = 14)) +
      ggplot2::scale_x_time()

  } else {

    if (normalize_ts == TRUE) {

      datavyu_ts_object <- datavyu_ts_object %>%
        dplyr::group_by(file) %>%
        dplyr::mutate(ts = .data$ts - dplyr::first(.data$ts))

    }

    datavyu_ts_object %>%
      ggplot2::ggplot(ggplot2::aes(x = .data$ts, y = 1, color = .data$code)) +
      facet_wrap(~file, ncol = 1) +
      ggplot2::geom_point() +
      ggplot2::ylab(NULL) +
      ggplot2::xlab("Time (m)") +
      ggplot2::theme(axis.title.y = ggplot2::element_blank(),
                     axis.text.y = ggplot2::element_blank(),
                     axis.ticks.y = ggplot2::element_blank()) +
      ggplot2::scale_y_discrete(breaks = NULL) +
      # ggplot2::labs(subtitle = stringr::str_c("Units: ", attributes(datavyu_ts_object)$units)) +
      ggplot2::theme(text = ggplot2::element_text(family = "Times", size = 14)) +
      ggplot2::scale_x_time()

  }

}
