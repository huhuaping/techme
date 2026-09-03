# MOA Agricultural Modernization Demonstration Zones (农业现代化示范区)

Official lists of counties (cities, districts) designated to create
national agricultural modernization demonstration zones, compiled from
public notices of the Ministry of Agriculture and Rural Affairs (MOA).
Each row is one named unit in a given notice year.

## Usage

``` r
PubAgrimodernZone
```

## Format

A data frame:

- year:

  integer. Official notice / designation year.

- index:

  integer. Sequence number within that year's list.

- name:

  character. County (city, district) name as printed.

- province:

  character. Province name in reduced Chinese.

## Source

Ministry of Agriculture and Rural Affairs of China, Development Planning
Department, <https://www.moa.gov.cn>.

## Details

Coverage currently collected:

- 2021 first batch (农规发〔2021〕14号).

- 2022 second batch.

- 2023 (农规发〔2023〕13号).

- 2026 proposed list (公示拟批准创建名单). 2024 and 2025 notices have
  not been published.

HTML notices are parsed by `code-moa-agrimodern-zone.R`. Package data
are written by `wfl-PubAgrimodernZone.R` from
`data-raw/data-tidy/public-site/moa-agrimodern-zone/xlsx/`.

## Examples

``` r
str(PubAgrimodernZone)
#> 'data.frame':    356 obs. of  4 variables:
#>  $ year    : int  2026 2026 2026 2026 2026 2026 2026 2026 2026 2026 ...
#>  $ index   : int  1 2 3 4 5 6 7 8 9 10 ...
#>  $ name    : chr  "北京市昌平区" "天津市静海区" "河北省唐山市曹妃甸区" "河北省邱县" ...
#>  $ province: chr  "北京" "天津" "河北" "河北" ...
table(PubAgrimodernZone$year)
#> 
#> 2021 2022 2023 2026 
#>  100  100  100   56 
```
