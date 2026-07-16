# Valid Domestic Patents by Region

This dataset contains statistics on valid domestic patents by region,
including three types of patents: inventions, utility models, and
designs. The data is extracted from the China Statistical Yearbook on
Science and Technology, covering all provinces and regions in China.

## Usage

``` r
RDPatentValid
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

  numeric. Number of valid patents.

- units:

  character. Units of measurement (pieces/cases).

- variables:

  character. Variable name in coded format.

## Source

China Statistical Yearbook on Science and Technology, National Bureau of
Statistics of China

## Details

- The dataset covers valid domestic patents by region from 2010 to the
  latest available year.

- Patent types include invention patents, utility model patents, and
  design patents.

- Data is in long format for easy analysis and visualization.

- Values represent the number of patents that remain valid and in force.

## Examples

``` r
# View the structure of the dataset
str(RDPatentValid)
#> 'data.frame':    1796 obs. of  6 variables:
#>  $ province  : chr  "全国" "全国" "全国" "全国" ...
#>  $ year      : chr  "2023" "2023" "2023" "2023" ...
#>  $ chn_block4: chr  "合计" "发明" "实用新型" "外观设计" ...
#>  $ value     : num  19279828 4088695 12075757 3115376 1181142 ...
#>  $ units     : chr  "件" "件" "件" "件" ...
#>  $ variables : chr  "v4_cg_zlsyx_hj" "v4_cg_zlsyx_fm" "v4_cg_zlsyx_syxx" "v4_cg_zlsyx_wgsj" ...
# Filter data for invention patents in 2023
RDPatentValid[RDPatentValid$year == "2023" &
    RDPatentValid$chn_block4 == "Invention", ]
#> [1] province   year       chn_block4 value      units      variables 
#> <0 rows> (or 0-length row.names)
```
