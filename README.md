
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

-   Totally 582 rows.

``` r
varsList %>%
  sample_n(size = 10) %>%
  kable()
```

| variables                | chn\_full\_name                    | short\_chn | short\_eng | units | block1 | block2 | block3 | block4     | chn\_block1  | chn\_block2  | chn\_block3  | chn\_block4                        | chn\_full                                                      | flag    | source           |
|:-------------------------|:-----------------------------------|:-----------|:-----------|:------|:-------|:-------|:-------|:-----------|:-------------|:-------------|:-------------|:-----------------------------------|:---------------------------------------------------------------|:--------|:-----------------|
| v4\_gx\_RDry\_cyry       | NA                                 | NA         | NA         | 人    | v4     | gx     | RDry   | cyry       | 科技         | 高校         | RD人员       | 从业人员                           | NA                                                             | v2019.8 | NA               |
| v8\_t1\_zcqc\_zsnc       | NA                                 | NA         | NA         | 个    | v8     | t1     | zcqc   | zsnc       | 种畜禽场站   | 表1          | 种畜禽厂     | 种水牛场                           | NA                                                             | v2021.8 | 中国畜牧兽医年鉴 |
| v1\_sc\_dcl\_dd          | 每公顷产量\_大豆                   | NA         | NA         | 千克  | v1     | sc     | dcl    | dd         | 农业         | 生产         | 单产量       | 大豆                               | 农业;生产;单产量;大豆                                          | v2018.6 | NA               |
| v4\_qy\_nbzc\_syfz       | NA                                 | NA         | NA         | 万元  | v4     | qy     | nbzc   | syfz       | 科技         | 企业         | 内部支出     | 试验发展                           | NA                                                             | v2019.8 | NA               |
| v4\_gx\_RDry\_bsby       | NA                                 | NA         | NA         | 人    | v4     | gx     | RDry   | bsby       | 科技         | 高校         | RD人员       | 博士毕业人员                       | NA                                                             | v2019.8 | NA               |
| v4\_jsjg\_sl\_srht       | 技术输入\_合同数                   | NA         | NA         | 个    | v4     | jsjg   | sl     | srht       | 科技         | 科技机构     | 数量         | 技术输入\_合同数                   | 科技;科技机构;数量;技术输入\_合同数                            | v2018.6 | NA               |
| v2\_GDP\_sl\_zl          | GDP                                | NA         | NA         | 亿元  | v2     | GDP    | sl     | zl         | 社会         | 国民生产总值 | 数量         | GDP                                | 社会;国民生产总值;数量;GDP                                     | v2018.6 | NA               |
| v5\_rwwc\_sl\_land\_jspt | 土地治理项目\_中型灌区节水配套改造 | NA         | NA         | 个    | v5     | rwwc   | sl     | land\_jspt | 农业综合开发 | 任务完成     | 数量         | 土地治理项目\_中型灌区节水配套改造 | 农业综合开发;任务完成\_数量;土地治理项目\_中型灌区节水配套改造 | v2018.6 | NA               |
| v4\_zh\_jsry\_xj         | NA                                 | 小计       | subtotal   | 人    | v4     | zh     | jsry   | xj         | 科技         | 综合         | 专业技术人员 | 小计                               | NA                                                             | v2019.8 | NA               |
| v4\_cy\_cytz\_tzze       | NA                                 | 投资额     | investment | 亿元  | v4     | cy     | cytz   | tzze       | 科技         | 高新产业     | 产业投资     | 投资额                             | NA                                                             | v2019.8 | NA               |

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
|  20 | 广西     | 非旱区      |
|  21 | 海南     | 非旱区      |
|  29 | 青海     | 旱区        |
|  26 | 西藏     | 旱区        |
|   8 | 黑龙江   | 旱区        |
|  19 | 广东     | 非旱区      |
|  24 | 贵州     | 非旱区      |
|  28 | 甘肃     | 旱区        |
|  27 | 陕西     | 旱区        |
|  22 | 重庆     | 非旱区      |

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

| index | province       | city                 | id           | province\_clean | city\_clean |
|------:|:---------------|:---------------------|:-------------|:----------------|:------------|
|    16 | 山西省         | 阳泉市               | 140300000000 | 山西            | 阳泉        |
|   223 | 广西壮族自治区 | 钦州市               | 450700000000 | 广西            | 钦州        |
|   167 | 河南省         | 省直辖县级行政区划   | 419000000000 | 河南            | uncheck     |
|   103 | 安徽省         | 淮北市               | 340600000000 | 安徽            | 淮北        |
|   307 | 甘肃省         | 张掖市               | 620700000000 | 甘肃            | 张掖        |
|   266 | 贵州省         | 黔东南苗族侗族自治州 | 522600000000 | 贵州            | uncheck     |
|   273 | 云南省         | 丽江市               | 530700000000 | 云南            | 丽江        |
|     6 | 河北省         | 邯郸市               | 130400000000 | 河北            | 邯郸        |
|   159 | 河南省         | 许昌市               | 411000000000 | 河南            | 许昌        |
|    79 | 江苏省         | 南通市               | 320600000000 | 江苏            | 南通        |

#### 

**`queryTianyan`**：A data set containing basic info of institution
enrolled in officer administrator.

-   Totally 9 columns including: index, name\_origin, name\_search,
    address, tel, url, province, city, province\_raw.

-   Totally 464 rows.

``` r
AgriMachine %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn\_block4          |  value | units  | variables                 |
|:---------|:-----|:---------------------|-------:|:-------|:--------------------------|
| 内蒙古   | 2015 | 大中型拖拉机配套农具 |  38.21 | 万部   | v7\_sctj\_nyjx\_dztlj\_pt |
| 河南     | 2019 | 小型拖拉机           | 314.00 | 万台   | v7\_sctj\_nyjx\_xtlj      |
| 全国     | 2013 | 机收面积             |     NA | 千公顷 | v7\_sctj\_nyjx\_jsmj      |
| 宁夏     | 2019 | 农用水泵             |   3.60 | 万台   | v7\_sctj\_nyjx\_nysb      |
| 广东     | 2010 | 联合收获机           |   1.82 | 万台   | v7\_sctj\_nyjx\_lhshj     |
| 上海     | 2013 | 大中型拖拉机         |   0.67 | 万台   | v7\_sctj\_nyjx\_dztlj     |
| 上海     | 2019 | 大中型拖拉机配套农具 |   0.40 | 万部   | v7\_sctj\_nyjx\_dztlj\_pt |
| 山东     | 2016 | 节水灌溉类机械       |  52.35 | 万套   | v7\_sctj\_nyjx\_jsgg      |
| 青海     | 2014 | 机收面积             |     NA | 千公顷 | v7\_sctj\_nyjx\_jsmj      |
| 北京     | 2012 | 农用水泵             |   3.45 | 万台   | v7\_sctj\_nyjx\_nysb      |

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

| province | year | chn\_block4        |   value | units  | variables                |
|:---------|:-----|:-------------------|--------:|:-------|:-------------------------|
| 黑龙江   | 2017 | 小型拖拉机         | 54.4000 | 万台   | v7\_sctj\_nyjx\_xtlj     |
| 山西     | 2013 | 机动脱粒机         |  8.5200 | 万台   | v7\_sctj\_nyjx\_jdtlj    |
| 甘肃     | 2016 | 机动脱粒机         | 27.1500 | 万台   | v7\_sctj\_nyjx\_jdtlj    |
| 河北     | 2011 | 机动脱粒机         | 20.7100 | 万台   | v7\_sctj\_nyjx\_jdtlj    |
| 西藏     | 2010 | 农用排灌柴油机     |  0.1950 | 万台   | v7\_sctj\_nyjx\_pgcyj    |
| 贵州     | 2011 | 大中型拖拉机       |  3.1222 | 万台   | v7\_sctj\_nyjx\_dztlj    |
| 甘肃     | 2015 | 节水灌溉类机械     |  1.8700 | 万套   | v7\_sctj\_nyjx\_jsgg     |
| 辽宁     | 2012 | 机收面积           |      NA | 千公顷 | v7\_sctj\_nyjx\_jsmj     |
| 江苏     | 2018 | 小型拖拉机配套农具 |      NA | 万部   | v7\_sctj\_nyjx\_xtlj\_pt |
| 海南     | 2011 | 农用排灌电动机     |  3.6000 | 万台   | v7\_sctj\_nyjx\_pgddj    |

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

| province | year | chn\_block4 | value | units | variables          |
|:---------|:-----|:------------|------:|:------|:-------------------|
| 西藏     | 2019 | 钾肥        |   0.4 | 万吨  | v7\_sctj\_nyhf\_jf |
| 四川     | 2012 | 化肥使用量  | 253.0 | 万吨  | v7\_sctj\_nyhf\_hj |
| 山东     | 2011 | 化肥使用量  | 473.6 | 万吨  | v7\_sctj\_nyhf\_hj |
| 广西     | 2011 | 化肥使用量  | 242.7 | 万吨  | v7\_sctj\_nyhf\_hj |
| 湖北     | 2013 | 化肥使用量  | 351.9 | 万吨  | v7\_sctj\_nyhf\_hj |
| 天津     | 2019 | 磷肥        |   1.9 | 万吨  | v7\_sctj\_nyhf\_lf |
| 江苏     | 2015 | 化肥使用量  | 320.0 | 万吨  | v7\_sctj\_nyhf\_hj |
| 内蒙古   | 2011 | 化肥使用量  | 176.9 | 万吨  | v7\_sctj\_nyhf\_hj |
| 北京     | 2013 | 化肥使用量  |  12.8 | 万吨  | v7\_sctj\_nyhf\_hj |
| 江苏     | 2014 | 化肥使用量  | 323.6 | 万吨  | v7\_sctj\_nyhf\_hj |

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

| province | year | chn\_block4    |  value | units | variables            |
|:---------|:-----|:---------------|-------:|:------|:---------------------|
| 安徽     | 2018 | NA             |  43150 | NA    | v7\_sctj\_nybm\_dmsy |
| 陕西     | 2012 | 农用薄膜使用量 |  39077 | 吨    | v7\_sctj\_nybm\_bmsy |
| 广东     | 2017 | NA             | 139083 | NA    | v7\_sctj\_nybm\_dmfg |
| 湖北     | 2012 | NA             |  36838 | NA    | v7\_sctj\_nybm\_dmsy |
| 福建     | 2015 | 农用薄膜使用量 |  62067 | 吨    | v7\_sctj\_nybm\_bmsy |
| 海南     | 2017 | NA             |  48735 | NA    | v7\_sctj\_nybm\_dmfg |
| 湖北     | 2019 | 地膜使用量     |  21696 | 吨    | v7\_sctj\_nybm\_dmsy |
| 福建     | 2017 | NA             | 140238 | NA    | v7\_sctj\_nybm\_dmfg |
| 河北     | 2013 | NA             |  67776 | NA    | v7\_sctj\_nybm\_dmsy |
| 湖北     | 2018 | 农用薄膜使用量 |  63554 | 吨    | v7\_sctj\_nybm\_bmsy |

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
| 青海     | 2016 | 农药使用量     |   1939.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 西藏     | 2012 | 农药使用量     |    923.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 上海     | 2012 | 农药使用量     |   5817.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 贵州     | 2016 | 农药使用量     |  13677.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 黑龙江   | 2019 | 农用柴油使用量 |    137.4 | 万吨  | v7\_sctj\_cyny\_cysy |
| 山西     | 2010 | 农药使用量     |  26107.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 广东     | 2017 | 农药使用量     | 112958.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 甘肃     | 2016 | 农药使用量     |  69915.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 天津     | 2013 | 农药使用量     |   3639.0 | 吨    | v7\_sctj\_cyny\_nysy |
| 青海     | 2017 | 农药使用量     |   1875.0 | 吨    | v7\_sctj\_cyny\_nysy |

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

| province | year | chn\_block4 |  value | units | variables       |
|:---------|:-----|:------------|-------:|:------|:----------------|
| 四川     | 2016 | RD经费      | 561.40 | 亿元  | v4\_ztr\_jf\_RD |
| 浙江     | 2014 | RD经费      | 907.90 | 亿元  | v4\_ztr\_jf\_RD |
| 江西     | 2017 | RD强度      |   1.28 | %     | v4\_ztr\_qd\_RD |
| 山西     | 2019 | RD强度      |   1.12 | %     | v4\_ztr\_qd\_RD |
| 辽宁     | 2017 | RD强度      |   1.84 | %     | v4\_ztr\_qd\_RD |
| 浙江     | 2018 | RD强度      |   2.57 | %     | v4\_ztr\_qd\_RD |
| 辽宁     | 2019 | RD经费      | 508.50 | 亿元  | v4\_ztr\_jf\_RD |
| 上海     | 2014 | RD强度      |   3.66 | %     | v4\_ztr\_qd\_RD |
| 云南     | 2017 | RD强度      |   0.96 | %     | v4\_ztr\_qd\_RD |
| 北京     | 2011 | RD强度      |   5.76 | %     | v4\_ztr\_qd\_RD |

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

| province | year | chn\_block4 |      value | units | variables          |
|:---------|:-----|:------------|-----------:|:------|:-------------------|
| 广东     | 2016 | 合计        | 20351439.9 | 万元  | v4\_zh\_nbzc\_hj   |
| 四川     | 2015 | 应用研究    |   838887.2 | 万元  | v4\_zh\_nbzc\_yyyj |
| 山东     | 2014 | 基础研究    |   243947.7 | 万元  | v4\_zh\_nbzc\_jcyj |
| 河南     | 2012 | 应用研究    |   116550.5 | 万元  | v4\_zh\_nbzc\_yyyj |
| 辽宁     | 2015 | 基础研究    |   266609.8 | 万元  | v4\_zh\_nbzc\_jcyj |
| 云南     | 2016 | 应用研究    |   167202.3 | 万元  | v4\_zh\_nbzc\_yyyj |
| 福建     | 2015 | 试验发展    |  3623985.1 | 万元  | v4\_zh\_nbzc\_syfz |
| 江苏     | 2014 | 合计        | 16528208.4 | 万元  | v4\_zh\_nbzc\_hj   |
| 河南     | 2019 | 应用研究    |   722441.0 | 万元  | v4\_zh\_nbzc\_yyyj |
| 湖南     | 2019 | 试验发展    |  6686848.0 | 万元  | v4\_zh\_nbzc\_syfz |

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

| province | year | chn\_block4  |      value | units   | variables          |
|:---------|:-----|:-------------|-----------:|:--------|:-------------------|
| 山西     | 2016 | 利润总额     |   47.05723 | 亿元    | v4\_cy\_scjy\_lrze |
| 贵州     | 2019 | 利润总额     |   58.00000 | 个,亿元 | v4\_cy\_scjy\_lrze |
| 内蒙古   | 2019 | 主营业务收入 |  364.00000 | 个,亿元 | v4\_cy\_scjy\_zyyw |
| 海南     | 2016 | 企业数       |   52.00000 | 个      | v4\_cy\_scjy\_qys  |
| 北京     | 2018 | 企业数       |  799.00000 | 个      | v4\_cy\_scjy\_qys  |
| 广东     | 2019 | 企业数       | 9542.00000 | 个      | v4\_cy\_scjy\_qys  |
| 青海     | 2019 | 企业数       |   37.00000 | 个      | v4\_cy\_scjy\_qys  |
| 浙江     | 2019 | 主营业务收入 | 8384.00000 | 个,亿元 | v4\_cy\_scjy\_zyyw |
| 天津     | 2016 | 企业数       |  533.00000 | 个      | v4\_cy\_scjy\_qys  |
| 江西     | 2019 | 利润总额     |  362.00000 | 个,亿元 | v4\_cy\_scjy\_lrze |

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

| province | year | chn\_block4      |        value | units | variables           |
|:---------|:-----|:-----------------|-------------:|:------|:--------------------|
| 青海     | 2017 | 投资额           | 1.009360e+02 | 亿元  | v4\_cy\_cytz\_tzze  |
| 广东     | 2018 | 开发项目数       | 3.852600e+04 | 项    | v4\_cy\_xcp\_kfxm   |
| 福建     | 2019 | 出口             | 8.208995e+06 | 万元  | v4\_cy\_xcp\_ck     |
| 福建     | 2017 | 销售收入         | 1.588346e+07 | 万元  | v4\_cy\_xcp\_xssr   |
| 海南     | 2018 | 消化吸收经费支出 |           NA | 万元  | v4\_cy\_jsgz\_xszc  |
| 山西     | 2017 | 项目经费         | 1.122116e+05 | 万元  | v4\_cy\_RDhd\_xmjf  |
| 内蒙古   | 2019 | 专利申请数       | 4.760000e+02 | 件    | v4\_cy\_qyzl\_sqs   |
| 黑龙江   | 2018 | 发明专利         | 2.310000e+02 | 万元  | v4\_cy\_qyzl\_fms   |
| 宁夏     | 2016 | 新增固定资产     | 2.206940e+01 | 亿元  | v4\_cy\_cytz\_gdzc  |
| 安徽     | 2019 | 研发机构数       | 8.610000e+02 | 个    | v4\_cy\_RDhd\_yfjgs |

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
| 宁夏     | 2018 | 进口贸易额  |     60.0000 | 百万美元 | v4\_cy\_my\_jk  |
| 陕西     | 2016 | 贸易总额    |  21065.2606 | 百万美元 | v4\_cy\_my\_jck |
| 全国     | 2017 | 出口贸易额  | 670815.3784 | 百万美元 | v4\_cy\_my\_ck  |
| 浙江     | 2017 | 出口贸易额  |  18650.2888 | 百万美元 | v4\_cy\_my\_ck  |
| 山西     | 2016 | 贸易总额    |   9571.7403 | 百万美元 | v4\_cy\_my\_jck |
| 黑龙江   | 2017 | 出口贸易额  |    168.8632 | 百万美元 | v4\_cy\_my\_ck  |
| 河北     | 2017 | 出口贸易额  |   2190.3377 | 百万美元 | v4\_cy\_my\_ck  |
| 上海     | 2017 | 出口贸易额  |  84533.9496 | 百万美元 | v4\_cy\_my\_ck  |
| 山东     | 2018 | 出口贸易额  |  15155.0000 | 百万美元 | v4\_cy\_my\_ck  |
| 湖南     | 2016 | 贸易总额    |   4113.5495 | 百万美元 | v4\_cy\_my\_jck |

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

| province | year | chn\_block4 |   value | units | variables        |
|:---------|:-----|:------------|--------:|:------|:-----------------|
| 江西     | 2012 | 数量        |    2916 | 项    | v4\_cg\_jssr\_ht |
| 湖南     | 2017 | 金额        | 1777636 | 万元  | v4\_cg\_jssr\_je |
| 浙江     | 2005 | 数量        |   23639 | 项    | v4\_cg\_jssr\_ht |
| 浙江     | 2014 | 数量        |   16097 | 项    | v4\_cg\_jssr\_ht |
| 北京     | 2019 | 数量        |   65137 | 项    | v4\_cg\_jssr\_ht |
| 宁夏     | 2000 | 数量        |     488 | 项    | v4\_cg\_jssr\_ht |
| 青海     | 2010 | 数量        |     882 | 项    | v4\_cg\_jssr\_ht |
| 湖北     | 2010 | 数量        |    6591 | 项    | v4\_cg\_jssr\_ht |
| 山西     | 2012 | 金额        | 1112606 | 万元  | v4\_cg\_jssr\_je |
| 上海     | 2017 | 金额        | 7121410 | 万元  | v4\_cg\_jssr\_je |

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
| 海南     | 2013 | 金额        |    38692.89 | 万元  | v4\_cg\_jssc\_je |
| 北京     | 2018 | 金额        | 49578245.59 | 万元  | v4\_cg\_jssc\_je |
| 内蒙古   | 2015 | 金额        |   153871.52 | 万元  | v4\_cg\_jssc\_je |
| 陕西     | 2012 | 金额        |  3348152.62 | 万元  | v4\_cg\_jssc\_je |
| 吉林     | 2000 | 金额        |    71390.00 | 万元  | v4\_cg\_jssc\_je |
| 湖南     | 2014 | 金额        |   979341.68 | 万元  | v4\_cg\_jssc\_je |
| 湖北     | 2019 | 金额        | 14298358.00 | 万元  | v4\_cg\_jssc\_je |
| 安徽     | 2019 | 数量        |    19538.00 | 项    | v4\_cg\_jssc\_ht |
| 广东     | 2019 | 金额        | 22230844.00 | 万元  | v4\_cg\_jssc\_je |
| 河南     | 2016 | 数量        |     4270.00 | 项    | v4\_cg\_jssc\_ht |

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
| 天津     | 2019 | 合计        | 3555.7100 | 亿元  | v6\_cz\_yszc\_hj   |
| 四川     | 2019 | 教育        | 1578.8800 | 亿元  | v6\_cz\_yszc\_jy   |
| 新疆     | 2010 | 科学技术    |   20.1869 | 亿元  | v6\_cz\_yszc\_kxjs |
| 江西     | 2010 | 科学技术    |   18.2628 | 亿元  | v6\_cz\_yszc\_kxjs |
| 内蒙古   | 2011 | 农林水      |  391.6800 | 亿元  | v6\_cz\_yszc\_nls  |
| 上海     | 2018 | 农林水      |  469.8800 | 亿元  | v6\_cz\_yszc\_nls  |
| 云南     | 2015 | 农林水      |  641.5200 | 亿元  | v6\_cz\_yszc\_nls  |
| 江苏     | 2018 | 教育        | 2055.5600 | 亿元  | v6\_cz\_yszc\_jy   |
| 湖南     | 2013 | 教育        |  809.4540 | 亿元  | v6\_cz\_yszc\_jy   |
| 陕西     | 2012 | 合计        | 3323.8020 | 亿元  | v6\_cz\_yszc\_hj   |

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

| year | date     | NO              | index | title                                                                    | institution                  | chairman | funds | type                               | duration | NO\_head | NO\_year | NO\_mark | NO\_num | NO\_num\_p1 | NO\_num\_p2 | NO\_tail |
|:-----|:---------|:----------------|:------|:-------------------------------------------------------------------------|:-----------------------------|:---------|:------|:-----------------------------------|:---------|:---------|:---------|:---------|:--------|:------------|:------------|:---------|
| 2018 | 20191015 | 2018YFC1705400  | 1007  | 活动期溃疡性结肠炎（轻度-中度-重度）中医药治疗方案偱证优化及疗效机制研究 | 北京中医药大学               | 李军祥   | 1164  | 中医药现代化研究                   | NA       |          | 2018     | YFC      | 1705400 | 17          | 05400       | NA       |
| 2018 | 20191015 | 2018YFC0831300  | 604   | 内外贯通的审判执行与诉讼服务协同支撑技术研究                             | 中国社会科学院大学           | 林维     | 3049  | 公共安全风险防控与应急技术装备     | NA       |          | 2018     | YFC      | 0831300 | 08          | 31300       | NA       |
| 2020 | 20201223 | 2020YFB1711400  | 121   | 定制产品可视化智能设计与仿真验证关键技术及系统研发                       | 武汉天喻软件股份有限公司     | NA       | NA    | 网络协同制造和智能工厂             | 3        |          | 2020     | YFB      | 1711400 | 17          | 11400       | NA       |
| 2018 | 20191015 | 2018YFB2200500  | 1277  | 高迁移率CMOS与中红外光子器件及混合集成技术研究                           | 西安电子科技大学             | 韩根全   | 2340  | 光电子与微电子器件及集成           | NA       |          | 2018     | YFB      | 2200500 | 22          | 00500       | NA       |
| 2018 | 20191015 | SQ2018YFD020085 | 378   | 马铃薯化肥农药减施技术集成研究与示范                                     | 中国农业科学院蔬菜花卉研究所 | 熊兴耀   | 3945  | 化学肥料和农药减施增效综合技术研发 | NA       | SQ       | 2018     | YFD      | 020085  | 02          | 0085        | NA       |
| 2018 | 20191015 | 2018YFA0901100  | 1312  | 高灵敏环境持久性有毒污染物感知与识别生物系统                             | 中国科学院生态环境研究中心   | 赵斌     | 2404  | 合成生物学                         | NA       |          | 2018     | YFA      | 0901100 | 09          | 01100       | NA       |
| 2020 | 20201223 | 2020YFA0803500  | 332   | 肠道组织稳态维持的免疫调节机制                                           | 中国科学院生物物理研究所     | NA       | NA    | 发育编程及其代谢调节               | 5        |          | 2020     | YFA      | 0803500 | 08          | 03500       | NA       |
| 2018 | 20191015 | 2018YFD0401300  | 369   | 果蔬冷链物流技术及装备研发示范                                           | 海通食品集团有限公司         | 郜海燕   | 1934  | 现代食品加工及粮食收储运技术与装备 | NA       |          | 2018     | YFD      | 0401300 | 04          | 01300       | NA       |
| 2020 | 20201127 | 2020YFF0304300  | 22    | 国家游泳中心冬—夏运动场景转换技术研究及应用示范                          | 北京国家游泳中心有限责任公司 | NA       | NA    | “科技冬奥”重点专项                 | NA       |          | 2020     | YFF      | 0304300 | 03          | 04300       | NA       |
| 2020 | 20201127 | 2020YFA0309000  | 334   | 调控低维石墨烯材料中的量子多体效应                                       | 上海交通大学                 | NA       | NA    | 量子调控与量子信息                 | NA       |          | 2020     | YFA      | 0309000 | 03          | 09000       | NA       |

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

| index | batch | name                       | province |
|------:|:------|:---------------------------|:---------|
|    22 | 06    | 湖北荆门国家农业科技园区   | 湖北     |
|    46 | 05    | 新疆哈密国家农业科技园区   | 新疆     |
|    31 | 05    | 吉林延边国家农业科技园区   | 吉林     |
|    23 | 05    | 贵州黔西南国家农业科技园区 | 贵州     |
|    37 | 05    | 山东泰安国家农业科技园区   | 山东     |
|    20 | 06    | 浙江象山国家农业科技园区   | 浙江     |
|     9 | 01    | 重庆渝北国家农业科技园区   | 重庆     |
|     5 | 07    | 青海海南国家农业科技园区   | 青海     |
|    15 | 03    | 天津滨海国家农业科技园区   | 天津     |
|    10 | 06    | 重庆丰都国家农业科技园区   | 重庆     |

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

| year | index | name                     | result | province |
|-----:|------:|:-------------------------|:-------|:---------|
| 2019 |    29 | 福建漳州国家农业科技园区 | ok     | 福建     |
| 2020 |    10 | 山东临沂国家农业科技园区 | ok     | 山东     |
| 2020 |     2 | 安徽池州国家农业科技园区 | fail   | 安徽     |
| 2019 |    77 | 新疆和田国家农业科技园区 | ok     | 新疆     |
| 2019 |    63 | 西藏拉萨国家农业科技园区 | ok     | 西藏     |
| 2019 |    14 | 湖南望城国家农业科技园区 | good   | 湖南     |
| 2019 |    35 | 江西上饶国家农业科技园区 | ok     | 江西     |
| 2019 |    13 | 湖北武汉国家农业科技园区 | good   | 湖北     |
| 2019 |    49 | 广东珠海国家农业科技园区 | ok     | 广东     |
| 2019 |    41 | 河南鹤壁国家农业科技园区 | ok     | 河南     |

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

| officer | year | index | name                                                     | institution                            | province |
|:--------|-----:|:------|:---------------------------------------------------------|:---------------------------------------|:---------|
| MOE     | 2019 | 21    | 甘南草原生态系统教育部野外科学观测研究站                 | 兰州大学                               | 甘肃     |
| MOA     | 2019 | 35    | 国家农业科学农业种质资源南京观测实验站                   | 南京农业大学                           | 江苏     |
| MOA     | 2019 | 18    | 国家农业科学渔业资源环境广州观测实验站                   | 中国水产科学研究院珠江水产研究所       | 广东     |
| MOA     | 2019 | 67    | 国家农业科学农业环境沈阳观测实验站                       | 中国科学院沈阳应用生态研究所           | 辽宁     |
| MOA     | 2018 | 17    | 国家土壤质量伊宁观测实验站                               | 伊犁州农业科学研究所                   | 新疆     |
| MOA     | 2019 | 38    | 国家农业科学农业环境潜江观测实验站                       | 湖北省农业科学院                       | 湖北     |
| MOE     | 2019 | 50    | 河北曲周绿色农业教育部野外科学观测研究站                 | 中国农业大学                           | 北京     |
| MOA     | 2019 | 30    | 国家农业科学土壤质量武川观测实验站                       | 内蒙古农牧业科学院                     | 内蒙古   |
| MOE     | 2019 | 41    | 三峡库区紫色土土壤质量与生态环境教育部野外科学观测研究站 | 西南大学                               | 重庆     |
| MOA     | 2018 | 3     | 国家土壤质量昌平观测实验站                               | 中国农业科学院农业资源与农业区划研究所 | 北京     |

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

| year | index | province | type                     | name\_origin                   | name\_change             | mark     |
|:-----|:------|:---------|:-------------------------|:-------------------------------|:-------------------------|:---------|
| 2011 | 7     | 湖北     | 国家生猪核心育种场       | 湖北金林原种畜牧有限公司       | NA                       | 遴选公示 |
| 2015 | 10    | 山东     | 国家生猪核心育种场       | 山东华特希尔育种有限公司       | NA                       | 遴选公示 |
| 2012 | 15    | 广西     | 国家生猪核心育种场       | 桂林美冠原种猪育种有限责任公司 | NA                       | 遴选公示 |
| 2016 | 1     | 河北     | 国家蛋鸡良种扩繁推广基地 | 曲周县北农大禽业有限公司       | NA                       | 遴选公示 |
| 2015 | 5     | 福建     | 国家肉鸡良种扩繁推广基地 | 福建圣农发展股份有限公司       | NA                       | 遴选公示 |
| 2015 | 2     | 江苏     | 国家肉鸡良种扩繁推广基地 | 江苏立华牧业有限公司           | NA                       | 遴选公示 |
| 2010 | 13    | 广东     | 国家生猪核心育种场       | 深圳市农牧实业有限公司         | NA                       | 遴选公示 |
| 2020 | 14    | 广西     | NA                       | 广西桂宁种猪有限公司           | 广西里建桂宁种猪有限公司 | 名称变更 |
| 2015 | 18    | 四川     | 国家生猪核心育种场       | 绵阳明兴农业科技开发有限公司   | NA                       | 遴选公示 |
| 2019 | 4     | 内蒙古   | 国家肉羊核心育种场       | 苏尼特右旗苏尼特羊良种场       | NA                       | 遴选公示 |
