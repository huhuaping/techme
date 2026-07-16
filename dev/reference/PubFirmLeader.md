# National Key Leading Enterprises in Agricultural Industrialization

A unified dataset containing the official lists of National Key Leading
Enterprises in Agricultural Industrialization, as published by the
Ministry of Agriculture and Rural Affairs of China. The dataset covers
all batches, annual updates, and monitoring-qualified enterprises, with
standardized enterprise names and province information for cross-year
and cross-batch analysis.

## Usage

``` r
PubFirmLeader
```

## Format

A data frame:

- year:

  integer. The year of official announcement or approval.

- batch:

  integer. The batch number or monitoring round. `99` means the full
  listing from the yearly update webpage. other numbers means the batch
  number.

- index:

  integer. The ordered index within the list.

- name:

  character. The name of the enterprise.

- province:

  character. The province where the enterprise is located (in simplified
  Chinese.

## Source

Ministry of Agriculture and Rural Affairs of China, Department of Rural
Industry Development (http://www.xccys.moa.gov.cn/) and official public
notices.

## Details

- The dataset includes all available batches and annual updates of the
  National Key Leading Enterprises in Agricultural Industrialization
  from 2000 to present.

- Enterprise names and province information have been standardized for
  consistency.

- Data collection and processing details can be found in the package
  vignette and data-raw scripts.

## Examples

``` r
# View the structure of the dataset
str(PubFirmLeader)
#> 'data.frame':    6513 obs. of  5 variables:
#>  $ year    : num  2025 2025 2025 2025 2025 ...
#>  $ batch   : num  99 99 99 99 99 99 99 99 99 99 ...
#>  $ index   : num  1 2 3 4 5 6 7 8 9 10 ...
#>  $ name    : chr  "北京大北农科技集团股份有限公司" "北京金色农华种业科技股份有限公司" "北京市华都峪口禽业有限责任公司" "北京德青源农业科技股份有限公司" ...
#>  $ province: chr  "北京" "北京" "北京" "北京" ...
# Count the number of enterprises by province
table(PubFirmLeader$province)
#> 
#>   上海   云南 内蒙古   北京   吉林   四川   天津   宁夏   安徽   山东   山西 
#>     78    203    200    137    205    321     72     88    285    429    145 
#>   广东   广西   新疆   江苏   江西   河北   河南   浙江   海南   湖北   湖南 
#>    291    166    251    331    233    272    344    248     71    277    271 
#>   甘肃   福建   西藏   贵州   辽宁   重庆   陕西   青海 黑龙江 
#>    151    254     52    179    247    168    186     84    274 
```
