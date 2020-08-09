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
    ggplot(aes(x = ts, y = 1, color = code)) +
    geom_point() +
    ylab(NULL) +
    xlab("Time (m)") +
    theme(axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank()) +
    scale_y_discrete(breaks = NULL) +
    scale_color_brewer("", type = "qual") +
    labs(subtitle = stringr::str_c("Units: ", round)) +
    theme(text = element_text(family = "Times", size = 14)) +
    scale_x_time()

}
