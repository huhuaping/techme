
<!-- README.md is generated from README.Rmd. Please edit that file -->

# techme

<!-- badges: start -->
<!-- badges: end -->

The goal of `techme` is to supply basic data sets and toolsets to
generate research report( 《中国旱区农业技术发展报告》).

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
#> Loading required package: techme
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
information, such as unit, chn_name, eng_name etc., with wide data
format.

- Totally 16 columns including: variables, chn_full_name, short_chn,
  short_eng, units, block1, block2, block3, block4, chn_block1,
  chn_block2, chn_block3, chn_block4, chn_full, flag, source.

- Totally 610 rows.

``` r
varsList %>%
  sample_n(size = 10) %>%
  kable()
```

| variables                  | chn_full_name   | short_chn | short_eng | units  | block1 | block2    | block3 | block4  | chn_block1 | chn_block2             | chn_block3       | chn_block4     | chn_full                      | flag    | source           |
|:---------------------------|:----------------|:----------|:----------|:-------|:-------|:----------|:-------|:--------|:-----------|:-----------------------|:-----------------|:---------------|:------------------------------|:--------|:-----------------|
| v1_sc_bzmj_gl              | 播种面积_高粱   | NA        | NA        | 千公顷 | v1     | sc        | bzmj   | gl      | 农业       | 生产                   | 播种面积         | 高粱           | 农业;生产;播种面积;高粱       | v2018.6 | NA               |
| v3_stzh_mj_czhj            | NA              | NA        | NA        | 千公顷 | v3     | stzh      | mj     | czhj    | 生态       | 生态灾害               | 面积             | 成灾面积       | 生态;生态灾害;面积;成灾面积   | v2018.6 | NA               |
| v4_qy_xcp_kfjf             | NA              | NA        | NA        | 万元   | v4     | qy        | xcp    | kfjf    | 科技       | 企业                   | 新产品开发和销售 | 开发经费支出   | NA                            | v2019.8 | NA               |
| v4_cg_zlsq_hj              | NA              | NA        | NA        | 件     | v4     | cg        | zlsq   | hj      | 科技       | 成果                   | 专利授权         | 合计           | NA                            | v2019.8 | NA               |
| v4_cy_xcp_ck               | NA              | 出口      | export    | 万元   | v4     | cy        | xcp    | ck      | 科技       | 高新产业               | 新产品开发和销售 | 出口           | NA                            | v2019.8 | NA               |
| v99_obstation_list_officer | NA              | 公示部门  | officer   | NA     | v99    | obstation | list   | officer | 公共网站   | 国家野外科学观测研究站 | 名单             | 公示部门       | NA                            | v2022.7 | 科技部网站       |
| v2_yl_sl_rys               | 医疗卫生_人员数 | NA        | NA        | 人     | v2     | yl        | sl     | rys     | 社会       | 医疗                   | 数量             | 医疗卫生人员数 | 社会;医疗;数量;医疗卫生人员数 | v2018.6 | NA               |
| v4_cg_zcsb_zcs             | NA              | NA        | NA        | 件     | v4     | cg        | zcsb   | zcs     | 科技       | 成果                   | 注册商标         | 核准数         | NA                            | v2019.8 | NA               |
| v4_gx_wbzc_jwjg            | NA              | NA        | NA        | 万元   | v4     | gx        | wbzc   | jwjg    | 科技       | 高校                   | 外部支出         | 对境外机构支出 | NA                            | v2019.8 | NA               |
| v8_t7_cczcq_zxmyc          | NA              | NA        | NA        | 只     | v8     | t7        | cczcq  | zxmyc   | 种畜禽场站 | 表7                    | 出场种畜禽       | 种细毛羊场     | NA                            | v2021.8 | 中国畜牧兽医年鉴 |

#### BasicProvince

**`BasicProvince`**：A data set containing basic information of province
and its region, with wide data format.

- Totally 3 columns including: id, province, region_pro.

- Totally 32 rows.

``` r
BasicProvince %>%
  sample_n(size = 10) %>%
  kable()
```

|  id | province | region_pro |
|----:|:---------|:-----------|
|   1 | 北京     | 旱区       |
|  20 | 广西     | 非旱区     |
|  12 | 安徽     | 非旱区     |
|  21 | 海南     | 非旱区     |
|  30 | 宁夏     | 旱区       |
|  15 | 山东     | 旱区       |
|  25 | 云南     | 非旱区     |
|  22 | 重庆     | 非旱区     |
|  14 | 江西     | 非旱区     |
|   4 | 山西     | 旱区       |

#### ProvinceCity

**`ProvinceCity`**：A data set containing Province and City of china.

- Totally 6 columns including: index, province, city, id,
  province_clean, city_clean.

- Totally 342 rows.

``` r
ProvinceCity %>%
  sample_n(size = 10) %>%
  kable()
```

| index | province | city   | id           | province_clean | city_clean |
|------:|:---------|:-------|:-------------|:---------------|:-----------|
|   172 | 湖北省   | 襄阳市 | 420600000000 | 湖北           | 襄阳       |
|    55 | 吉林省   | 通化市 | 220500000000 | 吉林           | 通化       |
|    73 | 上海市   | 市辖区 | 310100000000 | 上海           | uncheck    |
|   301 | 甘肃省   | 兰州市 | 620100000000 | 甘肃           | 兰州       |
|   165 | 河南省   | 周口市 | 411600000000 | 河南           | 周口       |
|    56 | 吉林省   | 白山市 | 220600000000 | 吉林           | 白山       |
|   211 | 广东省   | 清远市 | 441800000000 | 广东           | 清远       |
|   197 | 广东省   | 韶关市 | 440200000000 | 广东           | 韶关       |
|     6 | 河北省   | 邯郸市 | 130400000000 | 河北           | 邯郸       |
|   209 | 广东省   | 河源市 | 441600000000 | 广东           | 河源       |

#### 

**`queryTianyan`**：A data set containing basic info of institution
enrolled in officer administrator.

- Totally 9 columns including: index, name_origin, name_search, address,
  tel, url, province, city, province_raw.

- Totally 517 rows.

``` r
AgriMachine %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4         |  value | units  | variables            |
|:---------|:-----|:-------------------|-------:|:-------|:---------------------|
| 湖南     | 2013 | 机收面积           |     NA | 千公顷 | v7_sctj_nyjx_jsmj    |
| 河北     | 2013 | 机动脱粒机         |  20.71 | 万台   | v7_sctj_nyjx_jdtlj   |
| 北京     | 2012 | 节水灌溉类机械     |   1.05 | 万套   | v7_sctj_nyjx_jsgg    |
| 陕西     | 2015 | 农用排灌电动机     |  33.34 | 万台   | v7_sctj_nyjx_pgddj   |
| 湖北     | 2010 | 农用水泵           |  85.49 | 万台   | v7_sctj_nyjx_nysb    |
| 福建     | 2014 | 机动脱粒机         |  11.03 | 万台   | v7_sctj_nyjx_jdtlj   |
| 宁夏     | 2015 | 小型拖拉机配套农具 |  23.11 | 万部   | v7_sctj_nyjx_xtlj_pt |
| 甘肃     | 2012 | 机动脱粒机         |  19.58 | 万台   | v7_sctj_nyjx_jdtlj   |
| 重庆     | 2019 | 机动脱粒机         |  74.50 | 万部   | v7_sctj_nyjx_jdtlj   |
| 湖南     | 2017 | 农用排灌电动机     | 113.50 | 万台   | v7_sctj_nyjx_pgddj   |

### Yearbook

#### Data from Rural Yearbook

##### AgriMachine

**`AgriMachine`**：A **long format** data set containing Agricultural
Machine statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 4736 rows.

- Years range from 2010 to 2020

- Variables including: v7_sctj_nyjx_dztlj, v7_sctj_nyjx_dztlj_pt,
  v7_sctj_nyjx_jbmj, v7_sctj_nyjx_jdtlj, v7_sctj_nyjx_jgmj,
  v7_sctj_nyjx_jsgg, v7_sctj_nyjx_jsmj, v7_sctj_nyjx_lhshj,
  v7_sctj_nyjx_nysb, v7_sctj_nyjx_pgcyj, v7_sctj_nyjx_pgddj,
  v7_sctj_nyjx_xtlj, v7_sctj_nyjx_xtlj_pt, v7_sctj_nyjx_zdl

``` r
AgriMachine %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4         |   value | units  | variables            |
|:---------|:-----|:-------------------|--------:|:-------|:---------------------|
| 甘肃     | 2012 | 小型拖拉机配套农具 |  105.18 | 万部   | v7_sctj_nyjx_xtlj_pt |
| 山西     | 2010 | 农用排灌柴油机     |    2.14 | 万台   | v7_sctj_nyjx_pgcyj   |
| 陕西     | 2016 | 机播面积           | 2075.80 | 千公顷 | v7_sctj_nyjx_jbmj    |
| 甘肃     | 2019 | 农用水泵           |   12.80 | 万台   | v7_sctj_nyjx_nysb    |
| 贵州     | 2011 | 农业机械总动力     | 1851.40 | 万千瓦 | v7_sctj_nyjx_zdl     |
| 河北     | 2016 | 机动脱粒机         |   19.33 | 万台   | v7_sctj_nyjx_jdtlj   |
| 四川     | 2013 | 机播面积           |      NA | 千公顷 | v7_sctj_nyjx_jbmj    |
| 甘肃     | 2011 | 机收面积           |      NA | 千公顷 | v7_sctj_nyjx_jsmj    |
| 青海     | 2018 | 小型拖拉机配套农具 |      NA | 万部   | v7_sctj_nyjx_xtlj_pt |
| 安徽     | 2013 | 节水灌溉类机械     |   20.28 | 万套   | v7_sctj_nyjx_jsgg    |

##### AgriFertilizer

**`AgriFertilizer`**：A **long format** data set containing Agricultural
Fertilizer statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 608 rows.

- Years range from 2010 to 2020

- Variables including: v7_sctj_nyhf_df, v7_sctj_nyhf_fhf,
  v7_sctj_nyhf_hj, v7_sctj_nyhf_jf, v7_sctj_nyhf_lf

``` r
AgriFertilizer %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 | value | units | variables       |
|:---------|:-----|:-----------|------:|:------|:----------------|
| 浙江     | 2020 | 化肥使用量 |  69.6 | 万吨  | v7_sctj_nyhf_hj |
| 辽宁     | 2019 | 磷肥       |   9.5 | 万吨  | v7_sctj_nyhf_lf |
| 宁夏     | 2019 | 化肥使用量 |  38.4 | 万吨  | v7_sctj_nyhf_hj |
| 天津     | 2013 | 化肥使用量 |  24.3 | 万吨  | v7_sctj_nyhf_hj |
| 湖南     | 2019 | 钾肥       |  37.6 | 万吨  | v7_sctj_nyhf_jf |
| 江苏     | 2013 | 化肥使用量 | 326.8 | 万吨  | v7_sctj_nyhf_hj |
| 甘肃     | 2016 | 化肥使用量 |  93.4 | 万吨  | v7_sctj_nyhf_hj |
| 广西     | 2019 | 钾肥       |  55.1 | 万吨  | v7_sctj_nyhf_jf |
| 广东     | 2020 | 磷肥       |  25.8 | 万吨  | v7_sctj_nyhf_lf |
| 云南     | 2016 | 化肥使用量 | 235.6 | 万吨  | v7_sctj_nyhf_hj |

##### AgriPlastic

**`AgriPlastic`**：A **long format** data set containing Agricultural
Plastic statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1056 rows.

- Years range from 2010 to 2020

- Variables including: v7_sctj_nybm_bmsy, v7_sctj_nybm_dmfg,
  v7_sctj_nybm_dmsy

``` r
AgriPlastic %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4     |   value | units | variables         |
|:---------|:-----|:---------------|--------:|:------|:------------------|
| 北京     | 2010 | NA             |    4344 | NA    | v7_sctj_nybm_dmsy |
| 陕西     | 2015 | NA             |  454135 | NA    | v7_sctj_nybm_dmfg |
| 吉林     | 2010 | 农用薄膜使用量 |   52552 | 吨    | v7_sctj_nybm_bmsy |
| 吉林     | 2010 | NA             |  131531 | NA    | v7_sctj_nybm_dmfg |
| 浙江     | 2013 | NA             |  165559 | NA    | v7_sctj_nybm_dmfg |
| 河南     | 2014 | 农用薄膜使用量 |  163477 | 吨    | v7_sctj_nybm_bmsy |
| 新疆     | 2013 | NA             |  175790 | NA    | v7_sctj_nybm_dmsy |
| 青海     | 2013 | 农用薄膜使用量 |    6472 | 吨    | v7_sctj_nybm_bmsy |
| 甘肃     | 2011 | NA             | 1100860 | NA    | v7_sctj_nybm_dmfg |
| 天津     | 2016 | NA             |    3942 | NA    | v7_sctj_nybm_dmsy |

##### AgriPesticide

**`AgriPesticide`**：A **long format** data set containing Agricultural
Pesticide statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 416 rows.

- Years range from 2010 to 2020

- Variables including: v7_sctj_cyny_cysy, v7_sctj_cyny_nysy

``` r
AgriPesticide %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4     |   value | units | variables         |
|:---------|:-----|:---------------|--------:|:------|:------------------|
| 宁夏     | 2018 | 农药使用量     |  2266.0 | 吨    | v7_sctj_cyny_nysy |
| 宁夏     | 2020 | 农药使用量     |  2174.0 | 吨    | v7_sctj_cyny_nysy |
| 重庆     | 2016 | 农药使用量     | 17604.0 | 吨    | v7_sctj_cyny_nysy |
| 北京     | 2018 | 农药使用量     |  2574.0 | 吨    | v7_sctj_cyny_nysy |
| 四川     | 2012 | 农药使用量     | 60317.0 | 吨    | v7_sctj_cyny_nysy |
| 新疆     | 2020 | 农用柴油使用量 |    85.2 | 万吨  | v7_sctj_cyny_cysy |
| 新疆     | 2016 | 农药使用量     | 27596.0 | 吨    | v7_sctj_cyny_nysy |
| 北京     | 2017 | 农药使用量     |  2726.0 | 吨    | v7_sctj_cyny_nysy |
| 青海     | 2010 | 农药使用量     |  2062.0 | 吨    | v7_sctj_cyny_nysy |
| 新疆     | 2011 | 农药使用量     | 19340.0 | 吨    | v7_sctj_cyny_nysy |

#### Data from Sci-Tech Yearbook

##### RDIntense

**`RDIntense`**：A **long format** data set containing R&D Intense
statistics.

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 640 rows.

- Years range from 2011 to 2020

- Variables including: v4_ztr_jf_RD, v4_ztr_qd_RD

``` r
RDIntense %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |    value | units | variables    |
|:---------|:-----|:-----------|---------:|:------|:-------------|
| 黑龙江   | 2019 | RD强度     |     1.08 | %     | v4_ztr_qd_RD |
| 全国     | 2016 | RD经费     | 15676.70 | 亿元  | v4_ztr_jf_RD |
| 湖北     | 2019 | RD经费     |   957.90 | 亿元  | v4_ztr_jf_RD |
| 黑龙江   | 2011 | RD经费     |   128.80 | 亿元  | v4_ztr_jf_RD |
| 青海     | 2012 | RD经费     |    13.10 | 亿元  | v4_ztr_jf_RD |
| 内蒙古   | 2015 | RD经费     |   136.10 | 亿元  | v4_ztr_jf_RD |
| 内蒙古   | 2019 | RD强度     |     0.86 | %     | v4_ztr_qd_RD |
| 江西     | 2012 | RD经费     |   113.70 | 亿元  | v4_ztr_jf_RD |
| 河北     | 2013 | RD强度     |     1.00 | %     | v4_ztr_qd_RD |
| 吉林     | 2016 | RD经费     |   139.70 | 亿元  | v4_ztr_jf_RD |

##### RDActivity

**`RDActivity`**：A **long format** data set containing R&D Activity
statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1408 rows.

- Years range from 2010 to 2020

- Variables including: v4_zh_nbzc_hj, v4_zh_nbzc_jcyj, v4_zh_nbzc_syfz,
  v4_zh_nbzc_yyyj

``` r
RDActivity %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |     value | units | variables       |
|:---------|:-----|:-----------|----------:|:------|:----------------|
| 浙江     | 2010 | 试验发展   | 4526436.8 | 万元  | v4_zh_nbzc_syfz |
| 海南     | 2019 | 基础研究   |   57121.0 | 万元  | v4_zh_nbzc_jcyj |
| 天津     | 2017 | 合计       | 4587227.2 | 万元  | v4_zh_nbzc_hj   |
| 陕西     | 2019 | 应用研究   | 1053954.0 | 万元  | v4_zh_nbzc_yyyj |
| 四川     | 2017 | 应用研究   |  873480.0 | 万元  | v4_zh_nbzc_yyyj |
| 安徽     | 2017 | 基础研究   |  370369.6 | 万元  | v4_zh_nbzc_jcyj |
| 宁夏     | 2016 | 基础研究   |   24399.4 | 万元  | v4_zh_nbzc_jcyj |
| 内蒙古   | 2017 | 应用研究   |  104900.1 | 万元  | v4_zh_nbzc_yyyj |
| 广东     | 2019 | 应用研究   | 2472767.0 | 万元  | v4_zh_nbzc_yyyj |
| 江西     | 2017 | 试验发展   | 2330730.9 | 万元  | v4_zh_nbzc_syfz |

##### IndustryOperation

**`IndustryOperation`**：A **long format** data set containing Industry
Operation statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 480 rows.

- Years range from 2015 to 2020

- Variables including: v4_cy_scjy_lrze, v4_cy_scjy_qys, v4_cy_scjy_zyyw

``` r
IndustryOperation %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4   |     value | units | variables       |
|:---------|:-----|:-------------|----------:|:------|:----------------|
| 北京     | 2019 | 利润总额     |   522.000 | 亿元  | v4_cy_scjy_lrze |
| 湖北     | 2016 | 主营业务收入 |  4211.884 | 亿元  | v4_cy_scjy_zyyw |
| 广东     | 2019 | 主营业务收入 | 46723.000 | 亿元  | v4_cy_scjy_zyyw |
| 广西     | 2020 | 利润总额     |    86.000 | 亿元  | v4_cy_scjy_lrze |
| 河北     | 2020 | 主营业务收入 |  1712.000 | 亿元  | v4_cy_scjy_zyyw |
| 湖南     | 2016 | 主营业务收入 |  3661.293 | 亿元  | v4_cy_scjy_zyyw |
| 安徽     | 2016 | 主营业务收入 |  3587.566 | 亿元  | v4_cy_scjy_zyyw |
| 甘肃     | 2018 | 企业数       |   119.000 | 个    | v4_cy_scjy_qys  |
| 西藏     | 2019 | 主营业务收入 |    16.000 | 亿元  | v4_cy_scjy_zyyw |
| 青海     | 2019 | 主营业务收入 |   131.000 | 亿元  | v4_cy_scjy_zyyw |

##### IndustryRD

**`IndustryRD`**：A **long format** data set containing Industry R&D
statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 2624 rows.

- Years range from 2016 to 2020

- Variables including: v4_cy_cytz_gdzc, v4_cy_cytz_jcxm,
  v4_cy_cytz_kgxm, v4_cy_cytz_sgxm, v4_cy_cytz_tzze, v4_cy_jsgz_gmzc,
  v4_cy_jsgz_gzzc, v4_cy_jsgz_xszc, v4_cy_jsgz_yjzc, v4_cy_qyzl_fms,
  v4_cy_qyzl_sqs, v4_cy_qyzl_yxs, v4_cy_RDhd_nbzc, v4_cy_RDhd_qsdl,
  v4_cy_RDhd_xmjf, v4_cy_RDhd_xmsl, v4_cy_RDhd_yfjgs, v4_cy_xcp_ck,
  v4_cy_xcp_kfjf, v4_cy_xcp_kfxm, v4_cy_xcp_xssr

``` r
IndustryRD %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4           |      value | units | variables        |
|:---------|:-----|:---------------------|-----------:|:------|:-----------------|
| 陕西     | 2019 | 经费内部支出         |   977969.0 | 万元  | v4_cy_RDhd_nbzc  |
| 安徽     | 2016 | 消化吸收经费支出     |     6684.5 | 万元  | v4_cy_jsgz_xszc  |
| 河北     | 2018 | 有效专利数           |     3373.0 | 件    | v4_cy_qyzl_yxs   |
| 辽宁     | 2016 | 研发机构数           |      100.0 | 个    | v4_cy_RDhd_yfjgs |
| 安徽     | 2017 | 经费内部支出         |   797670.4 | 万元  | v4_cy_RDhd_nbzc  |
| 广西     | 2018 | 人员折合全时当量     |     1846.0 | 人年  | v4_cy_RDhd_qsdl  |
| 福建     | 2016 | 购买境内技术经费支出 |    25416.0 | 万元  | v4_cy_jsgz_gmzc  |
| 浙江     | 2017 | 开发项目数           |    11742.0 | 项    | v4_cy_xcp_kfxm   |
| 湖南     | 2018 | 销售收入             | 10613987.0 | 万元  | v4_cy_xcp_xssr   |
| 广西     | 2016 | 施工项目个数         |      958.0 | 个    | v4_cy_cytz_sgxm  |

##### IndustryTrade

**`IndustryTrade`**：A **long format** data set containing Industry
Trade statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 288 rows.

- Years range from 2016 to 2018

- Variables including: v4_cy_my_ck, v4_cy_my_jck, v4_cy_my_jk

``` r
IndustryTrade %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |       value | units    | variables    |
|:---------|:-----|:-----------|------------:|:---------|:-------------|
| 河北     | 2018 | 出口贸易额 |   2855.0000 | 百万美元 | v4_cy_my_ck  |
| 甘肃     | 2016 | 进口贸易额 |    497.1035 | 百万美元 | v4_cy_my_jk  |
| 广东     | 2016 | 贸易总额   | 403330.1119 | 百万美元 | v4_cy_my_jck |
| 山西     | 2018 | 贸易总额   |  11594.0000 | 百万美元 | v4_cy_my_jck |
| 北京     | 2016 | 出口贸易额 |  11318.7470 | 百万美元 | v4_cy_my_ck  |
| 陕西     | 2018 | 出口贸易额 |  25114.0000 | 百万美元 | v4_cy_my_ck  |
| 云南     | 2017 | 出口贸易额 |   1640.6480 | 百万美元 | v4_cy_my_ck  |
| 内蒙古   | 2016 | 贸易总额   |   1177.0843 | 百万美元 | v4_cy_my_jck |
| 宁夏     | 2016 | 进口贸易额 |     32.3002 | 百万美元 | v4_cy_my_jk  |
| 重庆     | 2017 | 贸易总额   |  41210.3635 | 百万美元 | v4_cy_my_jck |

##### MarketPull

**`MarketPull`**：A **long format** data set containing Tech Market Pull
statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 768 rows.

- Years range from 2000 to 2020

- Variables including: v4_cg_jssr_ht, v4_cg_jssr_je

``` r
MarketPull %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |     value | units | variables     |
|:---------|:-----|:-----------|----------:|:------|:--------------|
| 河北     | 2014 | 金额       | 1528309.1 | 万元  | v4_cg_jssr_je |
| 天津     | 2015 | 金额       | 3307078.6 | 万元  | v4_cg_jssr_je |
| 陕西     | 2005 | 数量       |    3427.0 | 项    | v4_cg_jssr_ht |
| 江西     | 2013 | 金额       | 1077970.1 | 万元  | v4_cg_jssr_je |
| 新疆     | 2005 | 金额       |  156020.7 | 万元  | v4_cg_jssr_je |
| 安徽     | 2005 | 金额       |  204343.7 | 万元  | v4_cg_jssr_je |
| 甘肃     | 2010 | 数量       |    2462.0 | 项    | v4_cg_jssr_ht |
| 江西     | 2000 | 金额       |   66104.0 | 万元  | v4_cg_jssr_je |
| 陕西     | 2015 | 金额       | 2985237.2 | 万元  | v4_cg_jssr_je |
| 河南     | 2013 | 数量       |    5556.0 | 项    | v4_cg_jssr_ht |

##### MarketPush

**`MarketPush`**：A **long format** data set containing Tech Market Push
statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 768 rows.

- Years range from 2000 to 2020

- Variables including: v4_cg_jssc_ht, v4_cg_jssc_je

``` r
MarketPush %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |     value | units | variables     |
|:---------|:-----|:-----------|----------:|:------|:--------------|
| 云南     | 2010 | 数量       |    1047.0 | 项    | v4_cg_jssc_ht |
| 河北     | 2010 | 金额       |  192930.9 | 万元  | v4_cg_jssc_je |
| 山东     | 2015 | 金额       | 3075545.1 | 万元  | v4_cg_jssc_je |
| 重庆     | 2010 | 数量       |    2201.0 | 项    | v4_cg_jssc_ht |
| 贵州     | 2000 | 金额       |     620.0 | 万元  | v4_cg_jssc_je |
| 天津     | 2017 | 数量       |   12168.0 | 项    | v4_cg_jssc_ht |
| 天津     | 2019 | 金额       | 9092549.0 | 万元  | v4_cg_jssc_je |
| 吉林     | 2013 | 数量       |    3252.0 | 项    | v4_cg_jssc_ht |
| 内蒙古   | 2005 | 数量       |    1160.0 | 项    | v4_cg_jssc_ht |
| 上海     | 2017 | 金额       | 8106176.5 | 万元  | v4_cg_jssc_je |

#### Data from China National Yearbook

##### PublicBudget

**`PublicBudget`**：A **long format** data set containing Public Budget
statistics.

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1372 rows.

- Years range from 2010 to 2020

- Variables including: v6_cz_yszc_hj, v6_cz_yszc_jy, v6_cz_yszc_kxjs,
  v6_cz_yszc_nls

#### Data from Livestock Yearbook

``` r
PublicBudget %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |     value | units | variables       |
|:---------|:-----|:-----------|----------:|:------|:----------------|
| 四川     | 2020 | 科学技术   |  181.7000 | 亿元  | v6_cz_yszc_kxjs |
| 江苏     | 2012 | 农林水     |  754.0892 | 亿元  | v6_cz_yszc_nls  |
| 新疆     | 2010 | 科学技术   |   20.1869 | 亿元  | v6_cz_yszc_kxjs |
| 重庆     | 2013 | 合计       | 3062.2848 | 亿元  | v6_cz_yszc_hj   |
| 福建     | 2010 | 科学技术   |   32.3057 | 亿元  | v6_cz_yszc_kxjs |
| 广西     | 2016 | 农林水     |  573.4800 | 亿元  | v6_cz_yszc_nls  |
| 辽宁     | 2016 | 科学技术   |   61.6100 | 亿元  | v6_cz_yszc_kxjs |
| 山东     | 2017 | 合计       | 9258.3984 | 亿元  | v6_cz_yszc_hj   |
| 浙江     | 2014 | 农林水     |  524.5892 | 亿元  | v6_cz_yszc_nls  |
| 浙江     | 2018 | 科学技术   |  379.6600 | 亿元  | v6_cz_yszc_kxjs |

**`LivestockBreeding`**：A **long format** data set containing Livestock
Breeding statistics.

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 23712 rows.

- Years range from 2011 to 2018

- Variables including: v8_t1_zcqc_zhnc, v8_t1_zcqc_zmc,
  v8_t1_zcqc_zmsyc, v8_t1_zcqc_zmyc, v8_t1_zcqc_znc, v8_t1_zcqc_znnc1,
  v8_t1_zcqc_znnc2, v8_t1_zcqc_zrnc, v8_t1_zcqc_zs, v8_t1_zcqc_zsnc,
  v8_t1_zcqc_zsyc, v8_t1_zcqc_zxmyc, v8_t1_zcqc_zyc, v8_t1_zcqc_zzc,
  v8_t2_zcqc_fmddjc, v8_t2_zcqc_fmdrjc, v8_t2_zcqc_qt, v8_t2_zcqc_zdjc,
  v8_t2_zcqc_zdjysdjc, v8_t2_zcqc_zdjysrjc（top 20 of totally 98
  variables.

### Public site

#### Data from MOST

Several data set sources from Ministry of Sci-Tech (MOST).

##### PubNKRDP

**`PubNKRDP`**：A **wide format** data set containing Details of
National Key R&D Plans(NKRDP) statistics.

- Totally 17 columns including: year, date, NO, index, title,
  institution, chairman, funds, type, duration, NO_head, NO_year,
  NO_mark, NO_num, NO_num_p1, NO_num_p2, NO_tail.

- Totally 2579 rows.

- Years range from 2018 to 2020

``` r
PubNKRDP %>%
  sample_n(size = 10) %>%
  kable()
```

| year | date     | NO             | index | title                                                                            | institution                      | chairman | funds | type                             | duration | NO_head | NO_year | NO_mark | NO_num  | NO_num_p1 | NO_num_p2 | NO_tail |
|:-----|:---------|:---------------|:------|:---------------------------------------------------------------------------------|:---------------------------------|:---------|:------|:---------------------------------|:---------|:--------|:--------|:--------|:--------|:----------|:----------|:--------|
| 2018 | 20191015 | 2018YFB0504700 | 137   | 红外发射谱段空间辐射基准载荷技术                                                 | 中国科学院上海技术物理研究所     | 丁雷     | 8020  | 地球观测与导航                   | NA       |         | 2018    | YFB     | 0504700 | 05        | 04700     | NA      |
| 2020 | 20201223 | 2020YFA0113500 | 222   | 干细胞源性0TS型自然杀伤 细胞高效获取体系建立及其异 体移植的肿瘤免疫治疗策略研 究 | 中国人民解放军第三军医大学       | NA       | NA    | 干细胞及转化研究                 | 5年      |         | 2020    | YFA     | 0113500 | 01        | 13500     | NA      |
| 2018 | 20191015 | 2018YFB0104500 | 214   | 商用车高可靠性电力电子集成系统开发                                               | 湖南中车时代电动汽车股份有限公司 | 司唐广笛 | 1226  | 新能源汽车                       | NA       |         | 2018    | YFB     | 0104500 | 01        | 04500     | NA      |
| 2018 | 20191015 | 2018YFC0115100 | 633   | 混合现实辅助消化内镜机器人精准微创治疗技术研究                                   | 中国科学院沈阳自动化研究所       | 刘浩     | 400   | 数字诊疗装备研发                 | NA       |         | 2018    | YFC     | 0115100 | 01        | 15100     | NA      |
| 2018 | 20191015 | 2018YFC1506000 | 835   | 东亚季风气候年际预测理论与方法研究                                               | 国家气候中心                     | 任宏利   | 1921  | 重大自然灾害监测预警与防范       | NA       |         | 2018    | YFC     | 1506000 | 15        | 06000     | NA      |
| 2018 | 20191015 | 2018YFC1705600 | 1009  | 慢性失眠中医诊疗新方案及机制研究                                                 | 湖北中医药大学                   | 王平     | 308   | 中医药现代化研究                 | NA       |         | 2018    | YFC     | 1705600 | 17        | 05600     | NA      |
| 2018 | 20191015 | 2018YFD0100100 | 319   | 西南及南方抗逆高产耐瘠薄玉米新品种培育                                           | 四川农业大学                     | 兰海     | 2672  | 七大农作物育种                   | NA       |         | 2018    | YFD     | 0100100 | 01        | 00100     | NA      |
| 2020 | 20201223 | 2020YFB1710600 | 113   | 面向定制化的高端电池大批量制造过程的智能管控技术开发                             | 天能电池集团股份有限公司         | NA       | NA    | 网络协同制造和智能工厂           | 3        |         | 2020    | YFB     | 1710600 | 17        | 10600     | NA      |
| 2018 | 20191015 | 2018YFF0213400 | 251   | 农产品产地环境评价分级与保护改良共性标准研究                                     | 山东大学                         | 崔兆杰   | 371   | 国家质量基础的共性技术研究与应用 | NA       |         | 2018    | YFF     | 0213400 | 02        | 13400     | NA      |
| 2018 | 20191015 | 2018YFB1003900 | 121   | 基于编程现场大数据的软件智能开发方法和环境                                       | 北京百度网讯科技有限公司         | 王海峰   | 2604  | 云计算和大数据                   | NA       |         | 2018    | YFB     | 1003900 | 10        | 03900     | NA      |

##### PubAgriParkList

**`PubAgriParkList`**：A **wide format** data set containing Details of
Approved List of National Agricultural Sci-tech Park.

- Totally 4 columns including: index, batch, name, province.

- Totally 233 rows.

- Years (Batch) range from 01 to 09

``` r
PubAgriParkList %>%
  sample_n(size = 10) %>%
  kable()
```

| index | batch | name                       | province |
|------:|:------|:---------------------------|:---------|
|    10 | 07    | 云南马龙现代农业科技园区   | 云南     |
|     7 | 09    | 江苏常州国家农业科技园区   | 江苏     |
|    18 | 08    | 湖南张家界国家农业科技园区 | 湖南     |
|    24 | 09    | 青海黄南国家农业科技园区   | 青海     |
|    11 | 07    | 重庆江津国家农业科技园区   | 重庆     |
|    19 | 09    | 重庆武隆国家农业科技园区   | 重庆     |
|    26 | 06    | 云南玉溪国家农业科技园区   | 云南     |
|    32 | 06    | 陕西汉中国家农业科技园区   | 陕西     |
|    29 | 06    | 甘肃张掖国家农业科技园区   | 甘肃     |
|    14 | 03    | 北京顺义国家农业科技园区   | 北京     |

##### PubAgriParkEval

**`PubAgriParkEval`**：A **wide format** data set containing Details of
Evaluation result of National Agricultural Sci-tech Park.

- Totally 5 columns including: year, index, name, result, province.

- Totally 249 rows.

- Years range from 2019 to 2021

``` r
PubAgriParkEval %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | name                                   | result | province |
|-----:|------:|:---------------------------------------|:-------|:---------|
| 2021 |     4 | 海南陵水国家农业科技园区               | fail   | 海南     |
| 2019 |    70 | 甘肃武威国家农业科技园区               | ok     | 甘肃     |
| 2021 |    53 | 新疆沙湾国家农业科技园区               | ok     | 新疆     |
| 2020 |    21 | 贵州安顺国家农业科技园区               | ok     | 贵州     |
| 2019 |    50 | 广东湛江国家农业科技园区               | ok     | 广东     |
| 2019 |     9 | 新疆哈密国家农业科技园区               | fail   | 新疆     |
| 2020 |     5 | 陕西汉中国家农业科技园区               | fail   | 陕西     |
| 2021 |    36 | 重庆长寿国家农业科技园区               | ok     | 重庆     |
| 2021 |     2 | 广西桂林国家农业科技园区               | cancel | 广西     |
| 2019 |    83 | 新疆生产建设兵团石河子国家农业科技园区 | ok     | 新疆     |

#### Data from MOA or MOE

Several data set sources from Ministry of Agriculture (MOA) or Ministry
of Education (MOE).

##### PubObsStation

**`PubObsStation`**：A **wide format** data set containing Details of
Evaluation result of National Agricultural Sci-tech Details list of
Observe Stations of MOA and MOE.

- Totally 6 columns including: officer, year, index, name, institution,
  province.

- Totally 158 rows.

- Years range from 2018 to 2019

<!---CARS from MOA---->

``` r
data("PubCars")
```

**`PubCars`**：A **wide format** data set containing Details of China
Agricultural Research System(CARS) from MOA.

- Totally 16 columns including: year, index, area_num_eng, area_name,
  chairman_industry, institution_industry, func_num, func_name,
  func_inst, func_director, researcher_area, researcher_name,
  researcher_inst, province_industry, province_func,
  province_researcher.

- Totally 1826 rows.

- Years range from 2011 to 2022

``` r
PubObsStation %>%
  sample_n(size = 10) %>%
  kable()
```

| officer | year | index | name                                                           | institution                    | province |
|:--------|-----:|:------|:---------------------------------------------------------------|:-------------------------------|:---------|
| MOA     | 2018 | 23    | 国家植物保护郾城观测实验站                                     | 漯河市农业科学院               | 河南     |
| MOA     | 2019 | 68    | 国家农业科学农业环境千烟洲观测实验站                           | 中国科学院地理科学与资源研究所 | 北京     |
| MOE     | 2019 | 48    | 江苏贾汪资源枯竭矿区土地修复与生态演替教育部野外科学观测研究站 | 中国矿业大学                   | 江苏     |
| MOA     | 2019 | 13    | 国家农业科学植物保护西宁观测实验站                             | 中国农业科学院油料作物研究所   | 湖北     |
| MOA     | 2019 | 36    | 国家农业科学农业环境六合观测实验站                             | 江苏省农业科学院               | 江苏     |
| MOA     | 2019 | 38    | 国家农业科学农业环境潜江观测实验站                             | 湖北省农业科学院               | 湖北     |
| MOA     | 2019 | 35    | 国家农业科学农业种质资源南京观测实验站                         | 南京农业大学                   | 江苏     |
| MOE     | 2019 | 10    | 雪峰山电力装备安全教育部野外科学观测研究站                     | 重庆大学                       | 重庆     |
| MOA     | 2019 | 42    | 国家农业科学土壤质量广州观测实验站                             | 广东省农业科学院               | 广东     |
| MOA     | 2019 | 70    | 国家农业科学农业环境封丘观测实验站                             | 中国科学院南京土壤研究所       | 江苏     |

##### PubBreedingXmj

**`PubBreedingXmj`**：A **wide format** data set containing details of
Officer’ Livestock Breeding List from MOA (Xmj).

- Totally 7 columns including: year, index, province, type, name_origin,
  name_change, mark.

- Totally 287 rows.

- Years range from 2010 to 2020

``` r
PubBreedingXmj %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | province | type                     | name_origin                              | name_change              | mark     |
|:-----|:------|:---------|:-------------------------|:-----------------------------------------|:-------------------------|:---------|
| 2013 | 5     | 福建     | 国家生猪核心育种场       | 宁德市南阳实业有限公司                   | NA                       | 遴选公示 |
| 2015 | 9     | 广东     | 国家肉鸡良种扩繁推广基地 | 广东天农食品有限公司                     | NA                       | 遴选公示 |
| 2010 | 11    | 广东     | 国家生猪核心育种场       | 广东广三保养猪有限公司                   | NA                       | 遴选公示 |
| 2015 | 5     | 福建     | 国家肉鸡良种扩繁推广基地 | 福建圣农发展股份有限公司                 | NA                       | 遴选公示 |
| 2014 | 2     | 河北     | 国家蛋鸡良种扩繁推广基地 | 河北华裕家禽育种有限公司高岳养殖示范基地 | NA                       | 遴选公示 |
| 2018 | 3     | 河南     | 国家肉羊核心育种场       | 河南中鹤牧业有限公司                     | NA                       | 遴选公示 |
| 2020 | 9     | 湖北     | NA                       | 湖北天种畜牧股份有限公司                 | 武汉天种畜牧有限责任公司 | 名称变更 |
| 2015 | 1     | 江苏     | 国家肉鸡核心育种场       | 江苏省家禽科学研究所家禽育种中心         | NA                       | 遴选公示 |
| 2015 | 7     | 湖南     | 国家肉鸡良种扩繁推广基地 | 湖南湘佳牧业股份有限公司                 | NA                       | 遴选公示 |
| 2014 | 3     | 河北     | 国家蛋鸡核心育种场       | 河北大午农牧集团种禽有限公司             | NA                       | 遴选公示 |

##### PubStandardXmj

**`PubStandardXmj`**：A **wide format** data set containing details of
Officer’ Livestock Breeding List from MOA (Xmj).

- Totally 5 columns including: year, index, province, prod_name,
  com_name.

- Totally 3377 rows.

- Years range from 2010 to 2020

``` r
PubStandardXmj %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | province | prod_name | com_name                                 |
|:-----|:------|:---------|:----------|:-----------------------------------------|
| 2016 | 180   | 浙江     | 水禽      | 兰溪市禾丰养殖场                         |
| 2013 | 7     | 天津     | 生猪      | 天津市鑫瑞畜牧养殖场                     |
| 2016 | 335   | 河南     | 肉牛      | 柘城县汇洋畜牧养殖有限公司               |
| 2014 | 130   | 福建     | 生猪      | 福建省祥云牧业有限公司                   |
| 2013 | 299   | 甘肃     | 肉牛      | 渭源县红火畜禽养殖专业合作社             |
| 2016 | 307   | 河南     | 生猪      | 正阳县光明猪业有限公司                   |
| 2017 | 461   | 海南     | 生猪      | 海南振风农业科技发展有限公司             |
| 2013 | 228   | 广东     | 生猪      | 怀集县中洲镇银盏种猪繁育场               |
| 2017 | 481   | 四川     | 肉牛      | 泸州东牛牧场科技有限公司                 |
| 2017 | 89    | 内蒙古   | 肉牛      | 乌拉盖管理区贺格斯绿色产业进出口有限公司 |
