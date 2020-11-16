# context("checking-plot-frequency")
#
# frequency_summary <- summarize_column(column = "LogClass_AS_ActivityFormat",
#                                      directory = "ex-data/datavyu_output_07-06-2020_14-46")
#
# frequency_summary_by_file <- summarize_column(column = "LogClass_AS_ActivityFormat",
#                                              directory = "ex-data/datavyu_output_07-06-2020_14-46",
#                                              by_file = TRUE)
#
# p1 <- plot_frequency(frequency_summary)
#
# p2 <- plot_frequency(frequency_summary)
#
# test_that("plot-frequency-works", {
#   expect_is(p1, "gg")
# })
#
# test_that("plot-frequency-by-file-works", {
#   expect_is(p2, "gg")
# })
#
