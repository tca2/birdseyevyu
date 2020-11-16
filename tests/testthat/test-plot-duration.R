# context("checking-plot-duration")
#
# duration_summary <- summarize_column(column = "LogClass_AS_ActivityFormat",
#                                      directory = "ex-data/datavyu_output_07-06-2020_14-46",
#                                      what = "duration")
#
# duration_summary_by_file <- summarize_column(column = "LogClass_AS_ActivityFormat",
#                                              directory = "ex-data/datavyu_output_07-06-2020_14-46",
#                                              what = "duration",
#                                              by_file = TRUE)
#
# p1 <- plot_duration(duration_summary)
#
# p2 <- plot_duration(duration_summary)
#
# test_that("plot-duration-works", {
#   expect_is(p1, "gg")
# })
#
# test_that("plot-duration-by-file-works", {
#   expect_is(p2, "gg")
# })
#
