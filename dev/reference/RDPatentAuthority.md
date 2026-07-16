# Domestic Patent Grants by Region

This dataset contains statistics on domestic patent grants by region,
including three types of patents: inventions, utility models, and
designs. The data is extracted from the China Statistical Yearbook on
Science and Technology, covering all provinces and regions in China.

## Usage

``` r
RDPatentAuthority
```

## Format

A data frame:

- province:

  character. Province name, including national total.

- year:

  character. Year of the statistics.

- chn_block4:

  character. Patent type in Chinese (e.g., "Total", "Invention",
  "Utility Model", "Design").

- value:

  numeric. Number of patent grants.

- units:

  character. Units of measurement (pieces/cases).

- variables:

  character. Variable name in coded format.

## Source

China Statistical Yearbook on Science and Technology, National Bureau of
Statistics of China

## Details

- The dataset covers domestic patent grants by region from 2010 to the
  latest available year.

- Patent types include invention patents, utility model patents, and
  design patents.

- Data is in long format for easy analysis and visualization.

- Values represent the number of patents granted.

## Examples

``` r
# View the structure of the dataset
str(RDPatentAuthority)
#> 'data.frame':    1792 obs. of  6 variables:
#>  $ province  : chr  "全国" "全国" "全国" "全国" ...
#>  $ year      : chr  "2023" "2023" "2023" "2023" ...
#>  $ chn_block4: chr  "合计" "发明" "实用新型" "外观设计" ...
#>  $ value     : num  3532282 819234 2084664 628384 193973 ...
#>  $ units     : chr  "件" "件" "件" "件" ...
#>  $ variables : chr  "v4_cg_zlsq2_hj" "v4_cg_zlsq2_fm" "v4_cg_zlsq2_syxx" "v4_cg_zlsq2_wgsj" ...
# Filter data for invention patents in 2023
RDPatentAuthority[RDPatentAuthority$year == "2023" &
    RDPatentAuthority$chn_block4 == "Invention", ]
#> [1] province   year       chn_block4 value      units      variables 
#> <0 rows> (or 0-length row.names)
```
