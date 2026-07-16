# National Integrated Seed Production and Marketing Firms in China

This dataset contains the official list of integrated seed production
and marketing firms ("Yufantu" enterprises) in China, as published by
the National Seed Industry Big Data Platform. The data is collected via
API queries and includes license and company information for all valid
integrated seed firms across provinces and years.

## Usage

``` r
PubSeedFirm
```

## Format

A data frame:

- date_upto:

  character. The date (YYYY-MM-DD) up to which the data is valid or
  updated.

- province:

  character. Province name in simplified Chinese.

- label:

  character. Administrative region label (e.g., city or province name).

- id:

  character. Administrative region code (e.g., province or city code).

- type:

  character. Administrative level (e.g., province, city, county).

- LicenceNo:

  character. Official license number for seed production and marketing.

- ApplyCompanyName:

  character. Name of the licensed company.

- PrinterProductionManageCrops:

  character. Crops covered by the license.

- IssuingAuthorityCaption:

  character. Name of the issuing authority.

- InitialPublishDate:

  Date. Date of initial license issuance.

- PublishDate:

  Date. Date of current license publication.

- ExpireDate:

  Date. License expiration date.

- licence_type:

  character. Type of license (e.g., integrated, production, marketing).

## Source

National Seed Industry Big Data Platform, Ministry of Agriculture and
Rural Affairs of China (http://202.127.42.47:6010/XKSite/Home/Index)

## Details

- The dataset covers all valid integrated seed production and marketing
  firms in China, as of the latest update.

- Data is collected via API from the National Seed Industry Big Data
  Platform.

- License and company information is standardized for cross-region
  analysis.

## Examples

``` r
# View the structure of the dataset
str(PubSeedFirm)
#> tibble [451 × 13] (S3: tbl_df/tbl/data.frame)
#>  $ date_upto                   : chr [1:451] "2024-12-31" "2024-12-31" "2024-12-31" "2024-12-31" ...
#>  $ province                    : chr [1:451] "北京" "北京" "北京" "北京" ...
#>  $ label                       : chr [1:451] "北京市" "北京市" "北京市" "北京市" ...
#>  $ id                          : chr [1:451] "110000" "110000" "110000" "110000" ...
#>  $ type                        : chr [1:451] "province" "province" "province" "province" ...
#>  $ LicenceNo                   : chr [1:451] "A(京)农种许字(2020)第0001号" "A(京)农种许字(2022)第0001号" "A(京)农种许字(2017)第0009号" "A(京)农种许字(2017)第0004号" ...
#>  $ ApplyCompanyName            : chr [1:451] "北京大京九农业开发有限公司" "北京丰度高科种业有限公司" "北京华农伟业种子科技股份有限公司" "北京金色农华种业科技股份有限公司" ...
#>  $ PrinterProductionManageCrops: chr [1:451] "玉米" "玉米" "玉米" "稻" ...
#>  $ IssuingAuthorityCaption     : chr [1:451] "北京市" "北京市" "北京市" "北京市" ...
#>  $ InitialPublishDate          : Date[1:451], format: "2020-01-17" "2022-10-19" ...
#>  $ PublishDate                 : Date[1:451], format: "2020-01-17" "2024-07-29" ...
#>  $ ExpireDate                  : Date[1:451], format: "2025-01-16" "2027-10-18" ...
#>  $ licence_type                : chr [1:451] "A" "A" "A" "A" ...
# Count the number of firms by province
table(PubSeedFirm$province)
#> 
#>   上海   云南 内蒙古   北京   吉林   四川   天津   安徽   山东   山西   广东 
#>      9      2     16     31     24     23      1     33     47     20     12 
#>   广西   新疆   江苏   江西   河北   河南   浙江   海南   湖北   湖南   甘肃 
#>      9     11     20     24     29     30      4      6     16     18     22 
#>   福建   贵州   辽宁   重庆   陕西 黑龙江 
#>      9      1      8      6      7     13 
```
