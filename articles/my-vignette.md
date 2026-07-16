# 02-Techme数据集

``` r

library(techme)
```

This is whole all variables list of this data base:

``` r

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

## Basic

### varsList

**`varsList`**：A data set containing all variables and additional
information, such as unit, chn_name, eng_name etc., with wide data
format.

- Totally 16 columns including: variables, chn_full_name, short_chn,
  short_eng, units, block1, block2, block3, block4, chn_block1,
  chn_block2, chn_block3, chn_block4, chn_full, flag, source.

- Totally 657 rows.

``` r

varsList %>%
  sample_n(size = 10) %>%
  kable()
```

| variables | chn_full_name | short_chn | short_eng | units | block1 | block2 | block3 | block4 | chn_block1 | chn_block2 | chn_block3 | chn_block4 | chn_full | flag | source |
|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|
| v3_stys_sl_sk | 农业生态_水库数 | NA | NA | 座 | v3 | stys | sl | sk | 生态 | 生态用水 | 数量 | 水库数 | 生态;生态用水;数量;水库数 | v2018.6 | NA |
| v4_jyqk_ck_jhz | 经营情况_出口交货值 | NA | NA | 亿元 | v4 | jyqk | ck | jhz | 科技 | 经营情况 | 出口 | 出口交货值 | 科技;经营情况;出口;出口交货值 | v2018.6 | NA |
| v5_xmtz_jf_industry_yhdk | 产业化经营项目_银行贷款 | NA | NA | 万元 | v5 | xmtz | jf | industry_yhdk | 农业综合开发 | 项目投资 | 经费 | 产业化经营项目_银行贷款 | 农业综合开发;项目投资_经费;产业化经营项目_银行贷款 | v2018.6 | NA |
| v1_sc_zcl_dm | 总产量_大麦 | NA | NA | 万吨 | v1 | sc | zcl | dm | 农业 | 生产 | 总产量 | 大麦 | 农业;生产;总产量;大麦 | v2018.6 | NA |
| v6_cz_yszc_nls | NA | 农林水支出 | agriculture | 亿元 | v6 | cz | yszc | nls | 国家统计年鉴 | 财政 | 预算支出 | 农林水 | NA | v2019.8 | 中国统计年鉴 |
| v8_t5_nmcl_zyc | NA | NA | NA | 只 | v8 | t5 | nmcl | zyc | 种畜禽场站 | 表5 | 年末存栏 | 种鸭场 | NA | v2021.8 | 中国畜牧兽医年鉴 |
| v5_zjtr_jf_yhdk | 银行贷款 | NA | NA | 万元 | v5 | zjtr | jf | yhdk | 农业综合开发 | 资金投入 | 经费 | 银行贷款 | 农业综合开发;资金投入_经费;银行贷款 | v2018.6 | NA |
| v4_zh_jsry_hj | NA | 合计 | total | 人 | v4 | zh | jsry | hj | 科技 | 综合 | 专业技术人员 | 合计 | NA | v2019.8 | NA |
| v4_zh_nbzc_zfzj | NA | NA | NA | 万元 | v4 | zh | nbzc | zfzj | 科技 | 综合 | 内部支出 | 政府资金 | NA | v2019.8 | NA |
| v8_t1_zcqc_zmc | NA | NA | NA | 个 | v8 | t1 | zcqc | zmc | 种畜禽场站 | 表1 | 种畜禽厂 | 种马场 | NA | v2021.8 | 中国畜牧兽医年鉴 |

### BasicProvince

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
|  30 | 宁夏     | 旱区       |
|  23 | 四川     | 非旱区     |
|  14 | 江西     | 非旱区     |
|  12 | 安徽     | 非旱区     |
|   1 | 北京     | 旱区       |
|  22 | 重庆     | 非旱区     |
|  10 | 江苏     | 非旱区     |
|  25 | 云南     | 非旱区     |
|   4 | 山西     | 旱区       |
|  20 | 广西     | 非旱区     |

### ProvinceCity

**`ProvinceCity`**：A data set containing Province and City of china.

- Totally 6 columns including: index, province, city, id,
  province_clean, city_clean.

- Totally 342 rows.

``` r

ProvinceCity %>%
  sample_n(size = 10) %>%
  kable()
```

| index | province       | city     | id           | province_clean | city_clean |
|------:|:---------------|:---------|:-------------|:---------------|:-----------|
|   300 | 陕西省         | 商洛市   | 611000000000 | 陕西           | 商洛       |
|    34 | 内蒙古自治区   | 兴安盟   | 152200000000 | 内蒙古         | 兴安       |
|    70 | 黑龙江省       | 黑河市   | 231100000000 | 黑龙江         | 黑河       |
|   260 | 贵州省         | 六盘水市 | 520200000000 | 贵州           | 六盘水     |
|   240 | 四川省         | 攀枝花市 | 510400000000 | 四川           | 攀枝花     |
|   162 | 河南省         | 南阳市   | 411300000000 | 河南           | 南阳       |
|   163 | 河南省         | 商丘市   | 411400000000 | 河南           | 商丘       |
|   217 | 广西壮族自治区 | 南宁市   | 450100000000 | 广西           | 南宁       |
|   214 | 广东省         | 潮州市   | 445100000000 | 广东           | 潮州       |
|    43 | 辽宁省         | 锦州市   | 210700000000 | 辽宁           | 锦州       |

### queryTianyan

**`queryTianyan`**：A data set containing basic info of institution
enrolled in officer administrator.

- Totally 9 columns including: index, name_origin, name_search, address,
  tel, url, province, city, province_raw.

- Totally 588 rows.

``` r

queryTianyan %>%
  sample_n(size = 10) %>%
  kable()
```

| index | name_origin | name_search | address | tel | url | province | city | province_raw |
|---:|:---|:---|:---|:---|:---|:---|:---|:---|
| 36 | 中国建筑设计研究院有限公司 | 中国建筑设计研究院有限公司 | 北京市西城区车公庄大街19号 | 010-88328625 | <https://www.tianyancha.com/company/3200742605> | 北京 | NA | 北京市 |
| 17 | 国家海洋技术中心 | 国家海洋技术中心 | 天津市南开区芥园西道219号 | 暂无信息 | <https://www.tianyancha.com/company/3153218736> | 天津 | NA | 天津 |
| 212 | 中国农业科学院麻类研究所 | 中国农业科学院麻类研究所 | 湖南省长沙市岳麓区咸嘉湖西路348号 | 暂无信息 | <https://www.tianyancha.com/company/2330710592> | 湖南 | 长沙市 | 湖南 |
| 97 | 中国地震局地震研究所 | 中国地震局地震研究所 | 湖北省武汉市武昌区洪山侧路40号 | 暂无信息 | <https://www.tianyancha.com/company/1149780828> | 湖北 | 武汉市 | 湖北 |
| 213 | 中国农业科学院蜜蜂研究所 | 中国农业科学院蜜蜂研究所 | 北京市海淀区香山北沟1号 | 暂无信息 | <https://www.tianyancha.com/company/7057364> | 北京 | NA | 北京 |
| 12 | 北大荒信息有限公司 | 北大荒信息有限公司 | 哈尔滨市松北区智谷大街288号深圳（哈尔滨）产业园区科创总部1号楼 | 暂无信息 | <https://www.tianyancha.com/company/4175511939> | 黑龙江 | NA | NA |
| 64 | 南京理工大学 | 南京理工大学 | 江苏省南京市玄武区孝陵卫街道孝陵卫街200号 | 暂无信息 | <https://www.tianyancha.com/company/683783896> | 江苏 | 南京市 | 江苏 |
| 21 | 清华大学 | 清华大学 | 北京市海淀区清华园 | 暂无信息 | <https://www.tianyancha.com/company/516739> | 北京 | NA | 北京市 |
| 127 | 中国疾病预防控制中心营养与健康所 | 中国疾病预防控制中心营养与健康所 | 北京市西城区南纬路29号 | 暂无信息 | <https://www.tianyancha.com/company/3097983476> | 北京 | NA | 北京 |
| 131 | 中国科学院半导体研究所 | 中国科学院半导体研究所 | 北京海淀区清华东路甲35号 | 暂无信息 | <https://www.tianyancha.com/company/6421402> | 北京 | NA | 北京 |

## Yearbook

### Source from Rural Yearbook

#### AgriMachine

**`AgriMachine`**：A **long format** data set containing Agricultural
Machine statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 5792 rows.

- Years range from 2010 to 2023

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

| province | year | chn_block4           |    value | units  | variables             |
|:---------|:-----|:---------------------|---------:|:-------|:----------------------|
| 山东     | 2018 | 农用排灌柴油机       |       NA | 万台   | v7_sctj_nyjx_pgcyj    |
| 安徽     | 2018 | 节水灌溉类机械       |  21.2000 | 万套   | v7_sctj_nyjx_jsgg     |
| 广西     | 2011 | 农用排灌柴油机       |  50.4347 | 万台   | v7_sctj_nyjx_pgcyj    |
| 宁夏     | 2013 | 农用水泵             |   4.1200 | 万台   | v7_sctj_nyjx_nysb     |
| 安徽     | 2011 | 大中型拖拉机配套农具 |  27.6958 | 万部   | v7_sctj_nyjx_dztlj_pt |
| 贵州     | 2019 | 农用水泵             |  61.8000 | 万台   | v7_sctj_nyjx_nysb     |
| 江苏     | 2012 | 机耕面积             |       NA | 千公顷 | v7_sctj_nyjx_jgmj     |
| 内蒙古   | 2010 | 农用水泵             |  35.9600 | 万台   | v7_sctj_nyjx_nysb     |
| 海南     | 2013 | 小型拖拉机           |   5.2700 | 万台   | v7_sctj_nyjx_xtlj     |
| 安徽     | 2012 | 农用排灌电动机       | 114.2300 | 万台   | v7_sctj_nyjx_pgddj    |

#### AgriFertilizer

**`AgriFertilizer`**：A **long format** data set containing Agricultural
Fertilizer statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1088 rows.

- Years range from 2010 to 2023

- Variables including: v7_sctj_nyhf_df, v7_sctj_nyhf_fhf,
  v7_sctj_nyhf_hj, v7_sctj_nyhf_jf, v7_sctj_nyhf_lf

``` r

AgriFertilizer %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 | value | units | variables        |
|:---------|:-----|:-----------|------:|:------|:-----------------|
| 新疆     | 2019 | 磷肥       |  64.5 | 万吨  | v7_sctj_nyhf_lf  |
| 浙江     | 2016 | 化肥使用量 |  84.5 | 万吨  | v7_sctj_nyhf_hj  |
| 陕西     | 2020 | 钾肥       |  23.0 | 万吨  | v7_sctj_nyhf_jf  |
| 云南     | 2013 | 化肥使用量 | 219.0 | 万吨  | v7_sctj_nyhf_hj  |
| 北京     | 2023 | 复合肥     |   4.2 | 万吨  | v7_sctj_nyhf_fhf |
| 上海     | 2016 | 化肥使用量 |   9.2 | 万吨  | v7_sctj_nyhf_hj  |
| 天津     | 2019 | 化肥使用量 |  16.2 | 万吨  | v7_sctj_nyhf_hj  |
| 河北     | 2021 | 复合肥     | 138.8 | 万吨  | v7_sctj_nyhf_fhf |
| 上海     | 2019 | 钾肥       |   0.3 | 万吨  | v7_sctj_nyhf_jf  |
| 全国     | 2020 | 钾肥       | 541.9 | 万吨  | v7_sctj_nyhf_jf  |

#### AgriPlastic

**`AgriPlastic`**：A **long format** data set containing Agricultural
Plastic statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1344 rows.

- Years range from 2010 to 2023

- Variables including: v7_sctj_nybm_bmsy, v7_sctj_nybm_dmfg,
  v7_sctj_nybm_dmsy

``` r

AgriPlastic %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4     |    value | units | variables         |
|:---------|:-----|:---------------|---------:|:------|:------------------|
| 贵州     | 2016 | NA             |  30758.0 | NA    | v7_sctj_nybm_dmsy |
| 广西     | 2014 | NA             | 416345.0 | NA    | v7_sctj_nybm_dmfg |
| 上海     | 2013 | NA             |  21961.0 | NA    | v7_sctj_nybm_dmfg |
| 安徽     | 2011 | NA             |  39231.0 | NA    | v7_sctj_nybm_dmsy |
| 陕西     | 2022 | 地膜使用量     |      2.1 | 万吨  | v7_sctj_nybm_dmsy |
| 湖北     | 2013 | NA             |  38162.0 | NA    | v7_sctj_nybm_dmsy |
| 上海     | 2023 | 地膜使用量     |      0.3 | 万吨  | v7_sctj_nybm_dmsy |
| 内蒙古   | 2022 | 农用薄膜使用量 |     11.5 | 万吨  | v7_sctj_nybm_bmsy |
| 四川     | 2015 | 农用薄膜使用量 | 132170.0 | 吨    | v7_sctj_nybm_bmsy |
| 西藏     | 2015 | NA             |   3522.0 | NA    | v7_sctj_nybm_dmfg |

#### AgriPesticide

**`AgriPesticide`**：A **long format** data set containing Agricultural
Pesticide statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 608 rows.

- Years range from 2010 to 2023

- Variables including: v7_sctj_cyny_cysy, v7_sctj_cyny_nysy

``` r

AgriPesticide %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4     |    value | units | variables         |
|:---------|:-----|:---------------|---------:|:------|:------------------|
| 山东     | 2013 | 农药使用量     | 158384.0 | 吨    | v7_sctj_cyny_nysy |
| 福建     | 2019 | 农用柴油使用量 |     81.2 | 万吨  | v7_sctj_cyny_cysy |
| 贵州     | 2013 | 农药使用量     |  13480.0 | 吨    | v7_sctj_cyny_nysy |
| 宁夏     | 2017 | 农药使用量     |   2540.0 | 吨    | v7_sctj_cyny_nysy |
| 安徽     | 2023 | 农用柴油使用量 |     73.7 | 万吨  | v7_sctj_cyny_cysy |
| 安徽     | 2015 | 农药使用量     | 111048.0 | 吨    | v7_sctj_cyny_nysy |
| 湖南     | 2010 | 农药使用量     | 118762.0 | 吨    | v7_sctj_cyny_nysy |
| 新疆     | 2019 | 农用柴油使用量 |     94.2 | 万吨  | v7_sctj_cyny_cysy |
| 山西     | 2020 | 农用柴油使用量 |     26.0 | 万吨  | v7_sctj_cyny_cysy |
| 黑龙江   | 2012 | 农药使用量     |  80511.0 | 吨    | v7_sctj_cyny_nysy |

### Source from Sci-Tech Yearbook

#### RDIntense

来自于中国政府网历年“全国科技经费投入统计公报”：

- 2021年全国科技经费投入统计[公报](https://www.gov.cn/xinwen/2022-08/31/content_5707547.htm)

- 2020年全国科技经费投入统计[公报](https://www.gov.cn/xinwen/2021-09/22/content_5638653.htm)

> 说明：《中国科技统计年鉴》也有数据发布，但是把经费和强度指标分别存放了，不符合本数据包的更新流程。

**`RDIntense`**：A **long format** data set containing R&D Intense
statistics.

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 832 rows.

- Years range from 2011 to 2023

- Variables including: v4_ztr_jf_RD, v4_ztr_qd_RD

``` r

RDIntense %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |  value | units | variables    |
|:---------|:-----|:-----------|-------:|:------|:-------------|
| 甘肃     | 2011 | RD强度     |   0.97 | %     | v4_ztr_qd_RD |
| 辽宁     | 2019 | RD经费     | 508.50 | 亿元  | v4_ztr_jf_RD |
| 山西     | 2013 | RD经费     | 155.00 | 亿元  | v4_ztr_jf_RD |
| 陕西     | 2016 | RD经费     | 419.60 | 亿元  | v4_ztr_jf_RD |
| 北京     | 2015 | RD强度     |   6.01 | %     | v4_ztr_qd_RD |
| 海南     | 2016 | RD经费     |  21.70 | 亿元  | v4_ztr_jf_RD |
| 湖南     | 2019 | RD强度     |   1.98 | %     | v4_ztr_qd_RD |
| 河北     | 2018 | RD强度     |   1.39 | %     | v4_ztr_qd_RD |
| 广西     | 2013 | RD强度     |   0.75 | %     | v4_ztr_qd_RD |
| 安徽     | 2020 | RD强度     |   2.28 | %     | v4_ztr_qd_RD |

#### RDActivity

**`RDActivity`**：A **long format** data set containing R&D Activity
statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1792 rows.

- Years range from 2010 to 2023

- Variables including: v4_zh_nbzc_hj, v4_zh_nbzc_jcyj, v4_zh_nbzc_syfz,
  v4_zh_nbzc_yyyj

``` r

RDActivity %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |        value | units | variables       |
|:---------|:-----|:-----------|-------------:|:------|:----------------|
| 辽宁     | 2019 | 合计       |    5084604.0 | 万元  | v4_zh_nbzc_hj   |
| 福建     | 2014 | 基础研究   |      75426.9 | 万元  | v4_zh_nbzc_jcyj |
| 湖南     | 2015 | 基础研究   |     136021.5 | 万元  | v4_zh_nbzc_jcyj |
| 广西     | 2022 | 基础研究   |     171275.0 | 万元  | v4_zh_nbzc_jcyj |
| 内蒙古   | 2020 | 应用研究   |     171318.0 | 万元  | v4_zh_nbzc_yyyj |
| 黑龙江   | 2014 | 基础研究   |     124047.1 | 万元  | v4_zh_nbzc_jcyj |
| 全国     | 2023 | 试验发展   | 274364624\.0 | 万元  | v4_zh_nbzc_syfz |
| 黑龙江   | 2020 | 基础研究   |     230334.0 | 万元  | v4_zh_nbzc_jcyj |
| 河北     | 2017 | 基础研究   |     105087.1 | 万元  | v4_zh_nbzc_jcyj |
| 广西     | 2023 | 基础研究   |     156901.0 | 万元  | v4_zh_nbzc_jcyj |

#### IndustryOperation

**`IndustryOperation`**：A **long format** data set containing Industry
Operation statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1248 rows.

- Years range from 2010 to 2023

- Variables including: v4_cy_scjy_lrze, v4_cy_scjy_qys, v4_cy_scjy_zyyw

``` r

IndustryOperation %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4   |      value | units | variables       |
|:---------|:-----|:-------------|-----------:|:------|:----------------|
| 青海     | 2016 | 利润总额     |    8.77192 | 亿元  | v4_cy_scjy_lrze |
| 浙江     | 2010 | 利润总额     |  296.30000 | 亿元  | v4_cy_scjy_lrze |
| 新疆     | 2020 | 利润总额     |   21.00000 | 亿元  | v4_cy_scjy_lrze |
| 河南     | 2022 | 主营业务收入 | 9282.00000 | 亿元  | v4_cy_scjy_zyyw |
| 浙江     | 2015 | 主营业务收入 | 5288.06619 | 亿元  | v4_cy_scjy_zyyw |
| 安徽     | 2021 | 利润总额     |  430.00000 | 亿元  | v4_cy_scjy_lrze |
| 山东     | 2019 | 主营业务收入 | 5911.00000 | 亿元  | v4_cy_scjy_zyyw |
| 广西     | 2010 | 利润总额     |   55.90000 | 亿元  | v4_cy_scjy_lrze |
| 河南     | 2015 | 利润总额     |  408.30398 | 亿元  | v4_cy_scjy_lrze |
| 内蒙古   | 2021 | 企业数       |  111.00000 | 个    | v4_cy_scjy_qys  |

#### IndustryRD

**`IndustryRD`**：A **long format** data set containing Industry R&D
statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 3968 rows.

- Years range from 2016 to 2023

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

| province | year | chn_block4       |        value | units | variables       |
|:---------|:-----|:-----------------|-------------:|:------|:----------------|
| 西藏     | 2016 | 投资额           | 3.739200e+00 | 亿元  | v4_cy_cytz_tzze |
| 浙江     | 2017 | 开发项目数       | 1.174200e+04 | 项    | v4_cy_xcp_kfxm  |
| 江苏     | 2023 | 专利申请数       | 6.691400e+04 | 件    | v4_cy_qyzl_sqs  |
| 贵州     | 2023 | 有效专利数       | 1.522000e+03 | 件    | v4_cy_qyzl_yxs  |
| 内蒙古   | 2023 | 出口             | 2.138620e+05 | 万元  | v4_cy_xcp_ck    |
| 内蒙古   | 2023 | 开发经费支出     | 2.365670e+05 | 万元  | v4_cy_xcp_kfjf  |
| 宁夏     | 2018 | 技术引进经费支出 |           NA | 万元  | v4_cy_jsgz_yjzc |
| 河南     | 2019 | 销售收入         | 2.405640e+07 | 万元  | v4_cy_xcp_xssr  |
| 北京     | 2018 | 专利申请数       | 7.796000e+03 | 件    | v4_cy_qyzl_sqs  |
| 广东     | 2017 | 开发经费支出     | 1.536649e+07 | 万元  | v4_cy_xcp_kfjf  |

#### MarketPull

**`MarketPull`**：A **long format** data set containing Tech Market Pull
statistics .

> **说明**：数据包括合同数（`amount-xxxx.xlsx`）和金额（`funds-xxxx.xlsx`）两个表格来源，需要独立更新全部xlsx后，再读取整合为一个数据表。

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 960 rows.

- Years range from 2000 to 2023

- Variables including: v4_cg_jssr_ht, v4_cg_jssr_je

``` r

MarketPull %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |    value | units | variables     |
|:---------|:-----|:-----------|---------:|:------|:--------------|
| 江西     | 2022 | 数量       |    12612 | 项    | v4_cg_jssr_ht |
| 内蒙古   | 2000 | 金额       |    79600 | 万元  | v4_cg_jssr_je |
| 湖北     | 2013 | 数量       |     9758 | 项    | v4_cg_jssr_ht |
| 山东     | 2000 | 数量       |    30909 | 项    | v4_cg_jssr_ht |
| 广西     | 2020 | 数量       |     6337 | 项    | v4_cg_jssr_ht |
| 四川     | 2013 | 数量       |    11729 | 项    | v4_cg_jssr_ht |
| 甘肃     | 2023 | 金额       | 10217970 | 万元  | v4_cg_jssr_je |
| 河南     | 2012 | 数量       |     5680 | 项    | v4_cg_jssr_ht |
| 河北     | 2023 | 数量       |    24272 | 项    | v4_cg_jssr_ht |
| 内蒙古   | 2019 | 数量       |     5851 | 项    | v4_cg_jssr_ht |

#### MarketPush

**`MarketPush`**：A **long format** data set containing Tech Market Push
statistics .

> **说明**：数据包括合同数（`amount-xxxx.xlsx`）和金额（`funds-xxxx.xlsx`）两个表格来源，需要独立更新全部xlsx后，再读取整合为一个数据表。

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 960 rows.

- Years range from 2000 to 2023

- Variables including: v4_cg_jssc_ht, v4_cg_jssc_je

``` r

MarketPush %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |      value | units | variables     |
|:---------|:-----|:-----------|-----------:|:------|:--------------|
| 福建     | 2019 | 金额       |  1395883.0 | 万元  | v4_cg_jssc_je |
| 北京     | 2012 | 数量       |    59969.0 | 项    | v4_cg_jssc_ht |
| 广东     | 2000 | 金额       |   482104.0 | 万元  | v4_cg_jssc_je |
| 内蒙古   | 2000 | 金额       |    60287.0 | 万元  | v4_cg_jssc_je |
| 山西     | 2021 | 数量       |     1424.0 | 项    | v4_cg_jssc_ht |
| 湖北     | 2012 | 金额       |  1963922.5 | 万元  | v4_cg_jssc_je |
| 甘肃     | 2018 | 数量       |     5072.0 | 项    | v4_cg_jssc_ht |
| 宁夏     | 2012 | 数量       |      564.0 | 项    | v4_cg_jssc_ht |
| 四川     | 2022 | 金额       | 16435301.0 | 万元  | v4_cg_jssc_je |
| 青海     | 2014 | 金额       |   291001.1 | 万元  | v4_cg_jssc_je |

#### IndustryTrade

**`IndustryTrade`**：A **long format** data set containing Industry
Trade statistics .

> 说明：2018年以后年鉴不再发布该数据！

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
| 贵州     | 2017 | 进口贸易额 |   1330.2896 | 百万美元 | v4_cy_my_jk  |
| 河南     | 2017 | 贸易总额   |  51509.5219 | 百万美元 | v4_cy_my_jck |
| 宁夏     | 2018 | 出口贸易额 |    146.0000 | 百万美元 | v4_cy_my_ck  |
| 广东     | 2017 | 进口贸易额 | 203757.5249 | 百万美元 | v4_cy_my_jk  |
| 四川     | 2018 | 出口贸易额 |  33488.0000 | 百万美元 | v4_cy_my_ck  |
| 新疆     | 2016 | 贸易总额   |    385.2117 | 百万美元 | v4_cy_my_jck |
| 贵州     | 2018 | 贸易总额   |   3439.0000 | 百万美元 | v4_cy_my_jck |
| 上海     | 2018 | 出口贸易额 |  86463.0000 | 百万美元 | v4_cy_my_ck  |
| 湖南     | 2016 | 出口贸易额 |   2619.3848 | 百万美元 | v4_cy_my_ck  |
| 湖南     | 2017 | 进口贸易额 |   2394.6562 | 百万美元 | v4_cy_my_jk  |

### Source from China National Yearbook

#### PublicBudget

**`PublicBudget`**：A **long format** data set containing Public Budget
statistics.

> **说明**：来源于《中国统计年鉴》，表7-6
> 分地区一般公共预算支出。我们只整理更新如下列变量：“地方一般公共预算支出”,“教育支出”,“科学技术支出”,“农林水支出”。

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1756 rows.

- Years range from 2010 to 2023

- Variables including: v6_cz_yszc_hj, v6_cz_yszc_jy, v6_cz_yszc_kxjs,
  v6_cz_yszc_nls

| province | year | chn_block4 |   value | units | variables       |
|:---------|:-----|:-----------|--------:|:------|:----------------|
| 甘肃     | 2019 | 合计       | 3951.60 | 亿元  | v6_cz_yszc_hj   |
| 河南     | 2023 | 教育       | 1993.35 | 亿元  | v6_cz_yszc_jy   |
| 云南     | 2015 | 科学技术   |   48.56 | 亿元  | v6_cz_yszc_kxjs |
| 安徽     | 2018 | 科学技术   |  294.81 | 亿元  | v6_cz_yszc_kxjs |
| 福建     | 2016 | 科学技术   |   80.28 | 亿元  | v6_cz_yszc_kxjs |
| 宁夏     | 2019 | 合计       | 1438.29 | 亿元  | v6_cz_yszc_hj   |
| 广东     | 2016 | 科学技术   |  742.97 | 亿元  | v6_cz_yszc_kxjs |
| 山东     | 2016 | 科学技术   |  167.00 | 亿元  | v6_cz_yszc_kxjs |
| 黑龙江   | 2011 | 合计       | 2794.08 | 亿元  | v6_cz_yszc_hj   |
| 海南     | 2021 | 教育       |  295.10 | 亿元  | v6_cz_yszc_jy   |

### Source from Livestock Yearbook

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

| province | year | chn_block4 | value | units | variables          |
|:---------|:-----|:-----------|------:|:------|:-------------------|
| 陕西     | 2011 | 种牦牛场   |    NA | 个    | v8_t1_zcqc_zhnc    |
| 辽宁     | 2018 | 种羊场     | 12674 | 只    | v8_t6_nfmccl_zyc   |
| 陕西     | 2018 | 种马场     |   182 | 匹    | v8_t6_nfmccl_zmc   |
| 吉林     | 2015 | 种兔场     |    14 | 个    | v8_t2_zcqc_ztc     |
| 山东     | 2015 | 种马场     |     3 | 个    | v8_t1_zcqc_zmc     |
| 吉林     | 2015 | 种公猪站   |    90 | 个    | v8_t3_zcqc_zgzz    |
| 浙江     | 2013 | 种公猪站   |    67 | 个    | v8_t3_zcqc_zgzz    |
| 四川     | 2018 | 种猪场     |   219 | 个    | v8_t1_zcqc_zzc     |
| 北京     | 2013 | 种羊场     |  1300 | 只    | v8_t7_cczcq_zyc    |
| 辽宁     | 2018 | 种绒山羊场 |  4617 | 只    | v8_t7_nfmccl_zmsyc |

## Public site

### Source from Government site

#### some data set

### Source from MOST

Several data set sources from Ministry of Sci-Tech (MOST).

#### PubNKRDP

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

| year | date | NO | index | title | institution | chairman | funds | type | duration | NO_head | NO_year | NO_mark | NO_num | NO_num_p1 | NO_num_p2 | NO_tail |
|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|:---|
| 2018 | 20191015 | 2018YFC1505700 | 832 | 青藏高原地-气相互作用及其对下游天气气候的影响 | 中国气象科学研究院 | 赵平 | 2864 | 重大自然灾害监测预警与防范 | NA |  | 2018 | YFC | 1505700 | 15 | 05700 | NA |
| 2019 | 20191015 | 2019YFA0110800 | 31 | 单基因遗传病的基因治疗研究 | 中国科学院动物研究所 | 李伟 | 2808 | 干细胞及转化研究 | NA |  | 2019 | YFA | 0110800 | 01 | 10800 | NA |
| 2019 | 20191015 | 2019YFA0508500 | 68 | 固有免疫应答新型关键蛋白质机器功能与机制研究 | 中国科学技术大学 | 周荣斌 | 2444 | 蛋白质机器与生命过程调控 | NA |  | 2019 | YFA | 0508500 | 05 | 08500 | NA |
| 2018 | 20191015 | 2018YFC1903300 | 898 | 铜铅锌综合冶炼基地多源固废协同利用集成示范 | 株洲冶炼集团股份有限公司 | 刘朗明 | 2642 | 固废资源化 | NA |  | 2018 | YFC | 1903300 | 19 | 03300 | NA |
| 2020 | 20201127 | 2020YFA0711500 | 410 | 基于电卡制冷效应的时空精准芯片主动控温系统设计与研究 | 上海交通大学 | NA | NA | 变革性技术关键科学问题 | NA |  | 2020 | YFA | 0711500 | 07 | 11500 | NA |
| 2018 | 20191015 | 2018YFA0507900 | 57 | 抑郁相关神经递质膜受体蛋白质机器促进胃癌侵袭转移的分子机制及靶向干预研究 | 中国人民解放军第三军医大学 | 欧阳勤 | 494 | 蛋白质机器与生命过程调控 | NA |  | 2018 | YFA | 0507900 | 05 | 07900 | NA |
| 2018 | 20191015 | 2018YFA0404500 | 43 | 星系结构、演化与宇宙学研究 | 中国科学院国家天文台 | 毛淑德 | 4754 | 大科学装置前沿研究 | NA |  | 2018 | YFA | 0404500 | 04 | 04500 | NA |
| 2018 | 20191015 | 2018YFC1407000 | 528 | 海洋动力灾害观测预警系统集成与应用示范 | 国家海洋环境预报中心 | 于福江 | 1325 | 海洋环境安全保障 | NA |  | 2018 | YFC | 1407000 | 14 | 07000 | NA |
| 2020 | 20201223 | 2020YFB1711500 | 122 | 大数据模型驱动的3D打印定制化医疗器械智能设计/仿真协同云平台研发 | 江苏云仟佰数字科技有限公司 | NA | NA | 网络协同制造和智能工厂 | 3 |  | 2020 | YFB | 1711500 | 17 | 11500 | NA |
| 2020 | 20201223 | 2020YFB2009700 | 178 | 阀口独立控制型大流量液压 阀关键技术研究与示范应用 | 江苏恒立液压股份有限公司 | NA | NA | 制造基础技术与关键部件 | 3 |  | 2020 | YFB | 2009700 | 20 | 09700 | NA |

#### PubAgriParkList

> **说明**：本数据集直接在`techme`包开发环境下进行原始数据（data-raw）的清洗和整理（“techme/data-raw/public-site/agri-park/03-list-raw/”）；然后清洗后的xlsx文件复制到（“techme/data-raw/data-tidy/public-site/agri-park/xlsx/”），最后再经由”techme/data-raw/wfl_useData_agriPark.R”进行批量读取和数据集编译。

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

| index | batch | name                               | province |
|------:|:------|:-----------------------------------|:---------|
|    37 | 05    | 山东泰安国家农业科技园区           | 山东     |
|    11 | 02    | 新疆昌吉国家农业科技园区           | 新疆     |
|     4 | 09    | 内蒙古自治区兴安盟国家农业科技园区 | 内蒙古   |
|    11 | 09    | 安徽黄山国家农业科技园区           | 安徽     |
|     3 | 04    | 山西运城国家农业科技园区           | 山西     |
|    25 | 03    | 新疆伊犁国家农业科技园区           | 新疆     |
|     4 | 02    | 安徽宿州国家农业科技园区           | 安徽     |
|     9 | 06    | 重庆潼南国家农业科技园区           | 重庆     |
|    22 | 06    | 湖北荆门国家农业科技园区           | 湖北     |
|     7 | 03    | 广西北海国家农业科技园区           | 广西     |

#### PubAgriParkEval

> **说明**：本数据集直接在`techme`包开发环境下进行原始数据（data-raw）的清洗和整理（“techme/data-raw/public-site/agri-park/02-eval-raw/”）；然后清洗后的xlsx文件复制到（“techme/data-raw/data-tidy/public-site/agri-park/xlsx/”），最后再经由”techme/data-raw/wfl_useData_agriPark.R”进行批量读取和数据集编译。

**`PubAgriParkEval`**：A **wide format** data set containing Details of
Evaluation result of National Agricultural Sci-tech Park.

- Totally 5 columns including: year, index, name, result, province.

- Totally 254 rows.

- Years range from 2019 to 2022

``` r

PubAgriParkEval %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | name                           | result | province |
|-----:|------:|:-------------------------------|:-------|:---------|
| 2021 |    46 | 陕西铜川国家农业科技园区       | ok     | 陕西     |
| 2020 |     1 | 河北石家庄藁城国家农业科技园区 | good   | 河北     |
| 2020 |     3 | 江苏南通国家农业科技园区       | good   | 江苏     |
| 2019 |     6 | 贵州毕节国家农业科技园区       | fail   | 贵州     |
| 2019 |    40 | 河南南阳国家农业科技园区       | ok     | 河南     |
| 2021 |     3 | 吉林延边国家农业科技园区       | retain | 吉林     |
| 2019 |    43 | 湖北潜江国家农业科技园区       | ok     | 湖北     |
| 2021 |     9 | 辽宁锦州国家农业科技园区       | ok     | 辽宁     |
| 2021 |     1 | 宁夏银川国家农业科技园区       | cancel | 宁夏     |
| 2021 |    13 | 江苏镇江国家农业科技园区       | ok     | 江苏     |

#### PubAgriParkCheck

> **说明**：本数据集直接在`techme`包开发环境下进行原始数据（data-raw）的清洗和整理（“techme/data-raw/public-site/agri-park/01-check-raw/”）；然后清洗后的xlsx文件复制到（“techme/data-raw/data-tidy/public-site/agri-park/xlsx/”），最后再经由”techme/data-raw/wfl_useData_agriPark.R”进行批量读取和数据集编译。

**`PubAgriParkCheck`**：A **wide format** data set containing Details of
Check result of National Agricultural Sci-tech Park.

- Totally 6 columns including: year, index, name, result, province,
  doc_num.

- Totally 232 rows.

- Years range from 2017 to 2023

``` r

PubAgriParkCheck %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | name                         | result | province | doc_num            |
|-----:|------:|:-----------------------------|:-------|:---------|:-------------------|
| 2017 |    34 | 安徽蚌埠国家农业科技园区     | pass   | 安徽     | 国科办函农2017-767 |
| 2017 |    42 | 安徽合肥国家农业科技园区     | pass   | 安徽     | 国科办函农2017-767 |
| 2018 |     5 | 江苏无锡国家农业科技园区     | pass   | 江苏     | 国科办农2018-99    |
| 2019 |    72 | 上海崇明国家农业科技园区     | pass   | 上海     | 国科办农2019-87    |
| 2017 |    19 | 甘肃武威国家农业科技园区     | pass   | 甘肃     | 国科办函农2017-767 |
| 2018 |    39 | 陕西咸阳国家农业科技园区     | pass   | 陕西     | 国科办农2018-99    |
| 2023 |    15 | 湖北咸宁国家农业科技园区     | pass   | 湖北     | 国科办农2023-60    |
| 2021 |    31 | 新疆博尔塔拉国家农业科技园区 | pass   | 新疆     | 国科办农2021-150号 |
| 2019 |     5 | 河北辛集国家农业科技园区     | pass   | 河北     | 国科办农2019-87    |
| 2019 |     8 | 广西贺州国家农业科技园区     | pass   | 广西     | 国科办农2019-87    |

#### HitechFirmsPub

**数据来源**：科学技术部火炬高技术产业开发中心<http://www.innocom.gov.cn>。

**说明**：本数据集直接在`tech-report`项目下进行原始数据（data-raw）的清洗和整理（“tech-report/data-raw/public-site/torch-innocom/xlsx/”）；然后清洗后的xlsx文件复制到（“tech-report/data-raw/data-tidy/public-site/torch-innocom/xlsx/”）。最后再一次复制到`techme`包开发环境下的”techme/data-raw/data-tidy/public-site/torch-innocom/xlsx/“，再经由”techme/data-raw/wfl_useData_HitechFirms.R”进行批量读取和数据集编译。

**`HitechFirmsPub`**：A **wide format** data set containing Details of
Hi-tech Firms Numbers on Public Site.

- Totally 4 columns including: index, year, province, num.

- Totally 217 rows.

- Years range from 2018 to 2024

``` r

HitechFirmsPub %>%
  sample_n(size = 10) %>%
  kable()
```

| index | year | province |   num |
|------:|-----:|:---------|------:|
|    10 | 2020 | 江苏     | 13114 |
|    20 | 2023 | 广西     |  1281 |
|    20 | 2021 | 广西     |  1484 |
|    13 | 2019 | 福建     |  1951 |
|    14 | 2018 | 江西     |  1868 |
|    18 | 2020 | 湖南     |  4071 |
|     5 | 2022 | 内蒙古   |   681 |
|    18 | 2024 | 湖南     |  6083 |
|    19 | 2020 | 广东     | 20279 |
|    30 | 2022 | 宁夏     |   216 |

#### PubOpenShare

**数据来源**：科学技术部火炬高技术产业开发中心<http://www.innocom.gov.cn>。

**说明**：本数据集直接在`techme`项目下进行原始数据（data-raw）的清洗和整理（“techme/data-raw/public-site/most-jcs-open-share/xlsx/”），再经由”techme/data-raw/public-site/most-jcs-open-share/wfl-PubOpenShare.R”进行批量读取和数据集编译。

**`PubOpenShare`**：A **wide format** data set containing Details of
Evaluation result of Major Scientific Infrastructure and Large-scale
Scientific Instruments Sharing.

- Totally 6 columns including: year, index, institution, result,
  administrator, province.

- Totally 2453 rows.

- Years range from 2018 to 2024

``` r

PubOpenShare %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | institution | result | administrator | province |
|---:|---:|:---|:---|:---|:---|
| 2018 | 92 | 中国林业科学研究院资源信息研究所 | 良好 | 国家林业和草原局 | 北京 |
| 2019 | 291 | 中国中医科学院中药研究所 | 合格 | 国家中医药管理局 | 北京 |
| 2019 | 146 | 中国科学院遥感与数字地球研究所 | 合格 | 中国科学院 | 北京 |
| 2018 | 277 | 国家海洋局东海分局 | 合格 | 自然资源部 | 上海 |
| 2022 | 151 | 中国科学院深圳先进技术研究院 | 合格 | NA | 广东 |
| 2019 | 82 | 中国科学院植物研究所 | 良好 | 中国科学院 | 北京 |
| 2024 | 239 | 中国农业科学院草原研究所 | 合格 |  | 内蒙古 |
| 2018 | 324 | 中国医学科学院肿瘤医院 | 合格 | 国家卫生健康委员会 | 北京 |
| 2019 | 85 | 中国农业科学院农业质量标准与检测技术研究所 | 良好 | 农业农村部 | 北京 |
| 2021 | 15 | 清华大学 | 优秀 | NA | 北京 |

### Source from MOA or MOE

Several data set sources from Ministry of Agriculture (MOA) or Ministry
of Education (MOE).

#### PubObsStation

**`PubObsStation`**：A **wide format** data set containing Details of
Evaluation result of National Agricultural Sci-tech Details list of
Observe Stations of MOA and MOE.

- Totally 7 columns including: officer, year, index, name, institution,
  administrator, province.

- Totally 324 rows.

- Years range from 2018 to 2021

``` r

data("PubCars")
```

**`PubCars`**：A **wide format** data set containing Details of China
Agricultural Research System(CARS) from MOA.

- Totally 14 columns including: year, index, area_num_eng, area_name,
  chairman_industry, institution_industry, func_num, func_name,
  func_inst, func_director, researcher_area, researcher_name,
  researcher_inst, province.

- Totally 1783 rows.

- Years range from 2011 to 2024

``` r

PubObsStation %>%
  sample_n(size = 10) %>%
  kable()
```

| officer | year | index | name | institution | administrator | province |
|:---|:---|:---|:---|:---|:---|:---|
| MOA | 2019 | 19 | 国家农业科学渔业资源环境秦皇岛观测实验站 | 中国水产科学研究院北戴河中心实验站 | NA | 河北 |
| MOST | 2019 | 18 | 青海瓦里关大气成分本底国家野外科学观测研究站 | 中国气象科学研究院、青海省气象局 | 气象局 | 北京 |
| MOA | 2018 | 19 | 国家土壤质量雁山观测实验站 | 桂林市农业科学院 | NA | 广西 |
| MOA | 2019 | 69 | 国家农业科学农业环境拉萨观测实验站 | 中国科学院地理科学与资源研究所 | NA | 北京 |
| MOST | 2019 | 85 | 西藏林芝高山森林生态系统国家野外科学观测研究站 | 西藏农牧学院 | 西藏自治区科技厅、林草局 | 西藏 |
| MOA | 2019 | 30 | 国家农业科学土壤质量武川观测实验站 | 内蒙古农牧业科学院 | NA | 内蒙古 |
| MOST | 2019 | 76 | 海南三亚海水环境材料腐蚀国家野外科学观测研究站 | 中国船舶重工集团公司第七二五研究所 | 国资委 | 河南 |
| MOST | 2021 | 63 | 西藏那曲高寒草地生态系统国家野外科学观测研究站 | 中国科学院地理科学与资源研究所、中国科学院青藏高原研究所、西藏大学 | 西藏自治区科学技术厅 | 北京 |
| MOA | 2018 | 1 | 国家土壤质量德州观测实验站 | 中国农业科学院农业资源与农业区划研究所 | NA | 北京 |
| MOST | 2021 | 48 | 辽宁盘锦湿地生态系统国家野外科学观测研究站 | 沈阳农业大学 | 辽宁省科学技术厅 | 辽宁 |

#### PubBreedingXmj

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

| year | index | province | type | name_origin | name_change | mark |
|:---|:---|:---|:---|:---|:---|:---|
| 2019 | 1 | 河南 | 国家肉牛核心育种场 | 泌阳县夏南牛科技开发有限公司 | NA | 遴选公示 |
| 2015 | 12 | 湖北 | 国家生猪核心育种场 | 湖北金旭爵士种畜有限公司 | NA | 遴选公示 |
| 2018 | 2 | 广东 | 国家肉鸡核心育种场 | 台山市科朗现代农业有限公司 | NA | 遴选公示 |
| 2015 | 11 | 陕西 | 国家肉牛核心育种场 | 陕西省秦川肉牛良种繁育中心 | NA | 遴选公示 |
| 2017 | 4 | 湖南 | 国家肉牛核心育种场 | 湖南天华实业有限公司 | NA | 遴选公示 |
| 2010 | 7 | 海南 | 国家生猪核心育种场 | 海南罗牛山种猪育种有限公司 | NA | 遴选公示 |
| 2012 | 15 | 广西 | 国家生猪核心育种场 | 桂林美冠原种猪育种有限责任公司 | NA | 遴选公示 |
| 2015 | 8 | 江西 | 国家生猪核心育种场 | 井冈山市傲新华富育种有限公司 | NA | 遴选公示 |
| 2010 | 4 | 江西 | 国家生猪核心育种场 | 江西省原种猪场有限公司 | NA | 遴选公示 |
| 2015 | 13 | 广西 | 国家肉鸡良种扩繁推广基地 | 隆安凤鸣农牧有限公司 | NA | 遴选公示 |

#### PubStandardXmj

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

| year | index | province | prod_name | com_name |
|:---|:---|:---|:---|:---|
| 2015 | 54 | 辽宁 | 生猪 | 盘山县庆隆三元猪业有限公司 |
| 2011 | 383 | 四川 | 生猪 | 遂宁安居区金龟村曾白林生猪养殖专业合作社顺木养殖场 |
| 2017 | 180 | 江苏 | 生猪 | 南通赛天蓬牧业有限公司 |
| 2016 | 439 | 广西 | 肉羊 | 大新县福隆乡楚烽养殖场 |
| 2010 | 83 | 吉林 | 蛋鸡 | 九台市龙嘉镇秀文养殖场 |
| 2014 | 184 | 河南 | 蛋鸡 | 河南三高农牧股份有限公司第五养鸡场 |
| 2010 | 142 | 浙江 | 肉鸡 | 杭州萧山志伟家禽有限公司 |
| 2017 | 443 | 广东 | 肉牛 | 高州市春色养殖专业合作社 |
| 2017 | 243 | 江西 | 生猪 | 江西省正邦养殖有限公司龙南分公司桃江良种猪场 |
| 2013 | 268 | 四川 | 肉牛 | 广安市广安区三合肉牛养殖专业合作社 |
