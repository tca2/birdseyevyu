library(datavyu)

out_frequency <- summarize_column(column = "LogClass_AS_ActivityFormat",
                                  directory = "ex-data/datavyu_output_07-06-2020_14-46")

out_frequency_known_output <- data.frame(
  stringsAsFactors = FALSE,
  LogClass_AS_ActivityFormat.code01 = c("l","sp","a","o","aw",
                                        "class discussion?","class discussion? lecture?",
                                        "l??"),
  n = c(7, 7, 2, 2, 1, 1, 1, 1),
  percent = c(0.318181818181818,0.318181818181818,
              0.0909090909090909,0.0909090909090909,
              0.0454545454545455,0.0454545454545455,
              0.0454545454545455,0.0454545454545455)
)

out_duration <- summarize_column(column = "LogClass_AS_ActivityFormat",
                                 directory = "ex-data/datavyu_output_07-06-2020_14-46",
                                 what = "duration")

out_duration_known_output <- data.frame(
  stringsAsFactors = FALSE,
  NA,
  LogClass_AS_ActivityFormat.code01 = c("a","aw",
                                        "class discussion?",
                                        "class discussion? lecture?","l","l??","o",
                                        "sp"),
  sum_duration = c("00:27:16:305",
                   "00:10:08:256",
                   "00:20:39:356",
                   "00:04:20:950",
                   "00:52:00:316","00:06:06:588",
                   "00:13:01:093",
                   "00:25:18:250")
)

test_that("summarize-column-frequency-works-var1", {
  expect_equal(out_frequency$LogClass_AS_ActivityFormat.code01,
               out_frequency_known_output$LogClass_AS_ActivityFormat.code01)
})

test_that("summarize-column-frequency-works-var2", {
  expect_equal(out_frequency$n,
               out_frequency_known_output$n)
})


test_that("summarize-column-frequency-works-var3", {
  expect_equal(out_frequency$percent,
               out_frequency_known_output$percent)
})

test_that("summarize-column-duration-works-var1", {
  expect_equal(out_duration$LogClass_AS_ActivityFormat.code01,
               out_duration_known_output$LogClass_AS_ActivityFormat.code01)
})

test_that("summarize-column-duration-works-var2", {
  expect_equal(out_duration$n,
               out_duration_known_output$n)
})

test_that("summarize-column-duration-works-var3", {
  expect_equal(out_duration$percent,
               out_duration_known_output$percent)
})

