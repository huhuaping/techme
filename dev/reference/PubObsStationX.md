# Details list of Observe Stations from departments( MOA/MOE/MOST)

A data set containing list of Observe Stations of Ministry of
Agriculture(MOA) and Ministry of Education (MOE) year by year from the
public MOA site <http://www.moa.gov.cn/> and MOE site
<http://www.moe.gov.cn/> , with wide data format.

## Usage

``` r
PubObsStationX
```

## Format

A data frame:

- id:

  character, paste0 from block3/officer/year

- year:

  integer, year of the document from Ministry site

- officer:

  name of Ministry, MOA/MOE/MOST

- index:

  integer, the ordered index of list

- block3:

  character, variable name from block3

- block4:

  character, variable name from block4, such as
  `name`,`institution`,`administrator`,`province`

- chn_block4:

  character, Chinese name from block4

- value:

  character, value obervered for variables from block4

- variables:

  character, unique variable name coded

## Source

<https://www.huhuaping.com/>
