# Livestock Standardized Demonstration Farms (畜禽养殖标准化示范场)

Official lists of livestock standardized demonstration farms designated
by the Ministry of Agriculture and Rural Affairs (MOA). Each row is one
named farm in a given notice year. Only designation lists are included;
re-inspection (复验) lists are not.

## Usage

``` r
PubXmjStandard
```

## Format

A data frame:

- year:

  character. Business year of the notice (not the gazette year).

- index:

  character. Sequence number within the annual designation table.

- area_name:

  character. Province name as printed (short form, e.g. 天津, 内蒙古).
  新疆生产建设兵团 is recoded to 新疆.

- prod_name:

  character. Livestock type as printed; not rewritten to historical
  aliases.

- com_name:

  character. Farm or enterprise name as printed.

## Source

Ministry of Agriculture and Rural Affairs of China, Animal Husbandry and
Veterinary Bureau notices, <https://www.moa.gov.cn>.

## Details

Coverage starts in 2010. There is no 2012 gazette in the source files.
Years 2010–2020 were tidied from HTML/Word/Excel notices; years
2021–2023 are expanded from YAML intermediates
(`data-raw/public-site/moa-xmj-standard/yaml/`) by
`code-scrape-standard.R`. Package data are written by
`wfl-PubXmjStandard.R`. This is the current dataset. The 2010–2020
snapshot
[PubStandardXmj](https://huhuaping.github.io/techme/reference/PubStandardXmj.md)
is deprecated and will be removed later.

## Examples

``` r
str(PubXmjStandard)
#> 'data.frame':    3968 obs. of  5 variables:
#>  $ year     : chr  "2023" "2023" "2023" "2023" ...
#>  $ index    : chr  "1" "2" "3" "4" ...
#>  $ area_name: chr  "天津" "天津" "河北" "河北" ...
#>  $ prod_name: chr  "蛋鸡" "蛋鸡" "蛋鸡" "蛋鸡" ...
#>  $ com_name : chr  "天津市滨海新区大港港泰鑫晁蛋鸡养殖场" "天津金亚麻农业科技有限公司" "保定兴芮农牧发展有限公司" "曲周县北农大禽业有限公司" ...
```
