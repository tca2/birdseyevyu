# library(tidyverse)
#
# d <- read_csv("example-data/datavyu_output_07-06-2020_14-46/LogClass_AS_ActivityFormat__NM 14-12-03 T201 Content Log v.3.csv")
#
# d <- d %>%
#   select(onset, activity = studentpresentername) %>%
#   mutate(onset = onset/60/60/60) %>%
#   gather(key, val, -onset) %>%
#   filter(!is.na(val)) %>%
#   mutate(var = 1)
#
# p <- d %>%
#   ggplot(aes(x = onset, y = var, shape = val, color = val)) +
#   geom_point() +
#   ylim(.75, 1.25) +
#   scale_y_continuous(labels = NULL) +
#   theme_minimal() +
#   labs(y = NULL) +
#   scale_color_discrete("Activity Format") +
#   scale_shape_discrete("Activity Format") +
#   xlab("time (minutes)")
#
# p
#
# d1 <- read_csv("example-data/LogClass_AS_ParticipationFormat__NM 14-12-03 T201 Content Log v.3.csv")
#
# d1 <- d1 %>%
#   select(onset, participatipn = code01) %>%
#   mutate(onset = onset/60/60/60) %>%
#   gather(key, val, -onset) %>%
#   filter(!is.na(val)) %>%
#   mutate(var = 2)
#
#
# p1 <- d1 %>%
#   ggplot(aes(x = onset, y = var, shape = val, color = val)) +
#   geom_point() +
#   ylim(.75, 1.25) +
#   scale_y_continuous(labels = NULL) +
#   theme_minimal() +
#   labs(y = NULL) +
#   scale_color_discrete("Participation Format") +
#   scale_shape_discrete("Participation Format") +
#   xlab("time (minutes)")
#
# library(patchwork)
#
# p + p1 + patchwork::plot_layout(ncol = 1)
#
# ggsave("readme-img.png", width = 7, height = 5)
