
<!-- README.md is generated from README.Rmd. Please edit that file -->

# datavyu

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/datavyu)](https://CRAN.R-project.org/package=datavyu)
<!-- badges: end -->

The goal of {datavyu} is to to to facilitate the use of the open-source
**datavyu** software for the analysis of qualitative audiovisual data

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jrosen48/datavyu")
```

The datavyu software must also be installed; see
[here](https://datavyu.org/download.html)

## Use

``` r
library(dplyr)
library(datavyur)
```

*note*: The use of this package requires the use of the **datavyu**
software’s [Ruby API](https://datavyu.org/user-guide/api.html); note
that while **datavyu** has a graphical user interface, it is accompanied
by a number of Ruby scripts.

1.  . Run the following Ruby script within the datavyu software by
    selecting Script and then Run Script; select a directory with one or
    more `.opf` files:

`csv2opf.rb`

<!-- I ran this on the Empirical Analyses folder to generate a bunch of data -->

2.  Open the directory that the Ruby script created; a number of CSV
    files for each `.opf` file should now be created.

# Grab all of the files for one code:

``` r
# find_unique_values("example-data/datavyu_output_07-06-2020_14-46", what = "codes")[1]

f <- datavyur::datavyu_col_search(folder = "example-data/datavyu_output_07-06-2020_14-46") %>% as_tibble()

f$column %>% unique()
#> [1] "LogClass_AS_ActivityFormat"      "LogClass_AS_ParticipationFormat"
#> [3] "LogClass_IG"                     "LogClass_TO_MathPresent"        
#> [5] "LogClass_IS"                     "LogNotes"                       
#> [7] "LogClass_TaskUsed"
f$file %>% unique()
#> [1] "MM T102 14-02-17 Content Log"     "NM 14-12-03 T201 Content Log v.3"
#> [3] "NM T401 14-11-21 Content Log v.2"
```

# Summarizing a column

``` r
summarize_column(column = "LogClass_AS_ActivityFormat",
                folder = "example-data/datavyu_output_07-06-2020_14-46")
#>   LogClass_AS_ActivityFormat.code01 n    percent
#> 1                                 l 7 0.31818182
#> 2                                sp 7 0.31818182
#> 3                                 a 2 0.09090909
#> 4                                 o 2 0.09090909
#> 5                                aw 1 0.04545455
#> 6                 class discussion? 1 0.04545455
#> 7        class discussion? lecture? 1 0.04545455
#> 8                               l?? 1 0.04545455

summarize_column(column = "LogClass_AS_ActivityFormat",
                folder = "example-data/datavyu_output_07-06-2020_14-46",
                by_file = TRUE)
#>                                file LogClass_AS_ActivityFormat.code01 n
#> 1      MM T102 14-02-17 Content Log                                aw 1
#> 2      MM T102 14-02-17 Content Log                                 l 3
#> 3      MM T102 14-02-17 Content Log                                sp 6
#> 4  NM 14-12-03 T201 Content Log v.3                                 a 1
#> 5  NM 14-12-03 T201 Content Log v.3                                 l 1
#> 6  NM 14-12-03 T201 Content Log v.3                                 o 1
#> 7  NM T401 14-11-21 Content Log v.2                                 a 1
#> 8  NM T401 14-11-21 Content Log v.2                 class discussion? 1
#> 9  NM T401 14-11-21 Content Log v.2        class discussion? lecture? 1
#> 10 NM T401 14-11-21 Content Log v.2                                 l 3
#> 11 NM T401 14-11-21 Content Log v.2                               l?? 1
#> 12 NM T401 14-11-21 Content Log v.2                                 o 1
#> 13 NM T401 14-11-21 Content Log v.2                                sp 1
#>      percent
#> 1  0.1000000
#> 2  0.3000000
#> 3  0.6000000
#> 4  0.3333333
#> 5  0.3333333
#> 6  0.3333333
#> 7  0.1111111
#> 8  0.1111111
#> 9  0.1111111
#> 10 0.3333333
#> 11 0.1111111
#> 12 0.1111111
#> 13 0.1111111

summarize_column(column = "LogClass_AS_ActivityFormat",
                folder = "example-data/datavyu_output_07-06-2020_14-46",
                by_file = TRUE,
                summarize_what = "duration")
#> # A tibble: 13 x 3
#> # Groups:   LogClass_AS_ActivityFormat.code01 [8]
#>    LogClass_AS_ActivityFormat.code01 file                           sum_duration
#>    <chr>                             <chr>                          <chr>       
#>  1 a                                 NM 14-12-03 T201 Content Log … 00:04:53:373
#>  2 a                                 NM T401 14-11-21 Content Log … 00:22:22:932
#>  3 aw                                MM T102 14-02-17 Content Log   00:10:08:256
#>  4 class discussion?                 NM T401 14-11-21 Content Log … 00:20:39:356
#>  5 class discussion? lecture?        NM T401 14-11-21 Content Log … 00:04:20:950
#>  6 l                                 MM T102 14-02-17 Content Log   00:46:17:990
#>  7 l                                 NM 14-12-03 T201 Content Log … 00:00:08:029
#>  8 l                                 NM T401 14-11-21 Content Log … 00:05:34:297
#>  9 l??                               NM T401 14-11-21 Content Log … 00:06:06:588
#> 10 o                                 NM 14-12-03 T201 Content Log … 00:00:25:134
#> 11 o                                 NM T401 14-11-21 Content Log … 00:12:35:959
#> 12 sp                                MM T102 14-02-17 Content Log   00:23:59:473
#> 13 sp                                NM T401 14-11-21 Content Log … 00:01:18:777
```

# Plot the results of a summary of a column

``` r
plot_frequencies
#> function(objectobject) {
#> 
#>   object
#> 
#> }
#> <environment: namespace:datavyu>
```

## Other package

This package extensively uses
[{datavyur}](https://github.com/iamamutt/datavyu) for preparing the data
for the summary statistic and plotting functions in this package. We do
not intend to duplicate the functionality of that excellent package in
ours; we focus instead on summarizing datavyu output and preparing the
output for use in other analyses.
