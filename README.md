
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
#> 1  v1_sc_bzmj_dd   播种面积_大豆      <NA>      <NA> 千公�?     v1     sc
#> 2  v1_sc_bzmj_dg   播种面积_稻谷      <NA>      <NA> 千公�?     v1     sc
#> 3  v1_sc_bzmj_dl   播种面积_豆类      <NA>      <NA> 千公�?     v1     sc
#> 4  v1_sc_bzmj_dm   播种面积_大麦      <NA>      <NA> 千公�?     v1     sc
#> 5 v1_sc_bzmj_ggl 播种面积_瓜果�?      <NA>      <NA> 千公�?     v1     sc
#> 6  v1_sc_bzmj_gl   播种面积_高粱      <NA>      <NA> 千公�?     v1     sc
#>   block3 block4 chn_block1 chn_block2 chn_block3 chn_block4
#> 1   bzmj     dd       农业       生产   播种面积       大豆
#> 2   bzmj     dg       农业       生产   播种面积       稻谷
#> 3   bzmj     dl       农业       生产   播种面积       豆类
#> 4   bzmj     dm       农业       生产   播种面积       大麦
#> 5   bzmj    ggl       农业       生产   播种面积     瓜果�?
#> 6   bzmj     gl       农业       生产   播种面积       高粱
#>                    chn_full    flag source
#> 1   农业;生产;播种面积;大豆 v2018.6   <NA>
#> 2   农业;生产;播种面积;稻谷 v2018.6   <NA>
#> 3   农业;生产;播种面积;豆类 v2018.6   <NA>
#> 4   农业;生产;播种面积;大麦 v2018.6   <NA>
#> 5 农业;生产;播种面积;瓜果�? v2018.6   <NA>
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
    source�?

-   Totally 586 rows�?


``` r
varsList %>%
  sample_n(size = 10) %>%
  kable()
```

| variables                    | chn\_full\_name          | short\_chn     | short\_eng | units | block1 | block2 | block3 | block4         | chn\_block1  | chn\_block2 | chn\_block3      | chn\_block4               | chn\_full                                            | flag    | source           |
|:-----------------------------|:-------------------------|:---------------|:-----------|:------|:-------|:-------|:-------|:---------------|:-------------|:------------|:-----------------|:--------------------------|:-----------------------------------------------------|:--------|:-----------------|
| v1\_sc\_dcl\_dg              | 每公顷产�?               |                |            |       |        |        |        |                |              |             |                  |                           |                                                      |         |                  |
| \_稻谷                       | NA                       | NA             | 千克       | v1    | sc     | dcl    | dg     | 农业           | 生产         | 单产�?      | 稻谷             | 农业;生产;单产�?;稻谷     | v2018.6                                              | NA      |                  |
| v4\_cg\_jssc\_ht             | NA                       | 输出技术合同数 | pushn      | �?    | v4     | cg     | jssc   | ht             | 科技         | 成果        | 技术输�?         | 数量                      | NA                                                   | v2019.8 | NA               |
| v5\_rwwc\_sl\_industry\_cqyz | 产业化经营项目\_畜禽养殖 | NA             | NA         | 万头  | v5     | rwwc   | sl     | industry\_cqyz | 农业综合开�? | 任务完成    | 数量             | 产业化经营项目\_畜禽养殖  | 农业综合开�?;任务完成\_数量;产业化经营项目\_畜禽养殖 | v2018.6 | NA               |
| v4\_yfqk\_sl\_RDxm           | R&D项目�?                | NA             | NA         | �?    | v4     | yfqk   | sl     | RDxm           | 科技         | 经营情况    | 数量             | R&D项目�?                 | 科技;经营情况;数量;R&D项目�?                         | v2018.6 | NA               |
| v3\_stzl\_bz\_zlGDP          | NA                       | NA             | NA         | %     | v3     | stzl   | bz     | zlGDP          | 生�?         | 生态治�?    | 比重             | 环境污染治理投资占GDP比重 | 生�?;生态治�?;比重;环境污染治理投资占GDP比重         | v2018.6 | NA               |
| v4\_jg\_kjcc\_fmzl           | NA                       | NA             | NA         | �?    | v4     | jg     | kjcc   | fmzl           | 科技         | 机构        | 科技产出         | 发明专利                  | NA                                                   | v2019.8 | NA               |
| v5\_xmtz\_jf\_industry\_zczj | 产业化经营项目\_自筹资金 | NA             | NA         | 万元  | v5     | xmtz   | jf     | industry\_zczj | 农业综合开�? | 项目投资    | 经费             | 产业化经营项目\_自筹资金  | 农业综合开�?;项目投资\_经费;产业化经营项目\_自筹资金 | v2018.6 | NA               |
| v4\_qy\_xcp\_ck              | NA                       | NA             | NA         | 万元  | v4     | qy     | xcp    | ck             | 科技         | 企业        | 新产品开发和销�? | 出口                      | NA                                                   | v2019.8 | NA               |
| v8\_t9\_scjy\_zsyz           | NA                       | NA             | NA         | 万份  | v8     | t9     | scjy   | zsyz           | 种畜禽场�?   | �?9         | 生产精液         | 种公羊站                  | NA                                                   | v2021.8 | 中国畜牧兽医年鉴 |
| v8\_t5\_nmcl\_zgnz           | NA                       | NA             | NA         | �?    | v8     | t5     | nmcl   | zgnz           | 种畜禽场�?   | �?5         | 种畜禽厂         | 种公牛站                  | NA                                                   | v2021.8 | 中国畜牧兽医年鉴 |

#### BasicProvince

**`BasicProvince`**：A data set containing basic information of province
and its region, with wide data format.

-   Totally 3 columns including: id, province, region\_pro�?

-   Totally 32 rows�?

``` r
BasicProvince %>%
  sample_n(size = 10) %>%
  kable()
```

|  id | province | region\_pro |
|----:|:---------|:------------|
|  27 | 陕西     | 旱区        |
|  26 | 西藏     | 旱区        |
|  20 | 广西     | 非旱�?      |
|   5 | 内蒙�?   | 旱区        |
|   8 | 黑龙�?   | 旱区        |
|   4 | 山西     | 旱区        |
|  29 | 青海     | 旱区        |
|  28 | 甘肃     | 旱区        |
|  24 | 贵州     | 非旱�?      |
|  17 | 湖北     | 非旱�?      |

#### ProvinceCity

**`ProvinceCity`**：A data set containing Province and City of china.

-   Totally 6 columns including: index, province, city, id,
    province\_clean, city\_clean�?

-   Totally 342 rows�?

``` r
ProvinceCity %>%
  sample_n(size = 10) %>%
  kable()
```

| index | province         | city                   | id           | province\_clean | city\_clean |
|------:|:-----------------|:-----------------------|:-------------|:----------------|:------------|
|   208 | 广东�?           | 汕尾�?                 | 441500000000 | 广东            | 汕尾        |
|   178 | 湖北�?           | 咸宁�?                 | 421200000000 | 湖北            | 咸宁        |
|   258 | 四川�?           | 凉山彝族自治�?         | 513400000000 | 四川            | uncheck     |
|    13 | 河北�?           | 衡水�?                 | 131100000000 | 河北            | 衡水        |
|   336 | 新疆维吾尔自治区 | 克孜勒苏柯尔克孜自治�? | 653000000000 | 新疆            | uncheck     |
|   169 | 湖北�?           | 黄石�?                 | 420200000000 | 湖北            | 黄石        |
|   213 | 广东�?           | 中山�?                 | 442000000000 | 广东            | 中山        |
|   118 | 福建�?           | 泉州�?                 | 350500000000 | 福建            | 泉州        |
|    84 | 江苏�?           | 镇江�?                 | 321100000000 | 江苏            | 镇江        |
|   259 | 贵州�?           | 贵阳�?                 | 520100000000 | 贵州            | 贵阳        |

#### 

**`queryTianyan`**：A data set containing basic info of institution
enrolled in officer administrator.

-   Totally 9 columns including: index, name\_origin, name\_search,
    address, tel, url, province, city, province\_raw�?

-   Totally 464 rows�?

``` r
AgriMachine %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4          |     value | units  | variables                 |
|:---------|:-----|:---------------------|----------:|:-------|:--------------------------|
| 江苏     | 2013 | 农用排灌电动�?       |   19.2100 | 万台   | v7\_sctj\_nyjx\_pgddj     |
| 广东     | 2018 | 机耕面�?             | 3614.8000 | 千公�? | v7\_sctj\_nyjx\_jgmj      |
| 山东     | 2015 | 大中型拖拉机配套农具 |  190.9300 | 万部   | v7\_sctj\_nyjx\_dztlj\_pt |
| 广西     | 2016 | 机耕面�?             | 4931.6000 | 千公�? | v7\_sctj\_nyjx\_jgmj      |
| 江西     | 2013 | 机耕面�?             |        NA | 千公�? | v7\_sctj\_nyjx\_jgmj      |
| 黑龙�?   | 2015 | 节水灌溉类机�?       |    4.1600 | 万套   | v7\_sctj\_nyjx\_jsgg      |
| 福建     | 2014 | 机动脱粒�?           |   11.0300 | 万台   | v7\_sctj\_nyjx\_jdtlj     |
| 全国     | 2016 | 联合收获�?           |  190.2008 | 万台   | v7\_sctj\_nyjx\_lhshj     |
| 河南     | 2016 | 小型拖拉�?           |  100.7400 | 万台   | v7\_sctj\_nyjx\_xtlj      |
| 北京     | 2015 | 大中型拖拉机配套农具 |    0.1400 | 万部   | v7\_sctj\_nyjx\_dztlj\_pt |

### Yearbook

#### Data from Rural Yearbook

##### AgriMachine

**`AgriMachine`**：A **long format** data set containing Agricultural
Machine statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 4384 rows�?

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

| province | year | chn\_block4    |   value | units  | variables             |
|:---------|:-----|:---------------|--------:|:-------|:----------------------|
| 江苏     | 2012 | 农业机械总动�? | 4214.60 | 万千�? | v7\_sctj\_nyjx\_zdl   |
| 云南     | 2010 | 农用排灌柴油�? |   15.29 | 万台   | v7\_sctj\_nyjx\_pgcyj |
| 甘肃     | 2016 | 机收面积       | 1233.40 | 千公�? | v7\_sctj\_nyjx\_jsmj  |
| 海南     | 2013 | 农业机械总动�? |  502.10 | 万千�? | v7\_sctj\_nyjx\_zdl   |
| 湖北     | 2015 | 农用水泵       |  110.13 | 万台   | v7\_sctj\_nyjx\_nysb  |
| 黑龙�?   | 2019 | 节水灌溉类机�? |    5.90 | 万套   | v7\_sctj\_nyjx\_jsgg  |
| 广西     | 2013 | 农用排灌电动�? |   49.13 | 万台   | v7\_sctj\_nyjx\_pgddj |
| 甘肃     | 2015 | 节水灌溉类机�? |    1.87 | 万套   | v7\_sctj\_nyjx\_jsgg  |
| 北京     | 2018 | 机收面积       |   42.10 | 千公�? | v7\_sctj\_nyjx\_jsmj  |
| 湖南     | 2018 | 农业机械总动�? | 6338.60 | 万千�? | v7\_sctj\_nyjx\_zdl   |

##### AgriFertilizer

**`AgriFertilizer`**：A **long format** data set containing Agricultural
Fertilizer statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 448 rows�?

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_nyhf\_df, v7\_sctj\_nyhf\_fhf,
    v7\_sctj\_nyhf\_hj, v7\_sctj\_nyhf\_jf, v7\_sctj\_nyhf\_lf

``` r
AgriFertilizer %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 | value | units | variables           |
|:---------|:-----|:------------|------:|:------|:--------------------|
| 陕西     | 2019 | 钾肥        |  23.1 | 万吨  | v7\_sctj\_nyhf\_jf  |
| 四川     | 2019 | 钾肥        |  15.8 | 万吨  | v7\_sctj\_nyhf\_jf  |
| 内蒙�?   | 2012 | 化肥使用�?  | 189.0 | 万吨  | v7\_sctj\_nyhf\_hj  |
| 上海     | 2019 | 氮肥        |   3.1 | 万吨  | v7\_sctj\_nyhf\_df  |
| 江苏     | 2016 | 化肥使用�?  | 312.5 | 万吨  | v7\_sctj\_nyhf\_hj  |
| 广东     | 2015 | 化肥使用�?  | 256.5 | 万吨  | v7\_sctj\_nyhf\_hj  |
| 江苏     | 2018 | 化肥使用�?  | 292.5 | 万吨  | v7\_sctj\_nyhf\_hj  |
| 重庆     | 2019 | 复合�?      |  25.7 | 万吨  | v7\_sctj\_nyhf\_fhf |
| 黑龙�?   | 2019 | 化肥使用�?  | 223.3 | 万吨  | v7\_sctj\_nyhf\_hj  |
| 重庆     | 2013 | 化肥使用�?  |  96.6 | 万吨  | v7\_sctj\_nyhf\_hj  |

##### AgriPlastic

**`AgriPlastic`**：A **long format** data set containing Agricultural
Plastic statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 960 rows�?

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
| 云南     | 2017 | NA             |   96235 | NA    | v7\_sctj\_nybm\_dmsy |
| 云南     | 2019 | 地膜覆盖面积   | 1077445 | 公顷  | v7\_sctj\_nybm\_dmfg |
| 四川     | 2017 | NA             |  996719 | NA    | v7\_sctj\_nybm\_dmfg |
| 北京     | 2010 | NA             |   21217 | NA    | v7\_sctj\_nybm\_dmfg |
| 云南     | 2011 | 农用薄膜使用�? |   91229 | �?    | v7\_sctj\_nybm\_bmsy |
| 天津     | 2015 | 农用薄膜使用�? |   10552 | �?    | v7\_sctj\_nybm\_bmsy |
| 西藏     | 2016 | NA             |    5003 | NA    | v7\_sctj\_nybm\_dmfg |
| 青海     | 2012 | NA             |   51307 | NA    | v7\_sctj\_nybm\_dmfg |
| 甘肃     | 2010 | 农用薄膜使用�? |  123712 | �?    | v7\_sctj\_nybm\_bmsy |
| 黑龙�?   | 2013 | NA             |  340163 | NA    | v7\_sctj\_nybm\_dmfg |

##### AgriPesticide

**`AgriPesticide`**：A **long format** data set containing Agricultural
Pesticide statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 352 rows�?

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_cyny\_cysy, v7\_sctj\_cyny\_nysy

``` r
AgriPesticide %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |  value | units | variables            |
|:---------|:-----|:------------|-------:|:------|:---------------------|
| 湖北     | 2015 | 农药使用�?  | 120685 | �?    | v7\_sctj\_cyny\_nysy |
| 贵州     | 2011 | 农药使用�?  |  14469 | �?    | v7\_sctj\_cyny\_nysy |
| 山西     | 2016 | 农药使用�?  |  30550 | �?    | v7\_sctj\_cyny\_nysy |
| 河北     | 2014 | 农药使用�?  |  86329 | �?    | v7\_sctj\_cyny\_nysy |
| 陕西     | 2016 | 农药使用�?  |  13190 | �?    | v7\_sctj\_cyny\_nysy |
| 安徽     | 2015 | 农药使用�?  | 111048 | �?    | v7\_sctj\_cyny\_nysy |
| 青海     | 2016 | 农药使用�?  |   1939 | �?    | v7\_sctj\_cyny\_nysy |
| 内蒙�?   | 2012 | 农药使用�?  |  29924 | �?    | v7\_sctj\_cyny\_nysy |
| 河南     | 2013 | 农药使用�?  | 130058 | �?    | v7\_sctj\_cyny\_nysy |
| 新疆     | 2019 | 农药使用�?  |  22948 | �?    | v7\_sctj\_cyny\_nysy |

#### Data from Sci-Tech Yearbook

##### RDIntense

**`RDIntense`**：A **long format** data set containing R&D Intense
statistics.

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 576 rows�?

-   Years range from 2011 to 2019

-   Variables including: v4\_ztr\_jf\_RD, v4\_ztr\_qd\_RD

``` r
RDIntense %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |  value | units | variables       |
|:---------|:-----|:------------|-------:|:------|:----------------|
| 新疆     | 2018 | RD经费      |  64.30 | 亿元  | v4\_ztr\_jf\_RD |
| 黑龙�?   | 2015 | RD经费      | 157.70 | 亿元  | v4\_ztr\_jf\_RD |
| 辽宁     | 2018 | RD经费      | 460.10 | 亿元  | v4\_ztr\_jf\_RD |
| 新疆     | 2017 | RD经费      |  57.00 | 亿元  | v4\_ztr\_jf\_RD |
| 江西     | 2019 | RD强度      |   1.55 | %     | v4\_ztr\_qd\_RD |
| 内蒙�?   | 2015 | RD强度      |   0.76 | %     | v4\_ztr\_qd\_RD |
| 西藏     | 2011 | RD经费      |   1.20 | 亿元  | v4\_ztr\_jf\_RD |
| 云南     | 2017 | RD强度      |   0.96 | %     | v4\_ztr\_qd\_RD |
| 贵州     | 2015 | RD强度      |   0.59 | %     | v4\_ztr\_qd\_RD |
| 湖北     | 2015 | RD强度      |   1.90 | %     | v4\_ztr\_qd\_RD |

##### RDActivity

**`RDActivity`**：A **long format** data set containing R&D Activity
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 1280 rows�?

-   Years range from 2010 to 2019

-   Variables including: v4\_zh\_nbzc\_hj, v4\_zh\_nbzc\_jcyj,
    v4\_zh\_nbzc\_syfz, v4\_zh\_nbzc\_yyyj

``` r
RDActivity %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |      value | units | variables          |
|:---------|:-----|:------------|-----------:|:------|:-------------------|
| 江苏     | 2014 | 试验发展    | 15120717.0 | 万元  | v4\_zh\_nbzc\_syfz |
| 河北     | 2012 | 试验发展    |  2069345.6 | 万元  | v4\_zh\_nbzc\_syfz |
| 广东     | 2011 | 合计        | 10454871.7 | 万元  | v4\_zh\_nbzc\_hj   |
| 甘肃     | 2019 | 合计        |  1102446.0 | 万元  | v4\_zh\_nbzc\_hj   |
| 广东     | 2015 | 合计        | 17981678.5 | 万元  | v4\_zh\_nbzc\_hj   |
| 北京     | 2016 | 试验发展    |  9253435.2 | 万元  | v4\_zh\_nbzc\_syfz |
| 云南     | 2014 | 试验发展    |   639895.6 | 万元  | v4\_zh\_nbzc\_syfz |
| 河北     | 2019 | 应用研究    |   580123.0 | 万元  | v4\_zh\_nbzc\_yyyj |
| 云南     | 2016 | 应用研究    |   167202.3 | 万元  | v4\_zh\_nbzc\_yyyj |
| 河北     | 2015 | 基础研究    |    66290.1 | 万元  | v4\_zh\_nbzc\_jcyj |

##### IndustryOperation

**`IndustryOperation`**：A **long format** data set containing Industry
Operation statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 384 rows�?

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
| 天津     | 2016 | 企业�?       |   533.00000 | �?      | v4\_cy\_scjy\_qys  |
| 北京     | 2019 | 利润总额     |   522.00000 | �?,亿元 | v4\_cy\_scjy\_lrze |
| 宁夏     | 2016 | 利润总额     |    12.44413 | 亿元    | v4\_cy\_scjy\_lrze |
| 西藏     | 2018 | 企业�?       |     8.00000 | �?      | v4\_cy\_scjy\_qys  |
| 四川     | 2018 | 主营业务收入 |  6943.00000 | �?,亿元 | v4\_cy\_scjy\_zyyw |
| 辽宁     | 2018 | 主营业务收入 |  1825.00000 | �?,亿元 | v4\_cy\_scjy\_zyyw |
| 新疆     | 2018 | 企业�?       |    52.00000 | �?      | v4\_cy\_scjy\_qys  |
| 新疆     | 2015 | 企业�?       |    42.00000 | �?      | v4\_cy\_scjy\_qys  |
| 全国     | 2018 | 企业�?       | 33573.00000 | �?      | v4\_cy\_scjy\_qys  |
| 重庆     | 2016 | 企业�?       |   678.00000 | �?      | v4\_cy\_scjy\_qys  |

##### IndustryRD

**`IndustryRD`**：A **long format** data set containing Industry R&D
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 2176 rows�?

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

| province | year | chn\_block4      |        value | units | variables           |
|:---------|:-----|:-----------------|-------------:|:------|:--------------------|
| 江西     | 2017 | 研发机构�?       |     406.0000 | �?    | v4\_cy\_RDhd\_yfjgs |
| 重庆     | 2016 | 技术引进经费支�? |    2642.6000 | 万元  | v4\_cy\_jsgz\_yjzc  |
| 河北     | 2017 | 开发项目数       |    1790.0000 | �?    | v4\_cy\_xcp\_kfxm   |
| 上海     | 2017 | 项目经费         | 1447632.0000 | 万元  | v4\_cy\_RDhd\_xmjf  |
| 全国     | 2017 | 施工项目个数     |   27891.0000 | �?    | v4\_cy\_cytz\_sgxm  |
| 内蒙�?   | 2019 | 发明专利         |     413.0000 | 万元  | v4\_cy\_qyzl\_fms   |
| 北京     | 2016 | 项目经费         | 1014994.2000 | 万元  | v4\_cy\_RDhd\_xmjf  |
| 浙江     | 2016 | 技术引进经费支�? |    9306.2000 | 万元  | v4\_cy\_jsgz\_yjzc  |
| 云南     | 2017 | 投资�?           |     164.8739 | 亿元  | v4\_cy\_cytz\_tzze  |
| 福建     | 2016 | 消化吸收经费支出 |    7237.6000 | 万元  | v4\_cy\_jsgz\_xszc  |

##### IndustryTrade

**`IndustryTrade`**：A **long format** data set containing Industry
Trade statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 288 rows�?

-   Years range from 2016 to 2018

-   Variables including: v4\_cy\_my\_ck, v4\_cy\_my\_jck, v4\_cy\_my\_jk

``` r
IndustryTrade %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |      value | units    | variables       |
|:---------|:-----|:------------|-----------:|:---------|:----------------|
| 海南     | 2016 | 进口贸易�?  |  2531.3079 | 百万美元 | v4\_cy\_my\_jk  |
| 海南     | 2018 | 贸易总额    |  3666.0000 | 百万美元 | v4\_cy\_my\_jck |
| 湖北     | 2018 | 贸易总额    | 19291.0000 | 百万美元 | v4\_cy\_my\_jck |
| 安徽     | 2016 | 贸易总额    |  8849.9658 | 百万美元 | v4\_cy\_my\_jck |
| 陕西     | 2016 | 出口贸易�?  | 11260.9941 | 百万美元 | v4\_cy\_my\_ck  |
| 湖北     | 2017 | 进口贸易�?  |  6182.9902 | 百万美元 | v4\_cy\_my\_jk  |
| 重庆     | 2017 | 进口贸易�?  | 12856.8423 | 百万美元 | v4\_cy\_my\_jk  |
| 重庆     | 2018 | 进口贸易�?  | 15400.0000 | 百万美元 | v4\_cy\_my\_jk  |
| 陕西     | 2017 | 出口贸易�?  | 19064.9741 | 百万美元 | v4\_cy\_my\_ck  |
| 宁夏     | 2016 | 进口贸易�?  |    32.3002 | 百万美元 | v4\_cy\_my\_jk  |

##### MarketPull

**`MarketPull`**：A **long format** data set containing Tech Market Pull
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 704 rows�?

-   Years range from 2000 to 2019

-   Variables including: v4\_cg\_jssr\_ht, v4\_cg\_jssr\_je

``` r
MarketPull %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |      value | units | variables        |
|:---------|:-----|:------------|-----------:|:------|:-----------------|
| 青海     | 2010 | 数量        |      882.0 | �?    | v4\_cg\_jssr\_ht |
| 安徽     | 2016 | 金额        |  2016749.6 | 万元  | v4\_cg\_jssr\_je |
| 广东     | 2019 | 金额        | 31256930.0 | 万元  | v4\_cg\_jssr\_je |
| 新疆     | 2017 | 数量        |     2569.0 | �?    | v4\_cg\_jssr\_ht |
| 新疆     | 2010 | 数量        |     3103.0 | �?    | v4\_cg\_jssr\_ht |
| 贵州     | 2010 | 金额        |   218775.1 | 万元  | v4\_cg\_jssr\_je |
| 浙江     | 2015 | 数量        |    14999.0 | �?    | v4\_cg\_jssr\_ht |
| 西藏     | 2014 | 金额        |   101985.4 | 万元  | v4\_cg\_jssr\_je |
| 青海     | 2005 | 数量        |      606.0 | �?    | v4\_cg\_jssr\_ht |
| 湖北     | 2000 | 金额        |   190942.0 | 万元  | v4\_cg\_jssr\_je |

##### MarketPush

**`MarketPush`**：A **long format** data set containing Tech Market Push
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 704 rows�?

-   Years range from 2000 to 2019

-   Variables including: v4\_cg\_jssc\_ht, v4\_cg\_jssc\_je

``` r
MarketPush %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |        value | units | variables        |
|:---------|:-----|:------------|-------------:|:------|:-----------------|
| 宁夏     | 2019 | 数量        |       1922.0 | �?    | v4\_cg\_jssc\_ht |
| 贵州     | 2013 | 金额        |     183971.9 | 万元  | v4\_cg\_jssc\_je |
| 全国     | 2019 | 金额        | 223983882\.0 | 万元  | v4\_cg\_jssc\_je |
| 陕西     | 2018 | 金额        |   11252908.4 | 万元  | v4\_cg\_jssc\_je |
| 江苏     | 2013 | 金额        |    5275019.7 | 万元  | v4\_cg\_jssc\_je |
| 湖北     | 2018 | 数量        |      28399.0 | �?    | v4\_cg\_jssc\_ht |
| 天津     | 2019 | 数量        |      13885.0 | �?    | v4\_cg\_jssc\_ht |
| 内蒙�?   | 2014 | 金额        |     139393.1 | 万元  | v4\_cg\_jssc\_je |
| 贵州     | 2018 | 金额        |    1710975.2 | 万元  | v4\_cg\_jssc\_je |
| 陕西     | 2014 | 金额        |    6400197.9 | 万元  | v4\_cg\_jssc\_je |

#### Data from China National Yearbook

##### PublicBudget

**`PublicBudget`**：A **long format** data set containing Public Budget
statistics.

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 1244 rows�?

-   Years range from 2010 to 2019

-   Variables including: v6\_cz\_yszc\_hj, v6\_cz\_yszc\_jy,
    v6\_cz\_yszc\_kxjs, v6\_cz\_yszc\_nls

#### Data from Livestock Yearbook

**`LivestockBreeding`**：A **long format** data set containing Livestock
Breeding statistics.

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables�?

-   Totally 20672 rows�?

-   Years range from 2011 to 2017

-   Variables including: v8\_t1\_zcqc\_zhnc, v8\_t1\_zcqc\_zmc,
    v8\_t1\_zcqc\_zmsyc, v8\_t1\_zcqc\_zmyc, v8\_t1\_zcqc\_znc,
    v8\_t1\_zcqc\_znnc1, v8\_t1\_zcqc\_znnc2, v8\_t1\_zcqc\_zrnc,
    v8\_t1\_zcqc\_zs, v8\_t1\_zcqc\_zsnc, v8\_t1\_zcqc\_zsyc,
    v8\_t1\_zcqc\_zxmyc, v8\_t1\_zcqc\_zyc, v8\_t1\_zcqc\_zzc,
    v8\_t2\_zcqc\_fmddjc, v8\_t2\_zcqc\_fmdrjc, v8\_t2\_zcqc\_qt,
    v8\_t2\_zcqc\_zdjc, v8\_t2\_zcqc\_zdjysdjc,
    v8\_t2\_zcqc\_zdjysrjc（top 20 of totally 98 variables�?

``` r
PublicBudget %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4 |     value | units | variables          |
|:---------|:-----|:------------|----------:|:------|:-------------------|
| 陕西     | 2011 | 合计        | 2930.8100 | 亿元  | v6\_cz\_yszc\_hj   |
| 山东     | 2016 | 农林�?      |  943.4400 | 亿元  | v6\_cz\_yszc\_nls  |
| 陕西     | 2014 | 科学技�?    |   44.8632 | 亿元  | v6\_cz\_yszc\_kxjs |
| 上海     | 2019 | 教育        |  995.7000 | 亿元  | v6\_cz\_yszc\_jy   |
| 河南     | 2013 | 教育        | 1171.5204 | 亿元  | v6\_cz\_yszc\_jy   |
| 广东     | 2012 | 合计        | 7387.8565 | 亿元  | v6\_cz\_yszc\_hj   |
| 天津     | 2015 | 科学技�?    |  120.8200 | 亿元  | v6\_cz\_yszc\_kxjs |
| 西藏     | 2019 | 农林�?      |  445.0100 | 亿元  | v6\_cz\_yszc\_nls  |
| 黑龙�?   | 2018 | 农林�?      |  834.4700 | 亿元  | v6\_cz\_yszc\_nls  |
| 安徽     | 2017 | 合计        | 6203.8110 | 亿元  | v6\_cz\_yszc\_hj   |

### Public site

#### Data from MOST

Several data set sources from Ministry of Sci-Tech (MOST).

##### PubNKRDP

**`PubNKRDP`**：A **wide format** data set containing Details of
National Key R&D Plans(NKRDP) statistics.

-   Totally 17 columns including: year, date, NO, index, title,
    institution, chairman, funds, type, duration, NO\_head, NO\_year,
    NO\_mark, NO\_num, NO\_num\_p1, NO\_num\_p2, NO\_tail�?

-   Totally 2579 rows�?

-   Years range from 2018 to 2020

``` r
PubNKRDP %>%
  sample_n(size = 10) %>%
  kable()
```

| year | date     | NO              | index | title                                                      | institution                                | chairman | funds | type                                             | duration | NO\_head | NO\_year | NO\_mark | NO\_num | NO\_num\_p1 | NO\_num\_p2 | NO\_tail |
|:-----|:---------|:----------------|:------|:-----------------------------------------------------------|:-------------------------------------------|:---------|:------|:-------------------------------------------------|:---------|:---------|:---------|:---------|:--------|:------------|:------------|:---------|
| 2020 | 20201223 | 2020YFF0305900  | 22    | 冬景植物定向培育及场馆外围风沙治理技术集成研究与示范       | 中国林业科学研究院林业研究所               | NA       | NA    | 科技冬奥                                         | 2        |          | 2020     | YFF      | 0305900 | 03          | 05900       | NA       |
| 2020 | 20201223 | 2020YFA0509400  | 355   | 肿瘤器官选择性转移中特化外泌体的鉴定、功能及化学干预研究   | 中山大学                                   | NA       | NA    | 蛋白质机器与生命过程调控                         | 5        |          | 2020     | YFA      | 0509400 | 05          | 09400       | NA       |
| 2020 | 20201223 | 2020YFA0405700  | 396   | 高性能风洞精细化流动显示与非接触测量技术研�?               | 中国空气动力研究与发展中�?                 | NA       | NA    | 大科学装置前沿研�?                               | 4        |          | 2020     | YFA      | 0405700 | 04          | 05700       | NA       |
| 2018 | 20191015 | 2018YFB2200400  | 1276  | 复合微纳体系光子器件及集�?                                 | 浙江大学                                   | 童利�?   | 2278  | 光电子与微电子器件及集成                         | NA       |          | 2018     | YFB      | 2200400 | 22          | 00400       | NA       |
| 2020 | 20201223 | 2020YFC0832500  | 25    | 智慧司法智能化感知交互技术研�?                             | 浙江大学                                   | NA       | NA    | 公共安全风险防控与应急技术装备（含司法专题）定向 | 3�?      |          | 2020     | YFC      | 0832500 | 08          | 32500       | NA       |
| 2018 | 20191015 | SQ2018YFD080082 | 406   | 东北粮食主产区农业面源污染综合防治技术示�?                 | 黑龙江省农业科学院土壤肥料与环境资源研究所 | 王玉�?   | 1578  | 农业面源和重金属污染农田综合防治与修复技术研�?   | NA       | SQ       | 2018     | YFD      | 080082  | 08          | 0082        | NA       |
| 2018 | 20191015 | 2018YFF0212600  | 243   | 高精度重磁计量标准装置研�?                                 | 工业和信息化部电子第五研究所               | 王实     | 877   | 国家质量基础的共性技术研究与应用                 | NA       |          | 2018     | YFF      | 0212600 | 02          | 12600       | NA       |
| 2020 | 20201223 | 2020YFC2200800  | 518   | 惯性传感器控制方法与技术研�?                               | 上海交通大�?                               | NA       | NA    | 引力波探�?                                       | 5        |          | 2020     | YFC      | 2200800 | 22          | 00800       | NA       |
| 2020 | 20201223 | 2020YFB0311300  | 291   | 耐高温无卤阻燃抑烟隔热弹性材料的制备与应�?                 | 四川大学                                   | NA       | NA    | 重点基础材料技术提升与产业�?                     | 2        |          | 2020     | YFB      | 0311300 | 03          | 11300       | NA       |
| 2020 | 20201223 | 2020YFB1712700  | 134   | 大型显示面板前端制造工艺纳米尺度物性在线测量与质量监控系统 | 三英精控（天津）仪器设备有限公司           | NA       | NA    | 网络协同制造和智能工厂                           | 3        |          | 2020     | YFB      | 1712700 | 17          | 12700       | NA       |

##### PubAgriParkList

**`PubAgriParkList`**：A **wide format** data set containing Details of
Approved List of National Agricultural Sci-tech Park.

-   Totally 4 columns including: index, batch, name, province�?

-   Totally 233 rows�?

-   Years (Batch) range from 01 to 09

``` r
PubAgriParkList %>%
  sample_n(size = 10) %>%
  kable()
```

| index | batch | name                         | province |
|------:|:------|:-----------------------------|:---------|
|     5 | 07    | 青海海南国家农业科技园区     | 青海     |
|     6 | 01    | 湖南望城农业科技园区         | 湖南     |
|    19 | 03    | 山东滨州国家农业科技园区     | 山东     |
|    11 | 03    | 福建厦门同安国家农业科技园区 | 福建     |
|    20 | 06    | 浙江象山国家农业科技园区     | 浙江     |
|     5 | 09    | 辽宁桓仁国家农业科技园区     | 辽宁     |
|    14 | 08    | 山东莱芜国家农业科技园区     | 山东     |
|    11 | 06    | 四川内江国家农业科技园区     | 四川     |
|     3 | 08    | 内蒙古包头国家农业科技园区   | 内蒙�?   |
|    15 | 06    | 安徽马鞍山国家农业科技园区   | 安徽     |

##### PubAgriParkEval

**`PubAgriParkEval`**：A **wide format** data set containing Details of
Evaluation result of National Agricultural Sci-tech Park.

-   Totally 5 columns including: year, index, name, result, province�?

-   Totally 162 rows�?

-   Years range from 2019 to 2020

``` r
PubAgriParkEval %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | name                       | result | province |
|-----:|------:|:---------------------------|:-------|:---------|
| 2019 |    24 | 安徽宿州国家农业科技园区   | ok     | 安徽     |
| 2019 |    79 | 大连旅顺国家农业科技园区   | ok     | 辽宁     |
| 2019 |    11 | 山东寿光国家农业科技园区   | good   | 山东     |
| 2019 |    29 | 福建漳州国家农业科技园区   | ok     | 福建     |
| 2019 |    63 | 西藏拉萨国家农业科技园区   | ok     | 西藏     |
| 2019 |    28 | 安徽安庆国家农业科技园区   | ok     | 安徽     |
| 2019 |    12 | 辽宁辉山国家农业科技园区   | ok     | 辽宁     |
| 2019 |    34 | 江西新余国家农业科技园区   | ok     | 江西     |
| 2019 |     4 | 河南濮阳国家农业科技园区   | fail   | 河南     |
| 2019 |    60 | 贵州黔西南国家农业科技园区 | ok     | 贵州     |

#### Data from MOA or MOE

Several data set sources from Ministry of Agriculture (MOA) or Ministry
of Education (MOE).

##### PubObsStation

**`PubObsStation`**：A **wide format** data set containing Details of
Evaluation result of National Agricultural Sci-tech Details list of
Observe Stations of MOA and MOE.

-   Totally 6 columns including: officer, year, index, name,
    institution, province�?

-   Totally 158 rows�?

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
    province\_func, province\_researcher�?

-   Totally 1691 rows�?

-   Years range from 2011 to 2021
``` r
PubObsStation %>%
  sample_n(size = 10) %>%
  kable()
```

| officer | year | index | name                                                         | institution                    | province |
|:--------|-----:|:------|:-------------------------------------------------------------|:-------------------------------|:---------|
| MOE     | 2019 | 21    | 甘南草原生态系统教育部野外科学观测研究�?                     | 兰州大学                       | 甘肃     |
| MOE     | 2019 | 41    | 三峡库区紫色土土壤质量与生态环境教育部野外科学观测研究�?     | 西南大学                       | 重庆     |
| MOE     | 2019 | 47    | 海州湾渔业生态系统教育部野外科学观测研究�?                   | 中国海洋大学                   | 山东     |
| MOE     | 2019 | 51    | 广东黑石顶地带与非地带性森林生态系统教育部野外科学观测研究�? | 中山大学                       | 广东     |
| MOA     | 2019 | 53    | 国家农业科学植物保护忻州观测实验�?                           | 山西省农业科学院               | 山西     |
| MOA     | 2019 | 31    | 国家农业科学土壤质量济南观测实验�?                           | 山东省农业科学院               | 山东     |
| MOA     | 2019 | 39    | 国家农业科学土壤质量长沙观测实验�?                           | 湖南省农业科学院               | 湖南     |
| MOA     | 2019 | 69    | 国家农业科学农业环境拉萨观测实验�?                           | 中国科学院地理科学与资源研究所 | 北京     |
| MOA     | 2019 | 34    | 国家农业科学农业微生物扬州观测实验站                         | 江苏里下河地区农科所           | 江苏     |
| MOE     | 2019 | 8     | 旱区地球关键带多尺度多变量科学教育部野外科学观测研究�?       | 长安大学                       | 陕西     |

##### PubBreedingXmj

**`PubBreedingXmj`**：A **wide format** data set containing details of
Officer�? Livestock Breeding List from MOA (Xmj).

-   Totally 7 columns including: year, index, province, type,
    name\_origin, name\_change, mark�?

-   Totally 287 rows�?

-   Years range from 2010 to 2020

``` r
PubBreedingXmj %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | province | type                     | name\_origin                 | name\_change                     | mark     |
|:-----|:------|:---------|:-------------------------|:-----------------------------|:---------------------------------|:---------|
| 2012 | 2     | 江苏     | 国家生猪核心育种�?       | 江苏天兆实业有限公司         | NA                               | 遴选公�? |
| 2018 | 4     | 河南     | NA                       | 河南省黄泛区鑫欣牧业有限公司 | 河南省黄泛区鑫欣牧业股份有限公司 | 名称变更 |
| 2015 | 7     | 湖南     | 国家肉鸡良种扩繁推广基地 | 湖南湘佳牧业股份有限公司     | NA                               | 遴选公�? |
| 2014 | 5     | 安徽     | 国家蛋鸡核心育种�?       | 安徽荣达禽业开发有限公�?     | NA                               | 遴选公�? |
| 2017 | 4     | 湖南     | 国家肉牛核心育种�?       | 湖南天华实业有限公司         | NA                               | 遴选公�? |
| 2013 | 3     | 河北     | 国家生猪核心育种�?       | 河北吴氏润康牧业股份有限公司 | NA                               | 遴选公�? |
| 2018 | 6     | 山东     | 国家生猪核心育种�?       | 山东中慧牧业有限公司         | NA                               | 遴选公�? |
| 2018 | 7     | 河南     | 国家奶牛核心育种�?       | 河南花花牛畜牧科技有限公司   | NA                               | 遴选公�? |
| 2020 | 6     | 湖南     | 国家生猪核心育种�?       | 湖南鑫广安农牧股份有限公�?   | NA                               | 资格取消 |
| 2015 | 4     | 上海     | 国家生猪核心育种�?       | 上海市上海农�?               | NA                               | 遴选公�? |
