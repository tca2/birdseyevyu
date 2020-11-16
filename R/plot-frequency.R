#' Plot code frequency for a datavu column
#'
#' @param datavyu_object a datavyu object created by `summarize_column()`
#' @return A ggplot2 plot

plot_frequency <- function(datavyu_object) {

  if (attributes(datavyu_object)$by_file == FALSE) {

    names(datavyu_object)[1] <- "var"

    datavyu_object %>%
      ggplot2::ggplot(ggplot2::aes(x = reorder(var, n),
                          y = n)) +
      ggplot2::geom_col() +
      ggplot2::xlab(NULL) +
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

    names(datavyu_object)[2] <- "var"

    datavyu_object %>%
      ggplot2::ggplot(ggplot2::aes(x = reorder(var, n),
                          y = n)) +
      ggplot2::geom_col() +
      ggplot2::coord_flip() +
      ggplot2::facet_wrap("file") +
      ggplot2::xlab(NULL)

  }
}


