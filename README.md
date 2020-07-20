
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

# load in certain columns

``` r
datavyur::import_column("LogClass_AS_ActivityFormat", folder = "example-data/datavyu_output_07-06-2020_14-46") %>% 
  as_tibble()
#> # A tibble: 22 x 12
#>    file  LogClass_AS_Act… LogClass_AS_Act… LogClass_AS_Act… LogClass_AS_Act…
#>    <chr>            <int>            <int>            <int> <chr>           
#>  1 MM T…                1           235026           843282 aw              
#>  2 MM T…                2           611292           640134 l               
#>  3 MM T…                3           817954          1286274 l               
#>  4 MM T…                4           834504          1286274 sp              
#>  5 MM T…                5          1286505          1458831 sp              
#>  6 MM T…                6          1465451          1765071 sp              
#>  7 MM T…                7          1765071          2015937 sp              
#>  8 MM T…                8          2015937          2145396 sp              
#>  9 MM T…                9          2145396          2280828 sp              
#> 10 MM T…               10          2280828                0 l               
#> # … with 12 more rows, and 7 more variables:
#> #   LogClass_AS_ActivityFormat.notesck <chr>,
#> #   LogClass_AS_ActivityFormat.notesed <chr>,
#> #   LogClass_AS_ActivityFormat.notesep <chr>,
#> #   LogClass_AS_ActivityFormat.notesmm <chr>,
#> #   LogClass_AS_ActivityFormat.notesnm <chr>,
#> #   LogClass_AS_ActivityFormat.notesrw <chr>,
#> #   LogClass_AS_ActivityFormat.studentpresentername <chr>

datavyur::import_column("LogClass_AS_ParticipationFormat", folder = "example-data/datavyu_output_07-06-2020_14-46") %>% 
  as_tibble()
#> # A tibble: 10 x 11
#>    file  LogClass_AS_Par… LogClass_AS_Par… LogClass_AS_Par… LogClass_AS_Par…
#>    <chr>            <int>            <int>            <int> <chr>           
#>  1 MM T…                1                0           235025 u               
#>  2 MM T…                2           235026           843282 i               
#>  3 MM T…                3           843282          1286505 s               
#>  4 MM T…                4          1286505          2280828 w               
#>  5 MM T…                5          2280828                0 s               
#>  6 NM 1…                1           119559           254523 u               
#>  7 NM 1…                2           254524           287687 w               
#>  8 NM 1…                3           287687           581059 i               
#>  9 NM T…                1                0           441592 u               
#> 10 NM T…                2           441592           860175 w               
#> # … with 6 more variables: LogClass_AS_ParticipationFormat.notesck <chr>,
#> #   LogClass_AS_ParticipationFormat.notesed <chr>,
#> #   LogClass_AS_ParticipationFormat.notesep <chr>,
#> #   LogClass_AS_ParticipationFormat.notesmm <chr>,
#> #   LogClass_AS_ParticipationFormat.notesnm <chr>,
#> #   LogClass_AS_ParticipationFormat.notesrw <chr>

datavyur::import_column("LogClass_TO_MathPresent", folder = "example-data/datavyu_output_07-06-2020_14-46") %>% 
  as_tibble()
#> # A tibble: 9 x 12
#>   file  LogClass_TO_Mat… LogClass_TO_Mat… LogClass_TO_Mat… LogClass_TO_Mat…
#>   <chr>            <int>            <int>            <int> <chr>           
#> 1 MM T…                1           235026                0 m               
#> 2 NM T…                1           441592           537968 nm              
#> 3 NM T…                2           537968          5747038 m               
#> 4 NM T…                3          5747038          5964552 nm              
#> 5 NM 1…                1           254524           279658 <NA>            
#> 6 NM 1…                2           279658          4344319 <NA>            
#> 7 NM 1…                3          4344319          4395810 <NA>            
#> 8 NM 1…                4          4395810          4710766 <NA>            
#> 9 NM 1…                5          4710766          4808853 <NA>            
#> # … with 7 more variables: LogClass_TO_MathPresent.mathpresentcode <chr>,
#> #   LogClass_TO_MathPresent.notesck <chr>,
#> #   LogClass_TO_MathPresent.notesed <chr>,
#> #   LogClass_TO_MathPresent.notesep <chr>,
#> #   LogClass_TO_MathPresent.notesmm <chr>,
#> #   LogClass_TO_MathPresent.notesnm <chr>,
#> #   LogClass_TO_MathPresent.notesrw <chr>

datavyur::import_column("LogClass_IS", folder = "example-data/datavyu_output_07-06-2020_14-46") %>% 
  as_tibble()
#> # A tibble: 4 x 12
#>   file  LogClass_IS.ord… LogClass_IS.ons… LogClass_IS.off… LogClass_IS.cod…
#>   <chr>            <int>            <int>            <int> <chr>           
#> 1 NM 1…                1                0           254524 ni              
#> 2 MM T…                1           235026                0 <NA>            
#> 3 NM T…                1           441592          5931279 <NA>            
#> 4 NM T…                2          5931279          5964552 <NA>            
#> # … with 7 more variables: LogClass_IS.i <chr>, LogClass_IS.notesck <chr>,
#> #   LogClass_IS.notesed <chr>, LogClass_IS.notesep <chr>,
#> #   LogClass_IS.notesmm <chr>, LogClass_IS.notesnm <chr>,
#> #   LogClass_IS.notesrw <chr>
```

# Calculating code frequencies

Finds the code column automatically

``` r
calc_frequencies(column = "LogClass_AS_ActivityFormat",
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

calc_frequencies(column = "LogClass_AS_ActivityFormat",
                 folder = "example-data/datavyu_output_07-06-2020_14-46",
                 by_file = TRUE)
#>                              file LogClass_AS_ActivityFormat.code01 n   percent
#>      MM T102 14-02-17 Content Log                                aw 1 0.1000000
#>      MM T102 14-02-17 Content Log                                 l 3 0.3000000
#>      MM T102 14-02-17 Content Log                                sp 6 0.6000000
#>  NM 14-12-03 T201 Content Log v.3                                 a 1 0.3333333
#>  NM 14-12-03 T201 Content Log v.3                                 l 1 0.3333333
#>  NM 14-12-03 T201 Content Log v.3                                 o 1 0.3333333
#>  NM T401 14-11-21 Content Log v.2                                 a 1 0.1111111
#>  NM T401 14-11-21 Content Log v.2                 class discussion? 1 0.1111111
#>  NM T401 14-11-21 Content Log v.2        class discussion? lecture? 1 0.1111111
#>  NM T401 14-11-21 Content Log v.2                                 l 3 0.3333333
#>  NM T401 14-11-21 Content Log v.2                               l?? 1 0.1111111
#>  NM T401 14-11-21 Content Log v.2                                 o 1 0.1111111
#>  NM T401 14-11-21 Content Log v.2                                sp 1 0.1111111

calc_frequencies(column = "LogClass_TO_MathPresent",
                 folder = "example-data/datavyu_output_07-06-2020_14-46")
#>   LogClass_TO_MathPresent.code01 n   percent valid_percent
#> 1                           <NA> 5 0.5555556            NA
#> 2                              m 2 0.2222222           0.5
#> 3                             nm 2 0.2222222           0.5

calc_frequencies(column = "LogClass_IS",
                 folder = "example-data/datavyu_output_07-06-2020_14-46")
#>   LogClass_IS.code01 n percent valid_percent
#> 1               <NA> 3    0.75            NA
#> 2                 ni 1    0.25             1
```

# Calculate duration

``` r
calc_duration(column = "LogClass_TO_MathPresent",
          folder = "example-data/datavyu_output_07-06-2020_14-46")
#> # A tibble: 3 x 2
#>   LogClass_TO_MathPresent.code01 sum_duration
#>   <chr>                          <chr>       
#> 1 m                              01:30:44:096
#> 2 nm                             00:05:13:890
#> 3 <NA>                           01:15:54:329

calc_duration(column = "LogClass_TO_MathPresent",
          folder = "example-data/datavyu_output_07-06-2020_14-46", by_file = FALSE)
#> # A tibble: 3 x 2
#>   LogClass_TO_MathPresent.code01 sum_duration
#>   <chr>                          <chr>       
#> 1 m                              01:30:44:096
#> 2 nm                             00:05:13:890
#> 3 <NA>                           01:15:54:329
```

## Other packages

We note that there is another R package that provides an interface to
**datavyu;** that package is
[{datavyur}](https://github.com/iamamutt/datavyu).

``` r
library(datavyur)

datavyu_col_search(folder = "example-data/datavyu_output_07-06-2020_14-46", cnames = "column")

?datavyur::multi_merge()
```

At this time, we are using this package in an experimental sense, and
recommend those looking for a more-developed package consider using
{datavyur} instead of this package.
