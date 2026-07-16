# Plant Variety Rights by Region

This dataset contains statistics on agricultural plant variety rights
applications and grants by region. The data is extracted from the China
Statistical Yearbook on Science and Technology, covering all provinces
and regions in China.

## Usage

``` r
RDPlantVariety
```

## Format

A data frame:

- province:

  character. Province name, including national total.

- year:

  character. Year of the statistics.

- chn_block4:

  character. Type of plant variety right in Chinese (e.g.,
  "Application", "Grant").

- value:

  numeric. Number of plant variety rights.

- units:

  character. Units of measurement (pieces/cases).

- variables:

  character. Variable name in coded format.

## Source

China Statistical Yearbook on Science and Technology, National Bureau of
Statistics of China

## Details

- The dataset covers agricultural plant variety rights applications and
  grants by region from 2010 to the latest available year.

- Plant variety rights include both applications and granted rights for
  new agricultural plant varieties.

- Data is in long format for easy analysis and visualization.

- Values represent the number of plant variety rights applications or
  grants.

- Year 2019 is not available due to the data missing in the Year Book.

## Examples

``` r
# View the structure of the dataset
str(RDPlantVariety)
#> 'data.frame':    792 obs. of  6 variables:
#>  $ province  : chr  "全国" "北京" "天津" "河北" ...
#>  $ year      : chr  "2023" "2023" "2023" "2023" ...
#>  $ chn_block4: chr  "申请" "申请" "申请" "申请" ...
#>  $ value     : num  13880 1296 136 580 253 ...
#>  $ units     : chr  "件" "件" "件" "件" ...
#>  $ variables : chr  "v4_cg_zwxpz_sq" "v4_cg_zwxpz_sq" "v4_cg_zwxpz_sq" "v4_cg_zwxpz_sq" ...
# Filter data for applications in 2023
RDPlantVariety[RDPlantVariety$year == "2023" &
    RDPlantVariety$chn_block4 == "Application", ]
#> [1] province   year       chn_block4 value      units      variables 
#> <0 rows> (or 0-length row.names)
```
