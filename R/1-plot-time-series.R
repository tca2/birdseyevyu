#' Plot code frequency for a datavyu column
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

#' Plot code frequency for a datavyu column IN A NEW WAY
#'
#' @param datafile the file with onsets and offsets
#' @param directory path to a directory containing multiple such files or a vector of file locations
#' @param colors color palette to use, options from `ggplot2::scale_color_brewer()` function
#' @return A ggplot2 plot
#' @export
#' @importFrom rlang .data
#' @examples
#' \dontrun{
#' prepared_time_series <- prep_time_series(column = "childhands", code = "childhands.hand",
#'   specified_file = "dyad1", directory = "ex-data/datavyu_output_11-16-2020_13-26")
#'   plot_time_series_NEW(prepared_time_series)
#' }

plot_time_series_NEW <- function(datafile = NULL, directory = NULL, colors = 1) {
  if(!is.null(datafile)){

    datafile <- datafile %>%
      dplyr::mutate_at(vars(.data$onset, .data$offset), ms2min)

    p <- datafile %>%
      ggplot2::ggplot(aes(x = .data$onset, xend = .data$offset, y = .data$code01, yend = .data$code01, color = .data$code01)) +
      ggplot2::geom_segment(size = 6) +
      ggplot2::xlab("Time (DHMS)") +
      ggplot2::ylab(NULL) +
      ggplot2::scale_x_time() +
      ggplot2::theme(axis.title.y = ggplot2::element_blank(),
                     axis.text.y = ggplot2::element_blank(),
                     axis.ticks.y = ggplot2::element_blank()) +
      ggplot2::theme(text = ggplot2::element_text(family = "Times", size = 15)) +
      ggplot2::theme_minimal() #+
      #scale_color_brewer(type = "qual", palette = colors)

    if(length(unique(datafile$code01)) <= 8){
      p + scale_color_brewer(type = "qual", palette = colors)
    } else {
      p + scale_color_discrete()
    }
  }
  else if(!is.null(directory)){
    if(is.list(directory)){
      files <- directory
    } else if (is.character(directory)){
      files <- list.files(directory, pattern = "\\.csv", full.names = TRUE)
    }
    comb_data <- purrr::map_df(files, readr::read_csv)
    p <- comb_data %>%
      mutate_at(vars(onset, offset), ms2min) %>%
      ggplot2::ggplot(aes(x = .data$onset, xend = .data$offset, y = .data$file, yend = .data$file, color = .data$code01)) +
      ggplot2::geom_segment(size = 6) +
      ggplot2::xlab("Time (DHMS)") +
      ggplot2::ylab(NULL) +
      ggplot2::scale_x_time() +
      ggplot2::theme(axis.title.y = ggplot2::element_blank(),
                     axis.text.y = ggplot2::element_blank(),
                     axis.ticks.y = ggplot2::element_blank()) +
      ggplot2::theme(text = ggplot2::element_text(family = "Times", size = 15)) +
      ggplot2::theme_minimal() #+
      #scale_color_brewer(type = "qual", palette = colors)
    if(length(unique(comb_data$code01)) <= 8){
      p + scale_color_brewer(type = "qual", palette = colors)
    } else {
      p + scale_color_discrete()
    }
  }
}
