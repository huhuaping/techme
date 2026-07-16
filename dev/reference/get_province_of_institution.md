# Helper Function to match and get province of target institution

Helper Function to match and get province of target institution

## Usage

``` r
get_province_of_institution(df, target_institution, target_province)
```

## Arguments

- df, :

  data frame, contains the target institution column

- target_institution, :

  character, the column name of target institution

- target_province, :

  character, the target output column name for province variable.

## Value

out

## Examples

``` r
library(magrittr)
utils::data("PubObsStation",package = "techme")
tbl_read <- PubObsStation %>%
  dplyr::select(-province)

tbl_out <- get_province_of_institution(df = tbl_read,
  target_institution ="institution",
  target_province = "province")

head(tbl_out)
#>   officer year index                                                       name
#> 1    MOST 2021     1                 甘肃甘南草原生态系统国家野外科学观测研究站
#> 2    MOST 2021     2                 吉林松嫩草地生态系统国家野外科学观测研究站
#> 3    MOST 2021     3     江苏南京长三角大气过程与环境变化国家野外科学观测研究站
#> 4    MOST 2021     4             福建台湾海峡海洋生态系统国家野外科学观测研究站
#> 5    MOST 2021     5 上海长三角区域生态环境变化与综合治理国家野外科学观测研究站
#> 6    MOST 2021     6             甘肃庆阳草地农业生态系统国家野外科学观测研究站
#>    institution            administrator province
#> 1     兰州大学 教育部、甘肃省科学技术厅     甘肃
#> 2 东北师范大学                   教育部     吉林
#> 3     南京大学 教育部、江苏省科学技术厅     江苏
#> 4     厦门大学 教育部、福建省科学技术厅     福建
#> 5 上海交通大学                   教育部     上海
#> 6     兰州大学 教育部、甘肃省科学技术厅     甘肃
```
