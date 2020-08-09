#' Plot code frequency for a datavu column
#'
#' @param data_ts_object the output from prep_time_series()
#' @return A ggplot2 plot
#' @export
#' @examples
#' prepared_time_series <- prep_time_series(column = "LogClass_AS_ActivityFormat",
#'                                          specified_file = "MM T102 14-02-17 Content Log",
#'                                          directory = "ex-data/datavyu_output_07-06-2020_14-46")
#'
#' plot_time_series(prepared_time_series)
#'

plot_time_series <- function(datavyu_ts_object) {

  round <- attributes(datavyu_ts_object)$round

  datavyu_ts_object %>%
    ggplot2::ggplot(ggplot2::aes(x = ts, y = 1, color = code)) +
    ggplot2::geom_point() +
    ggplot2::ylab(NULL) +
    ggplot2::xlab("Time (m)") +
    ggplot2::theme(axis.title.y=ggplot2::element_blank(),
          axis.text.y=ggplot2::element_blank(),
          axis.ticks.y=ggplot2::element_blank()) +
    ggplot2::scale_y_discrete(breaks = NULL) +
    ggplot2::scale_color_brewer("", type = "qual") +
    ggplot2::labs(subtitle = stringr::str_c("Units: ", round)) +
    ggplot2::theme(text = ggplot2::element_text(family = "Times", size = 14)) +
    ggplot2::scale_x_time()

}
