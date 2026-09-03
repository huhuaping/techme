# MOA Agricultural Sci-tech Demonstration Bases (农业科技试验示范基地)

Official lists of agricultural sci-tech demonstration bases designated
by the Ministry of Agriculture and Rural Affairs (MOA). Each row is one
named base in a given notice year. Two statistical calibers share the
same columns and are distinguished by `source`.

## Usage

``` r
PubAgriTechDemoBase
```

## Format

A data frame:

- year:

  integer. Official notice year.

- index:

  integer. Sequence number within that year's annex (2025 types are
  numbered from 1 within each type).

- source:

  character. Controlled vocabulary: 现代农业科技试验示范基地,
  国家农业科技示范展示基地, or (reserved)
  国家农业科技创新与集成示范基地.

- type:

  character. Industry class for the current caliber: 种植业, 畜牧兽医,
  渔业, 农机, or 资源环境. Missing for the 2020 historical list.

- name:

  character. Base name as printed.

- institution:

  character. Lead / operating institution (牵头单位 in 2025;
  建设运营单位 in 2020).

- province:

  character. Province name in reduced Chinese. 新疆生产建设兵团 is
  recoded to 新疆.

## Source

Ministry of Agriculture and Rural Affairs of China notices,
<https://www.moa.gov.cn>.

## Details

Coverage is the two notices currently collected:

- 2025 current caliber (农科办〔2025〕16号): 现代农业科技试验示范基地,
  first batch, with `type` filled.

- 2020 historical caliber (农办科〔2020〕6号): 国家农业科技示范展示基地,
  with `type` missing. From the 2025 notice onward this title is no
  longer retained.

Intermediate YAML lives in
`data-raw/public-site/moa-agritech-demo-base/yaml/` and is expanded by
`code-moa-agritech-demo-base-yaml.R`. Package data are written by
`wfl-PubAgriTechDemoBase.R`. Joint units (`partners`) in the 2025 notice
are not kept in the tidy table.

## Examples

``` r
str(PubAgriTechDemoBase)
#> 'data.frame':    259 obs. of  7 variables:
#>  $ year       : int  2020 2020 2020 2020 2020 2020 2020 2020 2020 2020 ...
#>  $ index      : int  1 2 3 4 5 6 7 8 9 10 ...
#>  $ source     : chr  "国家农业科技示范展示基地" "国家农业科技示范展示基地" "国家农业科技示范展示基地" "国家农业科技示范展示基地" ...
#>  $ type       : chr  NA NA NA NA ...
#>  $ name       : chr  "国家现代农业科技示范展示基地（昌平）" "国家现代农业科技示范展示基地（通州）" "国家现代农业科技示范展示基地（小汤山）" "国家现代农业科技示范展示基地（顺义）" ...
#>  $ institution: chr  "北京市农业技术推广站" "北京中农富通园艺有限公司" "北京市农林科学院" "中国农业科学院作物科学研究所" ...
#>  $ province   : chr  "北京" "北京" "北京" "北京" ...
table(PubAgriTechDemoBase$year, PubAgriTechDemoBase$source)
#>       
#>        国家农业科技示范展示基地 现代农业科技试验示范基地
#>   2020                      110                        0
#>   2025                        0                      149
```
