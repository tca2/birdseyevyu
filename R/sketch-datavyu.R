# library(tidyverse)
# library(lubridate)
# library(tsibble)
#
# t <- ymd_hms("2019-04-01 00:00:01")
#
# t + 60
#
# tv <- c(t, t + 53, t + 432, t + 731, t + 932, t + 1853)
#
# tv
#
# ts <- tsibble(fruit = c("math", "no_math", "no_math", "math", "no_math", "math"),
#         time = tv)
#
# ts
#
# d <- ts %>%
#   fill_gaps(.full = TRUE) %>%
#   fill(fruit) %>%
#   mutate(yvars = 1)
#
# d
#
# d %>%
#   ggplot(aes(x = time, y = yvars, color = fruit)) +
#   geom_point() +
#   ylab(NULL) +
#   xlab("Time (m)") +
#   theme(axis.title.y=element_blank(),
#         axis.text.y=element_blank(),
#         axis.ticks.y=element_blank()) +
#   scale_y_discrete(breaks = NULL) +
#   scale_color_brewer("", type = "qual") +
#   labs(subtitle = "Units: s") +
#   theme(text = element_text(family = "Times", size = 14))
#
# ggsave("~/downloads/ts-plot.png", width = 6, height = 3)
#
