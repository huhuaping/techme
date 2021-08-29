
<!-- README.md is generated from README.Rmd. Please edit that file -->

# techme

<!-- badges: start -->
<!-- badges: end -->

The goal of techme is to supply basic data sets and toolsets to generate
research report.

## Installation

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("huhuaping/techme")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
require(techme)
#> 载入需要的程辑包：techme
data("varsList")
head(varsList)
#>        variables   chn_full_name short_chn short_eng  units block1 block2
#> 1  v1_sc_bzmj_dd   播种面积_大豆      <NA>      <NA> 千公顷     v1     sc
#> 2  v1_sc_bzmj_dg   播种面积_稻谷      <NA>      <NA> 千公顷     v1     sc
#> 3  v1_sc_bzmj_dl   播种面积_豆类      <NA>      <NA> 千公顷     v1     sc
#> 4  v1_sc_bzmj_dm   播种面积_大麦      <NA>      <NA> 千公顷     v1     sc
#> 5 v1_sc_bzmj_ggl 播种面积_瓜果类      <NA>      <NA> 千公顷     v1     sc
#> 6  v1_sc_bzmj_gl   播种面积_高粱      <NA>      <NA> 千公顷     v1     sc
#>   block3 block4 chn_block1 chn_block2 chn_block3 chn_block4
#> 1   bzmj     dd       农业       生产   播种面积       大豆
#> 2   bzmj     dg       农业       生产   播种面积       稻谷
#> 3   bzmj     dl       农业       生产   播种面积       豆类
#> 4   bzmj     dm       农业       生产   播种面积       大麦
#> 5   bzmj    ggl       农业       生产   播种面积     瓜果类
#> 6   bzmj     gl       农业       生产   播种面积       高粱
#>                    chn_full    flag source
#> 1   农业;生产;播种面积;大豆 v2018.6   <NA>
#> 2   农业;生产;播种面积;稻谷 v2018.6   <NA>
#> 3   农业;生产;播种面积;豆类 v2018.6   <NA>
#> 4   农业;生产;播种面积;大麦 v2018.6   <NA>
#> 5 农业;生产;播种面积;瓜果类 v2018.6   <NA>
#> 6   农业;生产;播种面积;高粱 v2018.6   <NA>
```

## Data set list and source

### Basic

#### varsList

**`varsList`**：A data set containing all variables and additional
information, such as unit, chn\_name, eng\_name etc., with wide data
format.

-   Totally 16 columns including: variables, chn\_full\_name,
    short\_chn, short\_eng, units, block1, block2, block3, block4,
    chn\_block1, chn\_block2, chn\_block3, chn\_block4, chn\_full, flag,
    source.

-   Totally 586 rows.

``` r
varsList %>%
  sample_n(size = 10) %>%
  kable()
```

| variables                    | chn\_full\_name          | short\_chn   | short\_eng | units    | block1 | block2 | block3 | block4         | chn\_block1  | chn\_block2 | chn\_block3 | chn\_block4              | chn\_full                                            | flag    | source           |
|:-----------------------------|:-------------------------|:-------------|:-----------|:---------|:-------|:-------|:-------|:---------------|:-------------|:------------|:------------|:-------------------------|:-----------------------------------------------------|:--------|:-----------------|
| v3\_stxh\_sl\_nysy           | 农药使用量               | NA           | NA         | 吨       | v3     | stxh   | sl     | nysy           | 生态         | 生态消耗    | 数量        | 农药使用量               | 生态;生态消耗;数量;农药使用量                        | v2018.6 | NA               |
| v3\_stys\_sl\_jyl            | 降水量                   | NA           | NA         | 亿立方米 | v3     | stys   | sl     | jyl            | 生态         | 生态用水    | 数量        | 降水量                   | 生态;生态用水;数量;降水量                            | v2018.6 | NA               |
| v4\_qy\_nbzc\_syfz           | NA                       | NA           | NA         | 万元     | v4     | qy     | nbzc   | syfz           | 科技         | 企业        | 内部支出    | 试验发展                 | NA                                                   | v2019.8 | NA               |
| v5\_xmtz\_jf\_industry\_yhdk | 产业化经营项目\_银行贷款 | NA           | NA         | 万元     | v5     | xmtz   | jf     | industry\_yhdk | 农业综合开发 | 项目投资    | 经费        | 产业化经营项目\_银行贷款 | 农业综合开发;项目投资\_经费;产业化经营项目\_银行贷款 | v2018.6 | NA               |
| v2\_rk\_bz\_cz               | 城镇\_比重               | NA           | NA         | %        | v2     | rk     | bz     | cz             | 社会         | 人口        | 比重        | 城镇                     | 社会;人口;比重;城镇                                  | v2018.6 | NA               |
| v8\_t1\_zcqc\_zrnc           | NA                       | NA           | NA         | 个       | v8     | t1     | zcqc   | zrnc           | 种畜禽场站   | 表1         | 种畜禽厂    | 种肉牛场                 | NA                                                   | v2021.8 | 中国畜牧兽医年鉴 |
| v4\_zkjj\_sl\_zdxm           | 重点项目                 | NA           | NA         | 项数     | v4     | zkjj   | sl     | zdxm           | 科技         | 自科基金    | 数量        | 重点项目                 | 科技;自科基金;数量;重点项目                          | v2018.6 | NA               |
| v6\_cz\_yszc\_kxjs           | NA                       | 科学技术支出 | scitech    | 亿元     | v6     | cz     | yszc   | kxjs           | 国家统计年鉴 | 财政        | 预算支出    | 科学技术                 | NA                                                   | v2019.8 | 中国统计年鉴     |
| v4\_gx\_RDxm\_jfzc           | NA                       | NA           | NA         | 万元     | v4     | gx     | RDxm   | jfzc           | 科技         | 高校        | RD项目      | 项目经费支出             | NA                                                   | v2019.8 | NA               |
| v4\_zh\_nbzc\_rylwf          | NA                       | NA           | NA         | 万元     | v4     | zh     | nbzc   | rylwf          | 科技         | 综合        | 内部支出    | 人员劳务费               | NA                                                   | v2019.8 | NA               |

#### BasicProvince

**`BasicProvince`**：A data set containing basic information of province
and its region, with wide data format.

-   Totally 3 columns including: id, province, region\_pro.

-   Totally 32 rows.

``` r
BasicProvince %>%
  sample_n(size = 10) %>%
  kable()
```

|  id | province | region\_pro |
|----:|:---------|:------------|
|  24 | 贵州     | 非旱区      |
|  25 | 云南     | 非旱区      |
|  20 | 广西     | 非旱区      |
|  19 | 广东     | 非旱区      |
|  27 | 陕西     | 旱区        |
|   8 | 黑龙江   | 旱区        |
|  29 | 青海     | 旱区        |
|  30 | 宁夏     | 旱区        |
|   5 | 内蒙古   | 旱区        |
|  12 | 安徽     | 非旱区      |

#### ProvinceCity

**`ProvinceCity`**：A data set containing Province and City of china.

-   Totally 6 columns including: index, province, city, id,
    province\_clean, city\_clean.

-   Totally 342 rows.

``` r
ProvinceCity %>%
  sample_n(size = 10) %>%
  kable()
```

| index | province         | city                   | id           | province\_clean | city\_clean |
|------:|:-----------------|:-----------------------|:-------------|:----------------|:------------|
|   134 | 山东省           | 济南市                 | 370100000000 | 山东            | 济南        |
|   252 | 四川省           | 达州市                 | 511700000000 | 四川            | 达州        |
|   127 | 江西省           | 新余市                 | 360500000000 | 江西            | 新余        |
|   232 | 海南省           | 三亚市                 | 460200000000 | 海南            | 三亚        |
|   342 | 新疆维吾尔自治区 | 自治区直辖县级行政区划 | 659000000000 | 新疆            | uncheck     |
|   249 | 四川省           | 眉山市                 | 511400000000 | 四川            | 眉山        |
|    59 | 吉林省           | 延边朝鲜族自治州       | 222400000000 | 吉林            | uncheck     |
|   312 | 甘肃省           | 陇南市                 | 621200000000 | 甘肃            | 陇南        |
|   308 | 甘肃省           | 平凉市                 | 620800000000 | 甘肃            | 平凉        |
|    66 | 黑龙江省         | 伊春市                 | 230700000000 | 黑龙江          | 伊春        |

#### 

**`queryTianyan`**：A data set containing basic info of institution
enrolled in officer administrator.

-   Totally 9 columns including: index, name\_origin, name\_search,
    address, tel, url, province, city, province\_raw.

-   Totally 441 rows.

``` r
AgriMachine %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4        |   value | units  | variables                |
|:---------|:-----|:-------------------|--------:|:-------|:-------------------------|
| 河南     | 2010 | 机收面积           |      NA | 千公顷 | v7\_sctj\_nyjx\_jsmj     |
| 广西     | 2019 | 小型拖拉机         |   53.00 | 万台   | v7\_sctj\_nyjx\_xtlj     |
| 北京     | 2016 | 机播面积           |   81.40 | 千公顷 | v7\_sctj\_nyjx\_jbmj     |
| 贵州     | 2015 | 小型拖拉机配套农具 |    3.01 | 万部   | v7\_sctj\_nyjx\_xtlj\_pt |
| 广西     | 2013 | 节水灌溉类机械     |    7.87 | 万套   | v7\_sctj\_nyjx\_jsgg     |
| 吉林     | 2012 | 农用排灌柴油机     |   26.60 | 万台   | v7\_sctj\_nyjx\_pgcyj    |
| 天津     | 2017 | 农用排灌电动机     |    6.30 | 万台   | v7\_sctj\_nyjx\_pgddj    |
| 四川     | 2019 | 机耕面积           | 5636.70 | 千公顷 | v7\_sctj\_nyjx\_jgmj     |
| 宁夏     | 2014 | 农用排灌柴油机     |    0.47 | 万台   | v7\_sctj\_nyjx\_pgcyj    |
| 西藏     | 2010 | 农业机械总动力     |  378.10 | 万千瓦 | v7\_sctj\_nyjx\_zdl      |

### Yearbook

#### Data from Rural Yearbook

##### AgriMachine

**`AgriMachine`**：A **long format** data set containing Agricultural
Machine statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 4384 rows.

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_nyjx\_dztlj,
    v7\_sctj\_nyjx\_dztlj\_pt, v7\_sctj\_nyjx\_jbmj,
    v7\_sctj\_nyjx\_jdtlj, v7\_sctj\_nyjx\_jgmj, v7\_sctj\_nyjx\_jsgg,
    v7\_sctj\_nyjx\_jsmj, v7\_sctj\_nyjx\_lhshj, v7\_sctj\_nyjx\_nysb,
    v7\_sctj\_nyjx\_pgcyj, v7\_sctj\_nyjx\_pgddj, v7\_sctj\_nyjx\_xtlj,
    v7\_sctj\_nyjx\_xtlj\_pt, v7\_sctj\_nyjx\_zdl

``` r
AgriMachine %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4          |     value | units  | variables                 |
|:---------|:-----|:---------------------|----------:|:-------|:--------------------------|
| 江西     | 2019 | 机播面积             | 1508.8000 | 千公顷 | v7\_sctj\_nyjx\_jbmj      |
| 宁夏     | 2016 | 大中型拖拉机配套农具 |   15.5700 | 万部   | v7\_sctj\_nyjx\_dztlj\_pt |
| 天津     | 2011 | 机耕面积             |        NA | 千公顷 | v7\_sctj\_nyjx\_jgmj      |
| 上海     | 2019 | 小型拖拉机           |    0.2000 | 万台   | v7\_sctj\_nyjx\_xtlj      |
| 西藏     | 2010 | 农用排灌柴油机       |    0.1950 | 万台   | v7\_sctj\_nyjx\_pgcyj     |
| 重庆     | 2014 | 机播面积             |        NA | 千公顷 | v7\_sctj\_nyjx\_jbmj      |
| 内蒙古   | 2012 | 大中型拖拉机         |   57.9400 | 万台   | v7\_sctj\_nyjx\_dztlj     |
| 宁夏     | 2010 | 小型拖拉机           |   17.9866 | 万台   | v7\_sctj\_nyjx\_xtlj      |
| 河北     | 2018 | 农用排灌电动机       |        NA | 万台   | v7\_sctj\_nyjx\_pgddj     |
| 江西     | 2014 | 小型拖拉机           |   30.7600 | 万台   | v7\_sctj\_nyjx\_xtlj      |

##### AgriFertilizer

**`AgriFertilizer`**：A **long format** data set containing Agricultural
Fertilizer statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 448 rows.

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_nyhf\_df, v7\_sctj\_nyhf\_fhf,
    v7\_sctj\_nyhf\_hj, v7\_sctj\_nyhf\_jf, v7\_sctj\_nyhf\_lf

``` r
AgriFertilizer %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |  value | units | variables           |
|:---------|:-----|:------------|-------:|:------|:--------------------|
| 河南     | 2019 | 复合肥      |  331.7 | 万吨  | v7\_sctj\_nyhf\_fhf |
| 辽宁     | 2019 | 复合肥      |   68.0 | 万吨  | v7\_sctj\_nyhf\_fhf |
| 海南     | 2014 | 化肥使用量  |   49.5 | 万吨  | v7\_sctj\_nyhf\_hj  |
| 四川     | 2019 | 复合肥      |   62.1 | 万吨  | v7\_sctj\_nyhf\_fhf |
| 陕西     | 2018 | 化肥使用量  |  229.6 | 万吨  | v7\_sctj\_nyhf\_hj  |
| 山西     | 2013 | 化肥使用量  |  121.0 | 万吨  | v7\_sctj\_nyhf\_hj  |
| 全国     | 2019 | 复合肥      | 2230.7 | 万吨  | v7\_sctj\_nyhf\_fhf |
| 四川     | 2012 | 化肥使用量  |  253.0 | 万吨  | v7\_sctj\_nyhf\_hj  |
| 重庆     | 2013 | 化肥使用量  |   96.6 | 万吨  | v7\_sctj\_nyhf\_hj  |
| 湖南     | 2012 | 化肥使用量  |  249.1 | 万吨  | v7\_sctj\_nyhf\_hj  |

##### AgriPlastic

**`AgriPlastic`**：A **long format** data set containing Agricultural
Plastic statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 960 rows.

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_nybm\_bmsy, v7\_sctj\_nybm\_dmfg,
    v7\_sctj\_nybm\_dmsy

``` r
AgriPlastic %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4    |   value | units | variables            |
|:---------|:-----|:---------------|--------:|:------|:---------------------|
| 吉林     | 2013 | NA             |   28310 | NA    | v7\_sctj\_nybm\_dmsy |
| 云南     | 2012 | NA             |   81866 | NA    | v7\_sctj\_nybm\_dmsy |
| 新疆     | 2019 | 农用薄膜使用量 |  262677 | 吨    | v7\_sctj\_nybm\_bmsy |
| 四川     | 2010 | 农用薄膜使用量 |  114161 | 吨    | v7\_sctj\_nybm\_bmsy |
| 甘肃     | 2010 | NA             |   73968 | NA    | v7\_sctj\_nybm\_dmsy |
| 河南     | 2019 | 地膜使用量     |   66059 | 吨    | v7\_sctj\_nybm\_dmsy |
| 内蒙古   | 2016 | NA             | 1279544 | NA    | v7\_sctj\_nybm\_dmfg |
| 吉林     | 2017 | NA             |   29874 | NA    | v7\_sctj\_nybm\_dmsy |
| 宁夏     | 2010 | NA             |    7970 | NA    | v7\_sctj\_nybm\_dmsy |
| 贵州     | 2010 | 农用薄膜使用量 |   36174 | 吨    | v7\_sctj\_nybm\_bmsy |

##### AgriPesticide

**`AgriPesticide`**：A **long format** data set containing Agricultural
Pesticide statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 352 rows.

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_cyny\_cysy, v7\_sctj\_cyny\_nysy

``` r
AgriPesticide %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4    |    value | units | variables            |
|:---------|:-----|:---------------|---------:|:------|:---------------------|
| 山西     | 2015 | 农药使用量     |  31035.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 四川     | 2017 | 农药使用量     |  55751.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 辽宁     | 2016 | 农药使用量     |  56264.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 天津     | 2011 | 农药使用量     |   3796.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 河北     | 2016 | 农药使用量     |  81691.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 陕西     | 2012 | 农药使用量     |  12952.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 天津     | 2019 | 农用柴油使用量 |      2.1 | 万吨  | v7\_sctj\_cyny\_cysy |
| 江苏     | 2012 | 农药使用量     |  83675.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 甘肃     | 2010 | 农药使用量     |  44565.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 湖南     | 2016 | 农药使用量     | 118661.0 | 吨    | v7\_sctj\_cyny\_nysy |

#### Data from Sci-Tech Yearbook

##### RDIntense

**`RDIntense`**：A **long format** data set containing R&D Intense
statistics.

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 576 rows.

-   Years range from 2011 to 2019

-   Variables including: v4\_ztr\_jf\_RD, v4\_ztr\_qd\_RD

``` r
RDIntense %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |   value | units | variables       |
|:---------|:-----|:------------|--------:|:------|:----------------|
| 贵州     | 2015 | RD经费      |   62.30 | 亿元  | v4\_ztr\_jf\_RD |
| 宁夏     | 2011 | RD经费      |   15.30 | 亿元  | v4\_ztr\_jf\_RD |
| 河北     | 2015 | RD强度      |    1.18 | %     | v4\_ztr\_qd\_RD |
| 浙江     | 2015 | RD强度      |    2.36 | %     | v4\_ztr\_qd\_RD |
| 广东     | 2014 | RD强度      |    2.37 | %     | v4\_ztr\_qd\_RD |
| 河南     | 2017 | RD强度      |    1.31 | %     | v4\_ztr\_qd\_RD |
| 云南     | 2011 | RD强度      |    0.63 | %     | v4\_ztr\_qd\_RD |
| 山东     | 2015 | RD经费      | 1427.20 | 亿元  | v4\_ztr\_jf\_RD |
| 福建     | 2012 | RD强度      |    1.38 | %     | v4\_ztr\_qd\_RD |
| 新疆     | 2012 | RD经费      |   39.70 | 亿元  | v4\_ztr\_jf\_RD |

##### RDActivity

**`RDActivity`**：A **long format** data set containing R&D Activity
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 1280 rows.

-   Years range from 2010 to 2019

-   Variables including: v4\_zh\_nbzc\_hj, v4\_zh\_nbzc\_jcyj,
    v4\_zh\_nbzc\_syfz, v4\_zh\_nbzc\_yyyj

``` r
RDActivity %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |     value | units | variables          |
|:---------|:-----|:------------|----------:|:------|:-------------------|
| 广西     | 2012 | 合计        |  971538.7 | 万元  | v4\_zh\_nbzc\_hj   |
| 宁夏     | 2019 | 应用研究    |   58445.0 | 万元  | v4\_zh\_nbzc\_yyyj |
| 甘肃     | 2010 | 基础研究    |   56508.5 | 万元  | v4\_zh\_nbzc\_jcyj |
| 四川     | 2012 | 应用研究    |  714028.8 | 万元  | v4\_zh\_nbzc\_yyyj |
| 湖北     | 2019 | 试验发展    | 7952681.0 | 万元  | v4\_zh\_nbzc\_syfz |
| 广西     | 2015 | 基础研究    |  108295.7 | 万元  | v4\_zh\_nbzc\_jcyj |
| 吉林     | 2012 | 合计        | 1098010.4 | 万元  | v4\_zh\_nbzc\_hj   |
| 江西     | 2012 | 合计        | 1136551.9 | 万元  | v4\_zh\_nbzc\_hj   |
| 江苏     | 2018 | 应用研究    | 1386829.9 | 万元  | v4\_zh\_nbzc\_yyyj |
| 山西     | 2016 | 应用研究    |  169482.5 | 万元  | v4\_zh\_nbzc\_yyyj |

##### IndustryOperation

**`IndustryOperation`**：A **long format** data set containing Industry
Operation statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 384 rows.

-   Years range from 2015 to 2019

-   Variables including: v4\_cy\_scjy\_lrze, v4\_cy\_scjy\_qys,
    v4\_cy\_scjy\_zyyw

``` r
IndustryOperation %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4  |       value | units   | variables          |
|:---------|:-----|:-------------|------------:|:--------|:-------------------|
| 陕西     | 2019 | 企业数       |   683.00000 | 个      | v4\_cy\_scjy\_qys  |
| 安徽     | 2019 | 利润总额     |   217.00000 | 个,亿元 | v4\_cy\_scjy\_lrze |
| 内蒙古   | 2015 | 主营业务收入 |   394.31603 | 亿元    | v4\_cy\_scjy\_zyyw |
| 山东     | 2016 | 主营业务收入 | 12263.47706 | 亿元    | v4\_cy\_scjy\_zyyw |
| 甘肃     | 2016 | 主营业务收入 |   196.12500 | 亿元    | v4\_cy\_scjy\_zyyw |
| 云南     | 2016 | 利润总额     |    43.44322 | 亿元    | v4\_cy\_scjy\_lrze |
| 辽宁     | 2018 | 主营业务收入 |  1825.00000 | 个,亿元 | v4\_cy\_scjy\_zyyw |
| 广西     | 2015 | 企业数       |   313.00000 | 个      | v4\_cy\_scjy\_qys  |
| 广东     | 2018 | 利润总额     |  2342.00000 | 个,亿元 | v4\_cy\_scjy\_lrze |
| 宁夏     | 2016 | 主营业务收入 |   176.35070 | 亿元    | v4\_cy\_scjy\_zyyw |

##### IndustryRD

**`IndustryRD`**：A **long format** data set containing Industry R&D
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 2176 rows.

-   Years range from 2016 to 2019

-   Variables including: v4\_cy\_cytz\_gdzc, v4\_cy\_cytz\_jcxm,
    v4\_cy\_cytz\_kgxm, v4\_cy\_cytz\_sgxm, v4\_cy\_cytz\_tzze,
    v4\_cy\_jsgz\_gmzc, v4\_cy\_jsgz\_gzzc, v4\_cy\_jsgz\_xszc,
    v4\_cy\_jsgz\_yjzc, v4\_cy\_qyzl\_fms, v4\_cy\_qyzl\_sqs,
    v4\_cy\_qyzl\_yxs, v4\_cy\_RDhd\_nbzc, v4\_cy\_RDhd\_qsdl,
    v4\_cy\_RDhd\_xmjf, v4\_cy\_RDhd\_xmsl, v4\_cy\_RDhd\_yfjgs,
    v4\_cy\_xcp\_ck, v4\_cy\_xcp\_kfjf, v4\_cy\_xcp\_kfxm,
    v4\_cy\_xcp\_xssr

``` r
IndustryRD %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4      |    value | units | variables          |
|:---------|:-----|:-----------------|---------:|:------|:-------------------|
| 安徽     | 2016 | 开发项目数       |   3290.0 | 项    | v4\_cy\_xcp\_kfxm  |
| 天津     | 2018 | 专利申请数       |   2459.0 | 件    | v4\_cy\_qyzl\_sqs  |
| 天津     | 2018 | 技术引进经费支出 |  30156.0 | 万元  | v4\_cy\_jsgz\_yjzc |
| 贵州     | 2017 | 出口             |  40681.2 | 万元  | v4\_cy\_xcp\_ck    |
| 天津     | 2018 | 发明专利         |   1069.0 | 万元  | v4\_cy\_qyzl\_fms  |
| 湖南     | 2019 | 开发项目数       |   4751.0 | 项    | v4\_cy\_xcp\_kfxm  |
| 山东     | 2018 | 技术改造经费支出 | 406693.0 | 万元  | v4\_cy\_jsgz\_gzzc |
| 内蒙古   | 2016 | 出口             |  41206.4 | 万元  | v4\_cy\_xcp\_ck    |
| 内蒙古   | 2016 | 技术引进经费支出 |      4.7 | 万元  | v4\_cy\_jsgz\_yjzc |
| 甘肃     | 2016 | 人员折合全时当量 |   1727.5 | 人年  | v4\_cy\_RDhd\_qsdl |

##### IndustryTrade

**`IndustryTrade`**：A **long format** data set containing Industry
Trade statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 288 rows.

-   Years range from 2016 to 2018

-   Variables including: v4\_cy\_my\_ck, v4\_cy\_my\_jck, v4\_cy\_my\_jk

``` r
IndustryTrade %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |       value | units    | variables       |
|:---------|:-----|:------------|------------:|:---------|:----------------|
| 湖南     | 2017 | 进口贸易额  |   2394.6562 | 百万美元 | v4\_cy\_my\_jk  |
| 吉林     | 2017 | 出口贸易额  |    294.2069 | 百万美元 | v4\_cy\_my\_ck  |
| 海南     | 2018 | 贸易总额    |   3666.0000 | 百万美元 | v4\_cy\_my\_jck |
| 天津     | 2018 | 贸易总额    |  44666.0000 | 百万美元 | v4\_cy\_my\_jck |
| 甘肃     | 2016 | 出口贸易额  |    502.2520 | 百万美元 | v4\_cy\_my\_ck  |
| 北京     | 2018 | 出口贸易额  |  15031.0000 | 百万美元 | v4\_cy\_my\_ck  |
| 山西     | 2018 | 进口贸易额  |   4050.0000 | 百万美元 | v4\_cy\_my\_jk  |
| 湖南     | 2017 | 贸易总额    |   5767.6617 | 百万美元 | v4\_cy\_my\_jck |
| 内蒙古   | 2018 | 贸易总额    |   1405.0000 | 百万美元 | v4\_cy\_my\_jck |
| 全国     | 2018 | 出口贸易额  | 743044.0000 | 百万美元 | v4\_cy\_my\_ck  |

##### MarketPull

**`MarketPull`**：A **long format** data set containing Tech Market Pull
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 704 rows.

-   Years range from 2000 to 2019

-   Variables including: v4\_cg\_jssr\_ht, v4\_cg\_jssr\_je

``` r
MarketPull %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |      value | units | variables        |
|:---------|:-----|:------------|-----------:|:------|:-----------------|
| 江苏     | 2018 | 金额        | 14386429.9 | 万元  | v4\_cg\_jssr\_je |
| 内蒙古   | 2010 | 金额        |   862604.8 | 万元  | v4\_cg\_jssr\_je |
| 全国     | 2013 | 数量        |   294929.0 | 项    | v4\_cg\_jssr\_ht |
| 上海     | 2013 | 金额        |  4319822.0 | 万元  | v4\_cg\_jssr\_je |
| 广西     | 2010 | 金额        |   148141.1 | 万元  | v4\_cg\_jssr\_je |
| 福建     | 2012 | 金额        |  1897946.6 | 万元  | v4\_cg\_jssr\_je |
| 广西     | 2005 | 数量        |     1382.0 | 项    | v4\_cg\_jssr\_ht |
| 全国     | 2013 | 金额        | 74691253.7 | 万元  | v4\_cg\_jssr\_je |
| 重庆     | 2019 | 数量        |     6243.0 | 项    | v4\_cg\_jssr\_ht |
| 甘肃     | 2015 | 金额        |  1181036.2 | 万元  | v4\_cg\_jssr\_je |

##### MarketPush

**`MarketPush`**：A **long format** data set containing Tech Market Push
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 704 rows.

-   Years range from 2000 to 2019

-   Variables including: v4\_cg\_jssc\_ht, v4\_cg\_jssc\_je

``` r
MarketPush %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |       value | units | variables        |
|:---------|:-----|:------------|------------:|:------|:-----------------|
| 陕西     | 2018 | 数量        |    37954.00 | 项    | v4\_cg\_jssc\_ht |
| 贵州     | 2016 | 数量        |      974.00 | 项    | v4\_cg\_jssc\_ht |
| 天津     | 2017 | 数量        |    12168.00 | 项    | v4\_cg\_jssc\_ht |
| 天津     | 2019 | 数量        |    13885.00 | 项    | v4\_cg\_jssc\_ht |
| 北京     | 2017 | 金额        | 44868872.02 | 万元  | v4\_cg\_jssc\_je |
| 云南     | 2015 | 数量        |     2666.00 | 项    | v4\_cg\_jssc\_ht |
| 新疆     | 2017 | 数量        |      468.00 | 项    | v4\_cg\_jssc\_ht |
| 西藏     | 2015 | 数量        |          NA | 项    | v4\_cg\_jssc\_ht |
| 海南     | 2005 | 金额        |    10006.64 | 万元  | v4\_cg\_jssc\_je |
| 广西     | 2016 | 数量        |     1832.00 | 项    | v4\_cg\_jssc\_ht |

#### Data from China National Yearbook

##### PublicBudget

**`PublicBudget`**：A **long format** data set containing Public Budget
statistics.

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 1244 rows.

-   Years range from 2010 to 2019

-   Variables including: v6\_cz\_yszc\_hj, v6\_cz\_yszc\_jy,
    v6\_cz\_yszc\_kxjs, v6\_cz\_yszc\_nls

#### Data from Livestock Yearbook

``` r
PublicBudget %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |     value | units | variables          |
|:---------|:-----|:------------|----------:|:------|:-------------------|
| 贵州     | 2015 | 合计        | 3939.5000 | 亿元  | v6\_cz\_yszc\_hj   |
| 辽宁     | 2019 | 教育        |  702.3800 | 亿元  | v6\_cz\_yszc\_jy   |
| 安徽     | 2017 | 教育        | 1014.9069 | 亿元  | v6\_cz\_yszc\_jy   |
| 河南     | 2018 | 合计        | 9217.7300 | 亿元  | v6\_cz\_yszc\_hj   |
| 西藏     | 2019 | 教育        |  263.2600 | 亿元  | v6\_cz\_yszc\_jy   |
| 重庆     | 2014 | 教育        |  469.9807 | 亿元  | v6\_cz\_yszc\_jy   |
| 西藏     | 2019 | 农林水      |  445.0100 | 亿元  | v6\_cz\_yszc\_nls  |
| 福建     | 2011 | 科学技术    |   40.4800 | 亿元  | v6\_cz\_yszc\_kxjs |
| 四川     | 2017 | 农林水      | 1023.1290 | 亿元  | v6\_cz\_yszc\_nls  |
| 甘肃     | 2015 | 教育        |  498.3300 | 亿元  | v6\_cz\_yszc\_jy   |

**`LivestockBreeding`**：A **long format** data set containing Livestock
Breeding statistics.

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 20672 rows.

-   Years range from 2011 to 2017

-   Variables including: v8\_t1\_zcqc\_zhnc, v8\_t1\_zcqc\_zmc,
    v8\_t1\_zcqc\_zmsyc, v8\_t1\_zcqc\_zmyc, v8\_t1\_zcqc\_znc,
    v8\_t1\_zcqc\_znnc1, v8\_t1\_zcqc\_znnc2, v8\_t1\_zcqc\_zrnc,
    v8\_t1\_zcqc\_zs, v8\_t1\_zcqc\_zsnc, v8\_t1\_zcqc\_zsyc,
    v8\_t1\_zcqc\_zxmyc, v8\_t1\_zcqc\_zyc, v8\_t1\_zcqc\_zzc,
    v8\_t2\_zcqc\_fmddjc, v8\_t2\_zcqc\_fmdrjc, v8\_t2\_zcqc\_qt,
    v8\_t2\_zcqc\_zdjc, v8\_t2\_zcqc\_zdjysdjc,
    v8\_t2\_zcqc\_zdjysrjc（top 20 of totally 98 variables.

### Public site

#### Data from MOST

Several data set sources from Ministry of Sci-Tech (MOST).

##### PubNKRDP

**`PubNKRDP`**：A **wide format** data set containing Details of
National Key R&D Plans(NKRDP) statistics.

-   Totally 17 columns including: year, date, NO, index, title,
    institution, chairman, funds, type, duration, NO\_head, NO\_year,
    NO\_mark, NO\_num, NO\_num\_p1, NO\_num\_p2, NO\_tail.

-   Totally 2579 rows.

-   Years range from 2018 to 2020

``` r
PubNKRDP %>%
  sample_n(size = 10) %>%
  kable()
```

| year | date     | NO              | index | title                                                          | institution                        | chairman | funds | type                                                            | duration | NO\_head | NO\_year | NO\_mark | NO\_num | NO\_num\_p1 | NO\_num\_p2 | NO\_tail |
|:-----|:---------|:----------------|:------|:---------------------------------------------------------------|:-----------------------------------|:---------|:------|:----------------------------------------------------------------|:---------|:---------|:---------|:---------|:--------|:------------|:------------|:---------|
| 2018 | 20191015 | 2018YFB0604300  | 190   | 燃煤发电机组水分高效低成本回收及处理关键技术研究与应用         | 华北电力大学                       | 陈海平   | 1764  | 煤炭清洁高效利用和新型节能技术                                  | NA       |          | 2018     | YFB      | 0604300 | 06          | 04300       | NA       |
| 2018 | 20191015 | 2018YFB1501100  | 1072  | 风力发电复杂风资源特性研究及其应用与验证                       | 国家气候中心                       | 朱蓉     |       | 可再生能源与氢能技术                                            | NA       |          | 2018     | YFB      | 1501100 | 15          | 01100       | NA       |
| 2018 | 20191015 | 2018YFC1406900  | 527   | 综合基因、地质和空间信息技术的南极企鹅物种演化和栖息地变迁研究 | 中国科学院动物研究所               | 张德兴   | 1609  | 海洋环境安全保障                                                | NA       |          | 2018     | YFC      | 1406900 | 14          | 06900       | NA       |
| 2018 | 20191015 | 2018YFB1502800  | 1089  | 风电场、光伏电站生态气候效应和环境影响评价研究                 | 中国科学院寒区旱区环境与工程研究所 | 高晓清   |       | 可再生能源与氢能技术                                            | NA       |          | 2018     | YFB      | 1502800 | 15          | 02800       | NA       |
| 2020 | 20201127 | 2020YFC1521500  | 1     | 以泥河湾盆地为重点的华北早期人类演化与适应研究                 | 中国科学院古脊椎动物与古人类研究所 | NA       | NA    | 重大自然灾害监测预警与防范”重点专项（文化遗产保护利用专题任务） | NA       |          | 2020     | YFC      | 1521500 | 15          | 21500       | NA       |
| 2018 | 20191015 | 2018YFC1704700  | 1000  | 中医“治未病辨识方法与干预技术的示范研究                        | 长春中医药大学                     | 冷向阳   | 1184  | 中医药现代化研究                                                | NA       |          | 2018     | YFC      | 1704700 | 17          | 04700       | NA       |
| 2020 | 20201127 | 2020YFB2010100  | 166   | 高可靠核电循环泵用齿轮箱关键技术研究与示范应用                 | 重庆齿轮箱有限责任公司             | NA       | NA    | 制造基础技术与关键部件                                          | NA       |          | 2020     | YFB      | 2010100 | 20          | 10100       | NA       |
| 2020 | 20201127 | 2020YFA0308900  | 333   | 低维本征磁性材料的拓扑态调控与器件探索                         | 南方科技大学                       | NA       | NA    | 量子调控与量子信息                                              | NA       |          | 2020     | YFA      | 0308900 | 03          | 08900       | NA       |
| 2018 | 20191015 | SQ2018YFC010140 | 417   | 基于国产创新设备的消化道早癌筛查和宫颈癌诊疗应用示范研究       | 华中科技大学同济医学院附属协和医院 | 谢明星   | 1888  | 数字诊疗装备研发                                                | NA       | SQ       | 2018     | YFC      | 010140  | 01          | 0140        | NA       |
| 2018 | 20191015 | 2018YFB1701300  | 1120  | 制造系统在线工艺规划与产线重构软件工具                         | 西安交通大学                       | 洪军     |       | 网络协同制造与智能工厂                                          | NA       |          | 2018     | YFB      | 1701300 | 17          | 01300       | NA       |

##### PubAgriParkList

**`PubAgriParkList`**：A **wide format** data set containing Details of
Approved List of National Agricultural Sci-tech Park.

-   Totally 4 columns including: index, batch, name, province.

-   Totally 233 rows.

-   Years (Batch) range from 01 to 09

``` r
PubAgriParkList %>%
  sample_n(size = 10) %>%
  kable()
```

| index | batch | name                     | province |
|------:|:------|:-------------------------|:---------|
|    12 | 05    | 湖北荆州国家农业科技园区 | 湖北     |
|    41 | 06    | 新疆塔城国家农业科技园区 | 新疆     |
|    10 | 02    | 山西太原国家农业科技园区 | 山西     |
|    19 | 09    | 重庆武隆国家农业科技园区 | 重庆     |
|    11 | 01    | 山东寿光农业科技园区     | 山东     |
|     8 | 09    | 江苏响水国家农业科技园区 | 江苏     |
|    14 | 02    | 陕西渭南国家农业科技园区 | 陕西     |
|    23 | 08    | 重庆铜梁国家农业科技园区 | 重庆     |
|    22 | 08    | 广西玉林国家农业科技园区 | 广西     |
|    13 | 07    | 重庆长寿国家农业科技园区 | 重庆     |

##### PubAgriParkEval

**`PubAgriParkEval`**：A **wide format** data set containing Details of
Evaluation result of National Agricultural Sci-tech Park.

-   Totally 5 columns including: year, index, name, result, province.

-   Totally 162 rows.

-   Years range from 2019 to 2020

``` r
PubAgriParkEval %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | name                         | result | province |
|-----:|------:|:-----------------------------|:-------|:---------|
| 2019 |     4 | 河南濮阳国家农业科技园区     | fail   | 河南     |
| 2019 |     1 | 北京昌平国家农业科技园区     | good   | 北京     |
| 2019 |    53 | 海南三亚国家农业科技园区     | ok     | 海南     |
| 2019 |    62 | 云南昆明石林国家农业科技园区 | ok     | 云南     |
| 2019 |    12 | 辽宁辉山国家农业科技园区     | ok     | 辽宁     |
| 2019 |    39 | 河南许昌国家农业科技园区     | ok     | 河南     |
| 2019 |    49 | 广东珠海国家农业科技园区     | ok     | 广东     |
| 2019 |    64 | 西藏日喀则国家农业科技园区   | ok     | 西藏     |
| 2020 |    12 | 河南兰考国家农业科技园区     | ok     | 河南     |
| 2020 |    29 | 新疆塔城国家农业科技园区     | ok     | 新疆     |

#### Data from MOA or MOE

Several data set sources from Ministry of Agriculture (MOA) or Ministry
of Education (MOE).

##### PubObsStation

**`PubObsStation`**：A **wide format** data set containing Details of
Evaluation result of National Agricultural Sci-tech Details list of
Observe Stations of MOA and MOE.

-   Totally 6 columns including: officer, year, index, name,
    institution, province.

-   Totally 158 rows.

-   Years range from 2018 to 2019

<!---CARS from MOA---->

``` r
data("PubCars")
```

**`PubCars`**：A **wide format** data set containing Details of China
Agricultural Research System(CARS) from MOA.

-   Totally 16 columns including: year, index, area\_num\_eng,
    area\_name, chairman\_industry, institution\_industry, func\_num,
    func\_name, func\_inst, func\_director, researcher\_area,
    researcher\_name, researcher\_inst, province\_industry,
    province\_func, province\_researcher.

-   Totally 1691 rows.

-   Years range from 2011 to 2021

``` r
PubObsStation %>%
  sample_n(size = 10) %>%
  kable()
```

| officer | year | index | name                                                 | institution                      | province |
|:--------|-----:|:------|:-----------------------------------------------------|:---------------------------------|:---------|
| MOA     | 2018 | 20    | 国家种质资源红原观测实验站                           | 四川省草原科学研究院             | 四川     |
| MOA     | 2019 | 12    | 国家农业科学植物保护临沂观测实验站                   | 中国农业科学院蔬菜花卉研究所     | 北京     |
| MOA     | 2018 | 26    | 国家土壤质量进贤观测实验站                           | 江西省红壤研究所                 | 江西     |
| MOE     | 2019 | 19    | 云南香格里拉高原复合生态系统教育部野外科学观测研究站 | 华中师范大学                     | 湖北     |
| MOA     | 2018 | 6     | 国家种质资源管城观测实验站                           | 中国农业科学院郑州果树研究所     | 河南     |
| MOE     | 2019 | 45    | 浙江舟山群岛海洋生态系统教育部野外科学观测研究站     | 浙江大学                         | 浙江     |
| MOA     | 2018 | 10    | 国家渔业资源环境大鹏观测实验站                       | 中国水产科学研究院南海水产研究所 | 广东     |
| MOA     | 2018 | 33    | 国家土壤质量公主岭观测实验站                         | 吉林省农业科学院                 | 吉林     |
| MOA     | 2019 | 24    | 国家农业科学农业环境建三江观测实验站                 | 黑龙江农垦科学院                 | 黑龙江   |
| MOE     | 2019 | 46    | 三峡库区地质灾害教育部野外科学观测研究站             | 中国地质大学(武汉)               | 湖北     |

##### PubBreedingXmj

**`PubBreedingXmj`**：A **wide format** data set containing details of
Officer’ Livestock Breeding List from MOA (Xmj).

-   Totally 7 columns including: year, index, province, type,
    name\_origin, name\_change, mark.

-   Totally 287 rows.

-   Years range from 2010 to 2020

``` r
PubBreedingXmj %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | province | type               | name\_origin                   | name\_change             | mark     |
|:-----|:------|:---------|:-------------------|:-------------------------------|:-------------------------|:---------|
| 2012 | 6     | 山东     | 国家生猪核心育种场 | 潍坊江海原种猪场               | NA                       | 遴选公示 |
| 2015 | 6     | 安徽     | 国家生猪核心育种场 | 安徽绿健种猪有限公司           | NA                       | 遴选公示 |
| 2014 | 2     | 北京     | 国家蛋鸡核心育种场 | 北京市华都峪口家禽育种有限公司 | NA                       | 遴选公示 |
| 2015 | 14    | 海南     | 国家肉鸡核心育种场 | 海南罗牛山文昌鸡育种有限公司   | NA                       | 遴选公示 |
| 2012 | 3     | 安徽     | 国家生猪核心育种场 | 安徽大自然种猪育种有限公司     | NA                       | 遴选公示 |
| 2014 | 5     | 安徽     | 国家蛋鸡核心育种场 | 安徽荣达禽业开发有限公司       | NA                       | 遴选公示 |
| 2011 | 13    | 四川     | 国家生猪核心育种场 | 四川省天兆畜牧科技有限公司     | NA                       | 遴选公示 |
| 2020 | 1     | 河北     | NA                 | 河北省双鸽美丹畜牧科技有限公司 | 河北美丹畜牧科技有限公司 | 名称变更 |
| 2011 | 11    | 广西     | 国家生猪核心育种场 | 广西桂宁种猪有限公司           | NA                       | 遴选公示 |
| 2015 | 8     | 湖北     | 国家肉牛核心育种场 | 随州市弘大畜牧有限责任公司     | NA                       | 遴选公示 |

##### PubStandardXmj

**`PubStandardXmj`**：A **wide format** data set containing details of
Officer’ Livestock Breeding List from MOA (Xmj).

-   Totally 5 columns including: year, index, province, prod\_name,
    com\_name.

-   Totally 3377 rows.

-   Years range from 2010 to 2020

``` r
PubStandardXmj %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | province | prod\_name | com\_name                        |
|:-----|:------|:---------|:-----------|:---------------------------------|
| 2010 | 171   | 河南     | 生猪       | 信阳市平桥区黑马石张兵猪场       |
| 2013 | 229   | 广东     | 生猪       | 江门市新会区鸿利畜牧养殖有限公司 |
| 2011 | 159   | 江苏     | 奶牛       | 苏州市相城区黄埭镇东桥康达牧场   |
| 2020 | 97    | 湖北     | 生猪       | 阳新佳和现代农业有限公司         |
| 2016 | 524   | 青海     | 蛋鸡       | 平安绿雏富硒鸡养殖场             |
| 2015 | 145   | 安徽     | 蛋鸡       | 芜湖都益禽业有限公司             |
| 2015 | 147   | 安徽     | 肉羊       | 安徽安欣（涡阳）牧业发展有限公司 |
| 2016 | 409   | 广东     | 生猪       | 恩平市东骏农业有限公司           |
| 2020 | 34    | 黑龙江   | 生猪       | 鸡东县三德牧业有限责任公司       |
| 2017 | 195   | 浙江     | 生猪       | 桐乡市洲泉嘉华种猪养殖场         |
