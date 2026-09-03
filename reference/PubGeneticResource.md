# National Genetic Resource Bases (国家级种质资源库)

Official batch lists of national crop / agricultural-microbe germplasm
banks and national livestock genetic-resource conservation units,
compiled from public notices of the Ministry of Agriculture and Rural
Affairs (MOA). Each row is one named unit in a given notice year and
batch. The two source families share the same columns and are
distinguished by `type`.

## Usage

``` r
PubGeneticResource
```

## Format

A data frame:

- year:

  integer. Official notice / designation year.

- batch:

  character. Two-digit batch number within that source family (crop
  batches and livestock batches are numbered separately).

- type:

  character. Controlled vocabulary combining both source families. Crop
  / microbe: 农作物, 农业微生物. Livestock: 畜禽保种场, 畜禽基因库,
  畜禽保护区, 畜禽变更.

- index:

  integer. Sequence number within the source table.

- name:

  character. Unit name as printed.

- institution:

  character. Supporting / construction institution; for 畜禽变更, the
  new institution.

- province:

  character. Province name in reduced Chinese.

## Source

Ministry of Agriculture and Rural Affairs of China notices,
<https://www.moa.gov.cn>; crop-bank downloads also appear at
<https://ncgrip.cgris.net>.

## Details

Two statistical calibers share this object:

- Crop and agricultural-microbe banks (from 2022): `type` is 农作物 or
  农业微生物. Tidied from year-batch notices by
  `code-moa-genetic-resource.R`.

- Livestock conservation units (from 2021; earlier seven batches
  repealed): `type` is 畜禽保种场, 畜禽基因库, 畜禽保护区, or 畜禽变更.
  Years 2021–2023 are expanded from YAML
  (`data-raw/public-site/moa-genetic-resource/yaml/`) by
  `code-moa-genetic-resource-yaml.R`; from 2024 the livestock annexes
  are published with the crop notices.

Package data are written by `wfl-PubGeneticResource.R`. The full
crop-bank snapshot
[PubGeneticResourceCrop](https://huhuaping.github.io/techme/reference/PubGeneticResourceCrop.md)
is a different caliber (platform list, not year-batch notices).

## Examples

``` r
str(PubGeneticResource)
#> 'data.frame':    358 obs. of  7 variables:
#>  $ year       : int  2025 2025 2025 2025 2025 2025 2025 2025 2025 2025 ...
#>  $ batch      : chr  "04" "04" "04" "05" ...
#>  $ type       : chr  "农作物" "农作物" "农作物" "畜禽基因库" ...
#>  $ index      : int  1 2 3 1 2 3 4 5 6 7 ...
#>  $ name       : chr  "国家野生稻种质资源圃 (三亚)" "国家热带作物种质资源 试管苗库(儋州)" "国家西北黄土高原特色 果树种质资源圃(兰州)" "国家畜禽区域基因库(吉林)" ...
#>  $ institution: chr  "中国农业科学院作物科学研究所(中国农 业科学院南繁育种研究中心)" "中国热带农业科学院热带作物品种资源研究所" "甘肃省农业科学院林果花卉研究所" "吉林省农业科学院(中国农业科技东北创 新中心)" ...
#>  $ province   : chr  "海南" "海南" "甘肃" "吉林" ...
table(PubGeneticResource$type)
#> 
#> 农业微生物     农作物 畜禽保护区 畜禽保种场   畜禽变更 畜禽基因库 
#>         29         81         25        206          1         16 
```
