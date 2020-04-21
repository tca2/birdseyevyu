
<!-- README.md is generated from README.Rmd. Please edit that file -->

# datavyu

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/datavyu)](https://CRAN.R-project.org/package=datavyu)
<!-- badges: end -->

The goal of datavyu is to to to facilitate the use of the open-source
datavyu software for the analysis of qualitative audiovisual data

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("jrosen48/datavyu")
```

## Use

1.  Run the following Ruby script within the datavyu software; select a
    directory with an `.opf` file:

`csv2opf.rb`

2.  Open the directory that the Ruby script created; a number of CSV
    files for each `.opf` file should now be created.

3.  These CSV files can be loaded like any others (and can be opened in
    Excel); within R, they can easily be a source for visualizations,
    like the following:

![example image](readme-img.png)
