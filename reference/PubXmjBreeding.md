# National Core Livestock Breeding Farms (国家畜禽核心育种场)

Official lists of national core livestock breeding farms, elite
multiplier farms, and core sire stations, compiled from public notices
of the Ministry of Agriculture and Rural Affairs (MOA). Each row is one
named unit in a given notice year and notice category.

## Usage

``` r
PubXmjBreeding
```

## Format

A data frame:

- year:

  character. Business year of the notice (not the gazette year).

- index:

  character. Sequence number within the source table.

- province:

  character. Province name in reduced Chinese.

- type:

  character. Farm type as printed in the notice (e.g. national pig /
  beef cattle / sheep / broiler / layer core farm or elite multiplier
  farm). Kept verbatim; not rewritten to historical aliases.

- name_origin:

  character. Unit name; for rename notices, the former name.

- name_change:

  character. New unit name on rename notices; missing when the name did
  not change.

- mark:

  character. Notice category: 遴选公示, 核验通过, 资格取消, or 名称变更.
  From 2021 onward, 核验通过 is used; 2024 "增补" maps to 遴选公示.

## Source

Ministry of Agriculture and Rural Affairs of China, Seed Industry
Management Department notices, <https://www.moa.gov.cn>.

## Details

Coverage starts in 2010. Years 2010–2020 were tidied from HTML gazette
tables; years 2021 onward are expanded from YAML intermediates
(`data-raw/public-site/moa-xmj-breeding/yaml/`) by
`code-scrape-breeding.R`. Package data are written by
`wfl-PubXmjBreeding.R`. This is the current dataset. The 2010–2020
snapshot
[PubBreedingXmj](https://huhuaping.github.io/techme/reference/PubBreedingXmj.md)
is deprecated and will be removed later.

## Examples

``` r
str(PubXmjBreeding)
#> 'data.frame':    610 obs. of  7 variables:
#>  $ year       : chr  "2024" "2024" "2024" "2024" ...
#>  $ index      : chr  "1" "2" "1" "2" ...
#>  $ province   : chr  "北京" "江西" "河北" "黑龙江" ...
#>  $ type       : chr  "国家生猪核心育种场" "国家生猪核心育种场" "国家奶牛核心育种场" "国家奶牛核心育种场" ...
#>  $ name_origin: chr  "北京六马大好河山农牧科技有限公司" "江西裕隆牧业有限公司" "乐源君邦牧业威县有限公司" "北安农垦长鑫牧场专业合作社" ...
#>  $ name_change: chr  NA NA NA NA ...
#>  $ mark       : chr  "遴选公示" "遴选公示" "遴选公示" "遴选公示" ...
table(PubXmjBreeding$mark)
#> 
#> 名称变更 核验通过 资格取消 遴选公示 
#>       79      113       43      375 
```
