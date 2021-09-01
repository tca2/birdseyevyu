#' Plot code frequency for a datavyu column
#'
#' @param columns the column or columns to select as character string or vector
#' @param directory path to where csv files are to be found with `datavyur::import_datavyu()`
#' @param colors color palette to use, options from `ggplot2::scale_color_brewer()` function
#' @param cat_order character vector of the order in which to display codes in plot
#' @param color_scale a named character vector manually specifying a color scale will also reorder based on order provided
#' @return A ggplot2 plot
#' @export
#' @importFrom rlang .data

plot_time_series <- function(columns, directory = NULL, colors = 1, cat_order = NULL, color_scale = NULL) {

  # if directory isn't provided use the one set as option
  if(is.null(directory)){
    directory <- getOption("directory")
  }

  if(length(columns) == 1){

    datafile <- datavyur::import_datavyu(folder = directory, columns = columns)

    datafile <- datafile %>%
      dplyr::mutate_at(vars(.data$onset, .data$offset), ms2min)

    if(!is.null(cat_order)){
      datafile <- dplyr::mutate(datafile, code01 = factor(.data$code01, levels = cat_order))
    }

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
      ggplot2::theme_minimal()

    if(!is.null(color_scale)){
      p <- p + scale_color_manual(values = color_scale, breaks = rev(names(color_scale))) + scale_y_discrete(limits = names(color_scale))
    } else if(length(unique(datafile$code01)) <= 8){
      p <- p + scale_color_brewer(type = "qual", palette = colors)
    } else {
      p <- p + scale_color_discrete()
    }

    #if(!is.null(cat_order)){
    #p <- p + scale_y_discrete(limits = cat_order)
    #}
    p
  } else {

    comb_data <- datavyur::import_datavyu(folder = directory, column = columns, as_list = TRUE)

    # now select the right columns and bind rows

    #names <- Reduce(intersect, lapply(FUN = colnames, comb_data))
    names <- c("file", "column", "ordinal", "onset", "offset", "code01")

    comb_data <- comb_data %>%
      purrr::map(dplyr::select, names) %>%
      dplyr::bind_rows()

    p <- comb_data %>%
      dplyr::mutate_at(vars(.data$onset, .data$offset), ms2min) %>%
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
