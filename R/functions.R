library(dplyr)
library(stringr)
library(purrr)

# find_unique_values <- function(dir, what = "codes") {
#
#   f <- list.files(dir, full.names = TRUE) %>% sort()
#   f <- f[-1] # remove log file
#   bool <- !(str_detect(f, "LogNotes"))
#   f <- f[bool]
#
#   f_p1 <- f %>%
#     str_split("__") %>%
#     map_chr(~.[1]) %>%
#     sort()
#
#   f_p2 <- f %>%
#     str_split("__") %>%
#     map_chr(~.[2]) %>%
#     sort()
#
#   f_p1 <- f_p1 %>%
#     str_split("LogClass") %>%
#     map_chr(~.[2]) %>%
#     str_sub(start = 2)
#
#   if (what == "codes") {
#     f_p1 %>% unique()
#   } else if (what == "files") {
#     f_p2 %>% unique()
#   }
# }

plot_ts <- function(d) {

  names(d) <- names(d) %>%
    str_split("[.]") %>%
    map_chr(~.[2])

  names(d)[1] <- "file"

  d <- d %>%
    select(onset, activity = studentpresentername) %>%
    mutate(onset = onset/60/60/60) %>%
    gather(key, val, -onset) %>%
    filter(!is.na(val)) %>%
    mutate(var = 1)

  p <- d %>%
    ggplot(aes(x = onset, y = var, shape = val, color = val)) +
    geom_point() +
    ylim(.75, 1.25) +
    scale_y_continuous(labels = NULL) +
    theme_minimal() +
    labs(y = NULL) +
    scale_color_discrete("Activity Format") +
    scale_shape_discrete("Activity Format") +
    xlab("time (minutes)")

  return(p)
}
