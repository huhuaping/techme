# RD Expenditure by Funding Source by Region

This dataset contains statistics on Research and Development (RD)
internal expenditure by funding source and region. The data is extracted
from the China Statistical Yearbook on Science and Technology, covering
all provinces and regions in China.

## Usage

``` r
RDSource
```

## Format

A data frame:

- province:

  character. Province name, including national total.

- year:

  integer. Year of the statistics, starting from 2010.

- chn_block4:

  character. Variable name in Chinese (e.g., "Total", "Government
  Funds", "Enterprise Funds", "Foreign Funds", "Other Funds").

- value:

  numeric. The statistical value in 10,000 yuan.

- units:

  character. Units of measurement (10,000 yuan).

- variables:

  character. Variable name in coded format.

## Source

China Statistical Yearbook on Science and Technology, National Bureau of
Statistics of China

## Details

- The dataset covers RD internal expenditure by funding source from 2010
  to the latest available year.

- Funding sources include government funds, enterprise funds, foreign
  funds, and other funds.

- Data is in long format for easy analysis and visualization.

- Values are measured in 10,000 yuan (wan yuan).

## Examples

``` r
# View the structure of the dataset
str(RDSource)
#> 'data.frame':    2208 obs. of  6 variables:
#>  $ province  : chr  "全国" "全国" "全国" "全国" ...
#>  $ year      : chr  "2023" "2023" "2023" "2023" ...
#>  $ chn_block4: chr  "合计" "政府资金" "企业资金" "国外资金" ...
#>  $ value     : num  3.34e+08 5.69e+07 2.64e+08 1.11e+06 1.11e+07 ...
#>  $ units     : chr  "万元" "万元" "万元" "万元" ...
#>  $ variables : chr  "v4_zh_nbzc_hj" "v4_zh_nbzc_zfzj" "v4_zh_nbzc_qyzj" "v4_zh_nbzc_gwzj" ...
# Filter data for government funds in 2023
RDSource[RDSource$year == 2023 & RDSource$chn_block4 == "Government Funds", ]
#> [1] province   year       chn_block4 value      units      variables 
#> <0 rows> (or 0-length row.names)
```
