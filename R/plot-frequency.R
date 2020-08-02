#' Plot code frequency for a datavu column
#'
#' @param datavyu_object a datavyu object created by `summarize_column()`
#' @return A ggplot2 plot
#' @examples
#'
#' freq_summary <- summarize_column(column = "LogClass_AS_ActivityFormat",
#'                                  directory = "ex-data/datavyu_output_07-06-2020_14-46")
#'
#' freq_summary_by_file <- summarize_column(column = "LogClass_AS_ActivityFormat",
#'                                          directory = "ex-data/datavyu_output_07-06-2020_14-46",
#'                                          by_file = TRUE)
#'
#' plot_frequency(freq_summary)
#' plot_frequency(freq_summary_by_file)

plot_frequency <- function(datavyu_object) {

  if (attributes(datavyu_object)$by_file == FALSE) {

    datavyu_object %>%
      dplyr::rename(var = 1) %>%
      ggplot2::ggplot(ggplot2::aes(x = reorder(var, n),
                          y = n)) +
      ggplot2::geom_col() +
      ggplot2::coord_flip()

  } else if (attributes(datavyu_object)$by_file == TRUE) {

    # dealing with many files
    if (nrow(dplyr::count(datavyu_object, file)) >= 20) {
      message("Plotting this many files may cause problems with your plot;
              consider visualizing this data in a different way")
    }

    if (nrow(dplyr::count(datavyu_object, file)) >= 100) {
      message("Plotting this many files will almost certainly cause problems with your plot;
              consider visualizing this data in a different way")
    }

    if (nrow(dplyr::count(datavyu_object, file)) >= 200) {
      stop("Cannot plot this many files; consider visualizing this data in a different way")
    }

    datavyu_object %>%
      dplyr::rename(var = 2) %>%
      ggplot2::ggplot(ggplot2::aes(x = tidytext::reorder_within(var, n, file),
                          y = n)) +
      ggplot2::geom_col() +
      ggplot2::coord_flip() +
      ggplot2::facet_wrap("file") +
      tidytext::scale_x_reordered()

  }
}


