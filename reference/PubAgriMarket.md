# MOA Designated Wholesale Markets (农业农村部定点市场)

Official lists of wholesale markets designated by the Ministry of
Agriculture and Rural Affairs (MOA), and markets whose designation was
withdrawn. Each row is one named market in a given notice year. The two
annexes share the same columns and are distinguished by `type`.

## Usage

``` r
PubAgriMarket
```

## Format

A data frame:

- year:

  integer. Official notice year.

- type:

  character. Controlled vocabulary: 认定名单 or 取消名单.

- province:

  character. Province name in reduced Chinese. 新疆生产建设兵团 is
  recoded to 新疆.

- index:

  integer. Sequence number within that year's annex.

- name:

  character. Market name as printed.

## Source

Ministry of Agriculture and Rural Affairs of China notices,
<https://www.moa.gov.cn>.

## Details

Coverage is the two published review notices currently collected: 2018
(农市发〔2018〕6号) and 2024 (农市发〔2024〕2号). Intermediate YAML
lives in `data-raw/public-site/moa-agri-market/yaml/` and is expanded by
`code-moa-agri-market-yaml.R`. Package data are written by
`wfl-PubAgriMarket.R`.

## Examples

``` r
str(PubAgriMarket)
#> 'data.frame':    1782 obs. of  5 variables:
#>  $ year    : int  2024 2024 2024 2024 2024 2024 2024 2024 2024 2024 ...
#>  $ type    : chr  "认定名单" "认定名单" "认定名单" "认定名单" ...
#>  $ province: chr  "北京" "北京" "北京" "北京" ...
#>  $ index   : int  1 2 3 4 5 6 7 8 9 10 ...
#>  $ name    : chr  "北京新发地农产品股份有限公司（北京新发地农副产品批发市场中心）" "北京大洋路农副产品市场有限公司" "北京锦绣大地农副产品批发市场有限责任公司" "北京大红门京深海鲜批发市场有限公司" ...
table(PubAgriMarket$year, PubAgriMarket$type)
#>       
#>        取消名单 认定名单
#>   2018      194      745
#>   2024      180      663
```
