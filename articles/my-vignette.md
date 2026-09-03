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

- Totally 596 rows.

``` r

queryTianyan %>%
  sample_n(size = 10) %>%
  kable()
```

| index | name_origin | name_search | address | tel | url | province | city | province_raw |
|---:|:---|:---|:---|:---|:---|:---|:---|:---|
| 28 | 星光农机股份有限公司 | 星光农机股份有限公司 | 浙江省湖州市和孚镇星光大街1699号 | 0572-3966138 | <https://www.tianyancha.com/company/864512390> | 浙江 | 湖州市 | 浙江省 |
| 9 | 工业和信息化部电子第五研究所 | 工业和信息化部电子第五研究所 | 广州市天河区 | 暂无信息 | <https://www.tianyancha.com/company/1146137548> | 广东 | NA | NA |
| 204 | 中国林业科学研究院资源昆虫研究所 | 中国林业科学研究院资源昆虫研究所 | 云南省昆明市盘龙区白龙寺 | 暂无信息 | <https://www.tianyancha.com/company/245341328> | 云南 | 昆明市 | 云南 |
| 89 | 应急管理部沈阳消防研究所 | 应急管理部沈阳消防研究所 | 辽宁省沈阳市皇姑区文大路218－20号甲 | 暂无信息 | <https://www.tianyancha.com/company/3324476301> | 辽宁 | 沈阳市 | 辽宁 |
| 205 | 中国林业科学研究院资源信息研究所 | 中国林业科学研究院资源信息研究所 | 北京市海淀区东小府2号 | 暂无信息 | <https://www.tianyancha.com/company/93212936> | 北京 | NA | 北京 |
| 4 | 中牧实业股份有限公司 | 中牧实业股份有限公司 | 北京市丰台区南四环西路188号八区16-19号楼 | 暂无信息 | <https://www.tianyancha.com/company/6174164> | 北京 | NA | NA |
| 56 | 交通运输部科学研究院 | 交通运输部科学研究院 | 北京市朝阳区惠新里240号 | 暂无信息 | <https://www.tianyancha.com/company/30004385> | 北京 | NA | 北京 |
| 13 | 华南农业大学 | 华南农业大学 | 广东省广州市天河区五山 | 暂无信息 | <https://www.tianyancha.com/company/1096941724> | 广东 | 广州市 | 广东省 |
| 119 | 中国疾病预防控制中心传染病预防控制所 | 中国疾病预防控制中心传染病预防控制所 | 北京市昌平流字5号（北京市昌平区百善乡孟祖村北） | 暂无信息 | <https://www.tianyancha.com/company/403803636> | 北京 | NA | 北京 |
| 123 | 中国疾病预防控制中心寄生虫病预防控制所 | 中国疾病预防控制中心寄生虫病预防控制所 | 上海市卢湾区瑞金二路207号 | 暂无信息 | <https://www.tianyancha.com/company/3028120171> | 上海 | NA | 上海 |

## Yearbook

### Source from Rural Yearbook

#### AgriMachine

**`AgriMachine`**：A **long format** data set containing Agricultural
Machine statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 6144 rows.

- Years range from 2010 to 2024

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

| province | year | chn_block4         |    value | units  | variables            |
|:---------|:-----|:-------------------|---------:|:-------|:---------------------|
| 海南     | 2019 | 机播面积           |  23.2000 | 千公顷 | v7_sctj_nyjx_jbmj    |
| 全国     | 2019 | 联合收获机         | 212.8000 | 万台   | v7_sctj_nyjx_lhshj   |
| 广西     | 2012 | 小型拖拉机配套农具 |  58.7900 | 万部   | v7_sctj_nyjx_xtlj_pt |
| 北京     | 2010 | 机动脱粒机         |   0.5100 | 万台   | v7_sctj_nyjx_jdtlj   |
| 宁夏     | 2014 | 小型拖拉机         |  16.7800 | 万台   | v7_sctj_nyjx_xtlj    |
| 安徽     | 2012 | 机耕面积           |       NA | 千公顷 | v7_sctj_nyjx_jgmj    |
| 贵州     | 2020 | 农用水泵           |  61.7000 | 万台   | v7_sctj_nyjx_nysb    |
| 江苏     | 2013 | 联合收获机         |  13.6600 | 万台   | v7_sctj_nyjx_lhshj   |
| 内蒙古   | 2011 | 小型拖拉机         |  47.9091 | 万台   | v7_sctj_nyjx_xtlj    |
| 海南     | 2013 | 大中型拖拉机       |   4.4500 | 万台   | v7_sctj_nyjx_dztlj   |

#### AgriFertilizer

**`AgriFertilizer`**：A **long format** data set containing Agricultural
Fertilizer statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1248 rows.

- Years range from 2010 to 2024

- Variables including: v7_sctj_nyhf_df, v7_sctj_nyhf_fhf,
  v7_sctj_nyhf_hj, v7_sctj_nyhf_jf, v7_sctj_nyhf_lf

``` r

AgriFertilizer %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |  value | units | variables        |
|:---------|:-----|:-----------|-------:|:------|:-----------------|
| 全国     | 2020 | 氮肥       | 1833.9 | 万吨  | v7_sctj_nyhf_df  |
| 新疆     | 2020 | 磷肥       |   62.0 | 万吨  | v7_sctj_nyhf_lf  |
| 浙江     | 2019 | 磷肥       |    7.8 | 万吨  | v7_sctj_nyhf_lf  |
| 陕西     | 2021 | 钾肥       |   23.1 | 万吨  | v7_sctj_nyhf_jf  |
| 云南     | 2018 | 化肥使用量 |  217.4 | 万吨  | v7_sctj_nyhf_hj  |
| 北京     | 2024 | 复合肥     |    4.4 | 万吨  | v7_sctj_nyhf_fhf |
| 上海     | 2019 | 磷肥       |    0.4 | 万吨  | v7_sctj_nyhf_lf  |
| 天津     | 2020 | 化肥使用量 |   15.3 | 万吨  | v7_sctj_nyhf_hj  |
| 河北     | 2022 | 复合肥     |  138.4 | 万吨  | v7_sctj_nyhf_fhf |
| 上海     | 2020 | 钾肥       |    0.2 | 万吨  | v7_sctj_nyhf_jf  |

#### AgriPlastic

**`AgriPlastic`**：A **long format** data set containing Agricultural
Plastic statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1440 rows.

- Years range from 2010 to 2024

- Variables including: v7_sctj_nybm_bmsy, v7_sctj_nybm_dmfg,
  v7_sctj_nybm_dmsy

``` r

AgriPlastic %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4     |     value | units | variables         |
|:---------|:-----|:---------------|----------:|:------|:------------------|
| 全国     | 2018 | 农用薄膜使用量 | 2464795.0 | 吨    | v7_sctj_nybm_bmsy |
| 贵州     | 2017 | NA             |   31901.0 | NA    | v7_sctj_nybm_dmsy |
| 广西     | 2015 | NA             |  415443.0 | NA    | v7_sctj_nybm_dmfg |
| 上海     | 2014 | NA             |   21296.0 | NA    | v7_sctj_nybm_dmfg |
| 安徽     | 2012 | NA             |   40479.0 | NA    | v7_sctj_nybm_dmsy |
| 陕西     | 2023 | 地膜使用量     |       2.2 | 万吨  | v7_sctj_nybm_dmsy |
| 湖北     | 2014 | NA             |   40645.0 | NA    | v7_sctj_nybm_dmsy |
| 上海     | 2024 | 地膜使用量     |       0.3 | 万吨  | v7_sctj_nybm_dmsy |
| 内蒙古   | 2023 | 农用薄膜使用量 |      12.7 | 万吨  | v7_sctj_nybm_bmsy |
| 四川     | 2016 | 农用薄膜使用量 |  132384.0 | 吨    | v7_sctj_nybm_bmsy |

#### AgriPesticide

**`AgriPesticide`**：A **long format** data set containing Agricultural
Pesticide statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 672 rows.

- Years range from 2010 to 2024

- Variables including: v7_sctj_cyny_cysy, v7_sctj_cyny_nysy

``` r

AgriPesticide %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4     |    value | units | variables         |
|:---------|:-----|:---------------|---------:|:------|:------------------|
| 山东     | 2015 | 农药使用量     | 151004.0 | 吨    | v7_sctj_cyny_nysy |
| 福建     | 2020 | 农用柴油使用量 |     78.4 | 万吨  | v7_sctj_cyny_cysy |
| 贵州     | 2015 | 农药使用量     |  13722.0 | 吨    | v7_sctj_cyny_nysy |
| 湖南     | 2019 | 农药使用量     | 105548.0 | 吨    | v7_sctj_cyny_nysy |
| 安徽     | 2024 | 农用柴油使用量 |     73.9 | 万吨  | v7_sctj_cyny_cysy |
| 安徽     | 2011 | 农药使用量     | 117475.0 | 吨    | v7_sctj_cyny_nysy |
| 安徽     | 2017 | 农药使用量     |  99394.0 | 吨    | v7_sctj_cyny_nysy |
| 湖南     | 2012 | 农药使用量     | 122980.0 | 吨    | v7_sctj_cyny_nysy |
| 新疆     | 2020 | 农用柴油使用量 |     85.2 | 万吨  | v7_sctj_cyny_cysy |
| 山西     | 2021 | 农用柴油使用量 |     25.8 | 万吨  | v7_sctj_cyny_cysy |

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

- Totally 896 rows.

- Years range from 2011 to 2024

- Variables including: v4_ztr_jf_RD, v4_ztr_qd_RD

``` r

RDIntense %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |  value | units | variables    |
|:---------|:-----|:-----------|-------:|:------|:-------------|
| 山西     | 2012 | RD强度     |   1.09 | %     | v4_ztr_qd_RD |
| 黑龙江   | 2016 | RD经费     | 152.50 | 亿元  | v4_ztr_jf_RD |
| 甘肃     | 2012 | RD强度     |   1.07 | %     | v4_ztr_qd_RD |
| 辽宁     | 2020 | RD经费     | 549.00 | 亿元  | v4_ztr_jf_RD |
| 山西     | 2014 | RD经费     | 152.20 | 亿元  | v4_ztr_jf_RD |
| 陕西     | 2017 | RD经费     | 460.90 | 亿元  | v4_ztr_jf_RD |
| 北京     | 2016 | RD强度     |   5.96 | %     | v4_ztr_qd_RD |
| 海南     | 2017 | RD经费     |  23.10 | 亿元  | v4_ztr_jf_RD |
| 河北     | 2011 | RD经费     | 201.30 | 亿元  | v4_ztr_jf_RD |
| 湖南     | 2020 | RD强度     |   2.15 | %     | v4_ztr_qd_RD |

#### RDActivity

**`RDActivity`**：A **long format** data set containing R&D Activity
statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1920 rows.

- Years range from 2010 to 2024

- Variables including: v4_zh_nbzc_hj, v4_zh_nbzc_jcyj, v4_zh_nbzc_syfz,
  v4_zh_nbzc_yyyj

``` r

RDActivity %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |     value | units | variables       |
|:---------|:-----|:-----------|----------:|:------|:----------------|
| 河北     | 2014 | 应用研究   |  275703.4 | 万元  | v4_zh_nbzc_yyyj |
| 天津     | 2017 | 基础研究   |  336505.3 | 万元  | v4_zh_nbzc_jcyj |
| 广西     | 2011 | 基础研究   |   46124.0 | 万元  | v4_zh_nbzc_jcyj |
| 湖南     | 2018 | 应用研究   |  724941.2 | 万元  | v4_zh_nbzc_yyyj |
| 陕西     | 2023 | 合计       | 8460446.0 | 万元  | v4_zh_nbzc_hj   |
| 辽宁     | 2020 | 合计       | 5490052.0 | 万元  | v4_zh_nbzc_hj   |
| 全国     | 2010 | 基础研究   | 3244923.3 | 万元  | v4_zh_nbzc_jcyj |
| 福建     | 2015 | 基础研究   |  100022.3 | 万元  | v4_zh_nbzc_jcyj |
| 湖南     | 2016 | 基础研究   |  131039.1 | 万元  | v4_zh_nbzc_jcyj |
| 广西     | 2023 | 基础研究   |  156901.0 | 万元  | v4_zh_nbzc_jcyj |

#### IndustryOperation

**`IndustryOperation`**：A **long format** data set containing Industry
Operation statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1344 rows.

- Years range from 2010 to 2024

- Variables including: v4_cy_scjy_lrze, v4_cy_scjy_qys, v4_cy_scjy_zyyw

``` r

IndustryOperation %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4   |   value | units | variables       |
|:---------|:-----|:-------------|--------:|:------|:----------------|
| 重庆     | 2020 | 企业数       |   813.0 | 个    | v4_cy_scjy_qys  |
| 江苏     | 2011 | 主营业务收入 | 19396.0 | 亿元  | v4_cy_scjy_zyyw |
| 河北     | 2024 | 企业数       |  1011.0 | 个    | v4_cy_scjy_qys  |
| 北京     | 2020 | 主营业务收入 |  6573.0 | 亿元  | v4_cy_scjy_zyyw |
| 黑龙江   | 2015 | 企业数       |   179.0 | 个    | v4_cy_scjy_qys  |
| 湖北     | 2024 | 利润总额     |   425.0 | 亿元  | v4_cy_scjy_lrze |
| 青海     | 2018 | 企业数       |    44.0 | 个    | v4_cy_scjy_qys  |
| 浙江     | 2011 | 利润总额     |   350.2 | 亿元  | v4_cy_scjy_lrze |
| 湖南     | 2010 | 利润总额     |    89.3 | 亿元  | v4_cy_scjy_lrze |
| 新疆     | 2021 | 利润总额     |    12.0 | 亿元  | v4_cy_scjy_lrze |

#### IndustryRD

**`IndustryRD`**：A **long format** data set containing Industry R&D
statistics .

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 4380 rows.

- Years range from 2016 to 2024

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

| province | year | chn_block4           |     value | units | variables        |
|:---------|:-----|:---------------------|----------:|:------|:-----------------|
| 广西     | 2024 | 开发经费支出         |  271425.0 | 万元  | v4_cy_xcp_kfjf   |
| 山东     | 2018 | 经费内部支出         | 2265528.0 | 万元  | v4_cy_RDhd_nbzc  |
| 内蒙古   | 2020 | 开发经费支出         |   80283.0 | 万元  | v4_cy_xcp_kfjf   |
| 吉林     | 2021 | 出口                 |  341804.0 | 万元  | v4_cy_xcp_ck     |
| 广西     | 2018 | 研发机构数           |      51.0 | 个    | v4_cy_RDhd_yfjgs |
| 浙江     | 2024 | 购买境内技术经费支出 |   97539.0 | 万元  | v4_cy_jsgz_gmzc  |
| 福建     | 2016 | 人员折合全时当量     |   27895.2 | 人年  | v4_cy_RDhd_qsdl  |
| 内蒙古   | 2024 | 开发经费支出         |  245206.0 | 万元  | v4_cy_xcp_kfjf   |
| 云南     | 2018 | 经费内部支出         |   92228.0 | 万元  | v4_cy_RDhd_nbzc  |
| 甘肃     | 2020 | 技术引进经费支出     |     900.0 | 万元  | v4_cy_jsgz_yjzc  |

#### MarketPull

**`MarketPull`**：A **long format** data set containing Tech Market Pull
statistics .

> **说明**：数据包括合同数（`amount-xxxx.xlsx`）和金额（`funds-xxxx.xlsx`）两个表格来源，需要独立更新全部xlsx后，再读取整合为一个数据表。

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1024 rows.

- Years range from 2000 to 2024

- Variables including: v4_cg_jssr_ht, v4_cg_jssr_je

``` r

MarketPull %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |     value | units | variables     |
|:---------|:-----|:-----------|----------:|:------|:--------------|
| 湖北     | 2000 | 金额       |  190942.0 | 万元  | v4_cg_jssr_je |
| 青海     | 2017 | 金额       |  775210.4 | 万元  | v4_cg_jssr_je |
| 江西     | 2024 | 数量       |   32765.0 | 项    | v4_cg_jssr_ht |
| 内蒙古   | 2005 | 金额       |  301515.5 | 万元  | v4_cg_jssr_je |
| 湖北     | 2015 | 数量       |   14831.0 | 项    | v4_cg_jssr_ht |
| 山东     | 2010 | 数量       |    9993.0 | 项    | v4_cg_jssr_ht |
| 广西     | 2022 | 数量       |    8853.0 | 项    | v4_cg_jssr_ht |
| 四川     | 2015 | 数量       |   11195.0 | 项    | v4_cg_jssr_ht |
| 甘肃     | 2024 | 金额       | 6725924.0 | 万元  | v4_cg_jssr_je |
| 河南     | 2014 | 数量       |    5343.0 | 项    | v4_cg_jssr_ht |

#### MarketPush

**`MarketPush`**：A **long format** data set containing Tech Market Push
statistics .

> **说明**：数据包括合同数（`amount-xxxx.xlsx`）和金额（`funds-xxxx.xlsx`）两个表格来源，需要独立更新全部xlsx后，再读取整合为一个数据表。

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1024 rows.

- Years range from 2000 to 2024

- Variables including: v4_cg_jssc_ht, v4_cg_jssc_je

``` r

MarketPush %>%
  sample_n(size = 10) %>%
  kable()
```

| province | year | chn_block4 |     value | units | variables     |
|:---------|:-----|:-----------|----------:|:------|:--------------|
| 福建     | 2005 | 数量       |    6510.0 | 项    | v4_cg_jssc_ht |
| 甘肃     | 2000 | 金额       |   26413.0 | 万元  | v4_cg_jssc_je |
| 湖南     | 2000 | 数量       |   21115.0 | 项    | v4_cg_jssc_ht |
| 内蒙古   | 2021 | 数量       |    1524.0 | 项    | v4_cg_jssc_ht |
| 福建     | 2020 | 金额       | 1635367.0 | 万元  | v4_cg_jssc_je |
| 北京     | 2014 | 数量       |   67284.0 | 项    | v4_cg_jssc_ht |
| 上海     | 2000 | 数量       |   20974.0 | 项    | v4_cg_jssc_ht |
| 广东     | 2005 | 金额       | 1124739.8 | 万元  | v4_cg_jssc_je |
| 宁夏     | 2000 | 数量       |     233.0 | 项    | v4_cg_jssc_ht |
| 内蒙古   | 2005 | 金额       |  109938.8 | 万元  | v4_cg_jssc_je |

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
| 山西     | 2018 | 进口贸易额 |   4050.0000 | 百万美元 | v4_cy_my_jk  |
| 河北     | 2017 | 贸易总额   |   3144.3140 | 百万美元 | v4_cy_my_jck |
| 四川     | 2018 | 进口贸易额 |  31073.0000 | 百万美元 | v4_cy_my_jk  |
| 贵州     | 2017 | 进口贸易额 |   1330.2896 | 百万美元 | v4_cy_my_jk  |
| 河南     | 2017 | 贸易总额   |  51509.5219 | 百万美元 | v4_cy_my_jck |
| 宁夏     | 2018 | 出口贸易额 |    146.0000 | 百万美元 | v4_cy_my_ck  |
| 广东     | 2017 | 进口贸易额 | 203757.5249 | 百万美元 | v4_cy_my_jk  |
| 四川     | 2018 | 出口贸易额 |  33488.0000 | 百万美元 | v4_cy_my_ck  |
| 新疆     | 2016 | 贸易总额   |    385.2117 | 百万美元 | v4_cy_my_jck |
| 贵州     | 2018 | 贸易总额   |   3439.0000 | 百万美元 | v4_cy_my_jck |

### Source from China National Yearbook

#### PublicBudget

**`PublicBudget`**：A **long format** data set containing Public Budget
statistics.

> **说明**：来源于《中国统计年鉴》，表7-6
> 分地区一般公共预算支出。我们只整理更新如下列变量：“地方一般公共预算支出”,“教育支出”,“科学技术支出”,“农林水支出”。

- Totally 6 columns including: province, year, chn_block4, value, units,
  variables.

- Totally 1884 rows.

- Years range from 2010 to 2024

- Variables including: v6_cz_yszc_hj, v6_cz_yszc_jy, v6_cz_yszc_kxjs,
  v6_cz_yszc_nls

| province | year | chn_block4 |     value | units | variables       |
|:---------|:-----|:-----------|----------:|:------|:----------------|
| 福建     | 2012 | 教育       |  562.3008 | 亿元  | v6_cz_yszc_jy   |
| 黑龙江   | 2018 | 科学技术   |   39.5200 | 亿元  | v6_cz_yszc_kxjs |
| 湖南     | 2019 | 科学技术   |  171.9200 | 亿元  | v6_cz_yszc_kxjs |
| 西藏     | 2018 | 科学技术   |    8.1200 | 亿元  | v6_cz_yszc_kxjs |
| 安徽     | 2015 | 科学技术   |  147.9400 | 亿元  | v6_cz_yszc_kxjs |
| 甘肃     | 2020 | 合计       | 4163.4000 | 亿元  | v6_cz_yszc_hj   |
| 河南     | 2024 | 教育       | 2059.6601 | 亿元  | v6_cz_yszc_jy   |
| 四川     | 2016 | 科学技术   |  101.0900 | 亿元  | v6_cz_yszc_kxjs |
| 宁夏     | 2019 | 教育       |  179.3300 | 亿元  | v6_cz_yszc_jy   |
| 上海     | 2010 | 教育       |  417.2775 | 亿元  | v6_cz_yszc_jy   |

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

| province | year | chn_block4 |  value | units | variables        |
|:---------|:-----|:-----------|-------:|:------|:-----------------|
| 广东     | 2014 | 种鹅场     |     22 | 个    | v8_t2_zcqc_zec   |
| 宁夏     | 2015 | 种公牛站   |      1 | 个    | v8_t3_zcqc_zgnz  |
| 江苏     | 2017 | 种绵羊场   |    453 | 枚    | v8_t9_scpt_zmyc  |
| 江西     | 2016 | 种蛋鸡场   | 770185 | 套    | v8_t4_nmcl_zdjc  |
| 海南     | 2016 | 种水牛场   |      0 | 枚    | v8_t8_scpt_zsnc  |
| 陕西     | 2011 | 种牦牛场   |     NA | 个    | v8_t1_zcqc_zhnc  |
| 辽宁     | 2018 | 种羊场     |  12674 | 只    | v8_t6_nfmccl_zyc |
| 陕西     | 2018 | 种马场     |    182 | 匹    | v8_t6_nfmccl_zmc |
| 吉林     | 2015 | 种兔场     |     14 | 个    | v8_t2_zcqc_ztc   |
| 山东     | 2015 | 种马场     |      3 | 个    | v8_t1_zcqc_zmc   |

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
| 2018 | 20191015 | SQ2018YFD030061 | 396 | 江西双季稻区绿色规模化丰产增效技术集成与示范 | 江西省农业科学院土壤肥料与资源环境研究所 | 刘光荣 | 2840 | 粮食丰产增效科技创新 | NA | SQ | 2018 | YFD | 030061 | 03 | 0061 | NA |
| 2018 | 20191015 | 2018YFC0809800 | 583 | 社区风险监测与防范关键技术研究 | 天津大学 | 王文俊 | 2365 | 公共安全风险防控与应急技术装备 | NA |  | 2018 | YFC | 0809800 | 08 | 09800 | NA |
| 2018 | 20191015 | 2018YFC1505700 | 832 | 青藏高原地-气相互作用及其对下游天气气候的影响 | 中国气象科学研究院 | 赵平 | 2864 | 重大自然灾害监测预警与防范 | NA |  | 2018 | YFC | 1505700 | 15 | 05700 | NA |
| 2019 | 20191015 | 2019YFA0110800 | 31 | 单基因遗传病的基因治疗研究 | 中国科学院动物研究所 | 李伟 | 2808 | 干细胞及转化研究 | NA |  | 2019 | YFA | 0110800 | 01 | 10800 | NA |
| 2019 | 20191015 | 2019YFA0508500 | 68 | 固有免疫应答新型关键蛋白质机器功能与机制研究 | 中国科学技术大学 | 周荣斌 | 2444 | 蛋白质机器与生命过程调控 | NA |  | 2019 | YFA | 0508500 | 05 | 08500 | NA |
| 2018 | 20191015 | 2018YFC1903300 | 898 | 铜铅锌综合冶炼基地多源固废协同利用集成示范 | 株洲冶炼集团股份有限公司 | 刘朗明 | 2642 | 固废资源化 | NA |  | 2018 | YFC | 1903300 | 19 | 03300 | NA |
| 2020 | 20201127 | 2020YFA0711500 | 410 | 基于电卡制冷效应的时空精准芯片主动控温系统设计与研究 | 上海交通大学 | NA | NA | 变革性技术关键科学问题 | NA |  | 2020 | YFA | 0711500 | 07 | 11500 | NA |
| 2018 | 20191015 | 2018YFA0507900 | 57 | 抑郁相关神经递质膜受体蛋白质机器促进胃癌侵袭转移的分子机制及靶向干预研究 | 中国人民解放军第三军医大学 | 欧阳勤 | 494 | 蛋白质机器与生命过程调控 | NA |  | 2018 | YFA | 0507900 | 05 | 07900 | NA |
| 2018 | 20191015 | 2018YFA0404500 | 43 | 星系结构、演化与宇宙学研究 | 中国科学院国家天文台 | 毛淑德 | 4754 | 大科学装置前沿研究 | NA |  | 2018 | YFA | 0404500 | 04 | 04500 | NA |
| 2018 | 20191015 | 2018YFC1407000 | 528 | 海洋动力灾害观测预警系统集成与应用示范 | 国家海洋环境预报中心 | 于福江 | 1325 | 海洋环境安全保障 | NA |  | 2018 | YFC | 1407000 | 14 | 07000 | NA |

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
|    17 | 05    | 广东湛江国家农业科技园区           | 广东     |
|    27 | 06    | 广东河源国家农业科技园区           | 广东     |
|    37 | 05    | 山东泰安国家农业科技园区           | 山东     |
|    11 | 02    | 新疆昌吉国家农业科技园区           | 新疆     |
|     4 | 09    | 内蒙古自治区兴安盟国家农业科技园区 | 内蒙古   |
|    11 | 09    | 安徽黄山国家农业科技园区           | 安徽     |
|     3 | 04    | 山西运城国家农业科技园区           | 山西     |
|    25 | 03    | 新疆伊犁国家农业科技园区           | 新疆     |
|     4 | 02    | 安徽宿州国家农业科技园区           | 安徽     |
|     9 | 06    | 重庆潼南国家农业科技园区           | 重庆     |

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
| 2020 |    13 | 湖北荆门国家农业科技园区       | ok     | 湖北     |
| 2019 |    23 | 浙江金华国家农业科技园区       | ok     | 浙江     |
| 2021 |    46 | 陕西铜川国家农业科技园区       | ok     | 陕西     |
| 2020 |     1 | 河北石家庄藁城国家农业科技园区 | good   | 河北     |
| 2020 |     3 | 江苏南通国家农业科技园区       | good   | 江苏     |
| 2019 |     6 | 贵州毕节国家农业科技园区       | fail   | 贵州     |
| 2019 |    40 | 河南南阳国家农业科技园区       | ok     | 河南     |
| 2021 |     3 | 吉林延边国家农业科技园区       | retain | 吉林     |
| 2019 |    43 | 湖北潜江国家农业科技园区       | ok     | 湖北     |
| 2021 |     9 | 辽宁锦州国家农业科技园区       | ok     | 辽宁     |

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
| 2018 |    18 | 山东临沂国家农业科技园区     | pass   | 山东     | 国科办农2018-99    |
| 2021 |    15 | 河南信阳国家农业科技园区     | pass   | 河南     | 国科办农2021-150号 |
| 2017 |    34 | 安徽蚌埠国家农业科技园区     | pass   | 安徽     | 国科办函农2017-767 |
| 2017 |    42 | 安徽合肥国家农业科技园区     | pass   | 安徽     | 国科办函农2017-767 |
| 2018 |     5 | 江苏无锡国家农业科技园区     | pass   | 江苏     | 国科办农2018-99    |
| 2019 |    72 | 上海崇明国家农业科技园区     | pass   | 上海     | 国科办农2019-87    |
| 2017 |    19 | 甘肃武威国家农业科技园区     | pass   | 甘肃     | 国科办函农2017-767 |
| 2018 |    39 | 陕西咸阳国家农业科技园区     | pass   | 陕西     | 国科办农2018-99    |
| 2023 |    15 | 湖北咸宁国家农业科技园区     | pass   | 湖北     | 国科办农2023-60    |
| 2021 |    31 | 新疆博尔塔拉国家农业科技园区 | pass   | 新疆     | 国科办农2021-150号 |

#### PubAgrimodernZone

> **说明**：本数据集整理农业农村部农业现代化示范区创建名单（`data-raw/public-site/moa-agrimodern-zone/`）。年度
> html 经 `code-moa-agrimodern-zone.R` 解析为 xlsx，再由
> `wfl-PubAgrimodernZone.R` 编译。覆盖 2021–2023 年三批创建名单，以及
> 2026 年拟批准公示名单；2024、2025 年名单暂未公示。

**`PubAgrimodernZone`**：A **wide format** data set containing MOA
agricultural modernization demonstration zones from annual creation
notices.

- Totally 4 columns including: year, index, name, province.

- Totally 356 rows.

- Years: 2021, 2022, 2023, 2026

``` r

PubAgrimodernZone %>%
  count(year) %>%
  kable()
```

| year |   n |
|-----:|----:|
| 2021 | 100 |
| 2022 | 100 |
| 2023 | 100 |
| 2026 |  56 |

#### HitechFirmsPub

**数据来源**：科学技术部火炬高技术产业开发中心<http://www.innocom.gov.cn>。

**说明**：本数据集直接在`tech-report`项目下进行原始数据（data-raw）的清洗和整理（“tech-report/data-raw/public-site/torch-innocom/xlsx/”）；然后清洗后的xlsx文件复制到（“tech-report/data-raw/data-tidy/public-site/torch-innocom/xlsx/”）。最后再一次复制到`techme`包开发环境下的”techme/data-raw/data-tidy/public-site/torch-innocom/xlsx/“，再经由”techme/data-raw/wfl_useData_HitechFirms.R”进行批量读取和数据集编译。

**`HitechFirmsPub`**：A **wide format** data set containing Details of
Hi-tech Firms Numbers on Public Site.

- Totally 4 columns including: index, year, province, num.

- Totally 248 rows.

- Years range from 2018 to 2025

``` r

HitechFirmsPub %>%
  sample_n(size = 10) %>%
  kable()
```

| index | year | province |   num |
|------:|-----:|:---------|------:|
|     5 | 2022 | 内蒙古   |   681 |
|    28 | 2018 | 甘肃     |   426 |
|     8 | 2022 | 黑龙江   |  1200 |
|    10 | 2021 | 江苏     | 12631 |
|    20 | 2024 | 广西     |  1143 |
|    20 | 2022 | 广西     |  1376 |
|    30 | 2019 | 宁夏     |    85 |
|    13 | 2020 | 福建     |  2989 |
|     5 | 2018 | 内蒙古   |   335 |
|    28 | 2019 | 甘肃     |   354 |

#### PubOpenShare

**数据来源**：科学技术部火炬高技术产业开发中心<http://www.innocom.gov.cn>。

**说明**：本数据集直接在`techme`项目下进行原始数据（data-raw）的清洗和整理（“techme/data-raw/public-site/most-jcs-open-share/xlsx/”），再经由”techme/data-raw/public-site/most-jcs-open-share/wfl-PubOpenShare.R”进行批量读取和数据集编译。

**`PubOpenShare`**：A **wide format** data set containing Details of
Evaluation result of Major Scientific Infrastructure and Large-scale
Scientific Instruments Sharing.

- Totally 6 columns including: year, index, institution, result,
  administrator, province.

- Totally 2797 rows.

- Years range from 2018 to 2025

``` r

PubOpenShare %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | institution | result | administrator | province |
|---:|---:|:---|:---|:---|:---|
| 2023 | 280 | 中国科学院北京基因组研究所（国家生物信息中心） | 合格 |  | 北京 |
| 2018 | 278 | 中国林业科学研究院林业研究所 | 合格 | 国家林业和草原局 | 北京 |
| 2018 | 136 | 中国科学院北京基因组研究所 | 合格 | 中国科学院 | 北京 |
| 2025 | 67 | 哈尔滨工程大学 | 良好 |  | 黑龙江 |
| 2020 | 342 | 中国疾病预防控制中心寄生虫病预防控制所 | 合格 | NA | 上海 |
| 2023 | 319 | 国家深海基地管理中心 | 合格 |  | 山东 |
| 2018 | 23 | 中国城市规划设计研究院 | 优秀 | 住房和城乡建设部 | 北京 |
| 2019 | 92 | 国际竹藤中心 | 良好 | 国家林业和草原局 | 北京 |
| 2020 | 303 | 中国测绘科学研究院 | 合格 | NA | 北京 |
| 2018 | 160 | 重庆大学 | 合格 | 教育部 | 重庆 |

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

- Totally 16 columns including: year, index, area_num_eng, area_name,
  chairman_industry, institution_industry, func_num, func_name,
  func_inst, func_director, researcher_area, researcher_name,
  researcher_inst, province_industry, province_func,
  province_researcher.

- Totally 2190 rows.

- Years range from 2011 to 2026

``` r

PubObsStation %>%
  sample_n(size = 10) %>%
  kable()
```

| officer | year | index | name | institution | administrator | province |
|:---|:---|:---|:---|:---|:---|:---|
| MOE | 2019 | 1 | 塞罕坝森林草原过渡带教育部野外科学观测研究站 | 北京大学 | NA | 北京 |
| MOA | 2018 | 21 | 国家土壤质量洪山观测实验站 | 湖北省农业科学院 | NA | 湖北 |
| MOA | 2019 | 64 | 国家农业科学农业环境日喀则观测实验站 | 西藏自治区农牧科学院 | NA | 西藏 |
| MOA | 2019 | 21 | 国家农业科学农业环境儋州观测实验站 | 中国热带农业科学院环境与植物保护研究所 | NA | 海南 |
| MOST | 2019 | 96 | 青海格尔木盐湖水环境材料腐蚀国家野外科学观测研究站 | 钢铁研究总院青岛海洋腐蚀研究所有限公司 | 国资委 | 山东 |
| MOST | 2019 | 75 | 福建厦门海水环境材料腐蚀国家野外科学观测研究站 | 中国船舶重工集团公司第七二五研究所 | 国资委 | 河南 |
| MOST | 2021 | 51 | 上海长江河口湿地生态系统国家野外科学观测研究站 | 复旦大学 | 上海市科学技术委员会 | 上海 |
| MOA | 2019 | 67 | 国家农业科学农业环境沈阳观测实验站 | 中国科学院沈阳应用生态研究所 | NA | 辽宁 |
| MOST | 2021 | 25 | 江苏南京水稻种质资源国家野外科学观测研究站 | 南京农业大学 | 农业农村部、教育部 | 江苏 |
| MOA | 2019 | 19 | 国家农业科学渔业资源环境秦皇岛观测实验站 | 中国水产科学研究院北戴河中心实验站 | NA | 河北 |

#### PubAgriMarket

> **说明**：本数据集整理农业农村部定点市场认定 /
> 取消名单（`data-raw/public-site/moa-agri-market/`）。2018、2024 年
> YAML 经 `code-moa-agri-market-yaml.R` 展开为 tidy xlsx，再由
> `wfl-PubAgriMarket.R` 编译。`type` 为认定名单 /
> 取消名单；新疆生产建设兵团记为新疆。

**`PubAgriMarket`**：A **wide format** data set containing MOA
designated wholesale markets from the 2018 review and 2024 re-inspection
notices.

- Totally 5 columns including: year, type, province, index, name.

- Totally 1782 rows.

- Years: 2018, 2024

- `type` values: 认定名单 / 取消名单。

``` r

PubAgriMarket %>%
  count(year, type) %>%
  tidyr::pivot_wider(names_from = type, values_from = n, values_fill = 0) %>%
  kable()
```

| year | 取消名单 | 认定名单 |
|-----:|---------:|---------:|
| 2018 |      194 |      745 |
| 2024 |      180 |      663 |

#### PubAgriTechDemoBase

> **说明**：本数据集合并两套公示口径（`data-raw/public-site/moa-agritech-demo-base/`）。2020、2025
> 年 YAML 经 `code-moa-agritech-demo-base-yaml.R` 展开为 tidy xlsx，再由
> `wfl-PubAgriTechDemoBase.R` 编译。`source`
> 区分当前口径（现代农业科技试验示范基地）与历史口径（国家农业科技示范展示基地）；2025
> 的 `type` 为种植业 / 畜牧兽医 / 渔业 / 农机 / 资源环境，2020
> 无分类。新疆生产建设兵团记为新疆。

**`PubAgriTechDemoBase`**：A **wide format** data set containing MOA
agricultural sci-tech demonstration bases from the 2020 historical list
and the 2025 first-batch notice.

- Totally 7 columns including: year, index, source, type, name,
  institution, province.

- Totally 259 rows.

- Years: 2020, 2025

- `source` values: 现代农业科技试验示范基地 / 国家农业科技示范展示基地。

``` r

PubAgriTechDemoBase %>%
  count(year, source) %>%
  tidyr::pivot_wider(names_from = source, values_from = n, values_fill = 0) %>%
  kable()
```

| year | 国家农业科技示范展示基地 | 现代农业科技试验示范基地 |
|-----:|-------------------------:|-------------------------:|
| 2020 |                      110 |                        0 |
| 2025 |                        0 |                      149 |

#### PubGeneticResource

> **说明**：本数据集合并两条年度批次公示口径（`data-raw/public-site/moa-genetic-resource/`），由
> `wfl-PubGeneticResource.R` 编译。`type` 同时收录农作物 /
> 农业微生物，以及畜禽保种场 / 畜禽基因库 / 畜禽保护区 /
> 畜禽变更。全量库圃快照见 `PubGeneticResourceCrop`。

**`PubGeneticResource`**：A **wide format** data set containing approved
national genetic-resource bases from MOA year-batch notices (crop /
microbe banks and livestock conservation units).

- Totally 7 columns including: year, batch, type, index, name,
  institution, province.

- Totally 358 rows.

- Years range from 2021 to 2025

- `type` values: 农作物 / 农业微生物；畜禽保种场 / 畜禽基因库 /
  畜禽保护区 / 畜禽变更。

``` r

PubGeneticResource %>%
  count(year, type) %>%
  tidyr::pivot_wider(names_from = type, values_from = n, values_fill = 0) %>%
  kable()
```

| year | 畜禽保护区 | 畜禽保种场 | 畜禽基因库 | 农业微生物 | 农作物 | 畜禽变更 |
|-----:|-----------:|-----------:|-----------:|-----------:|-------:|---------:|
| 2021 |         24 |        173 |          8 |          0 |      0 |        0 |
| 2022 |          0 |         10 |          2 |         19 |     72 |        0 |
| 2023 |          1 |          8 |          1 |          8 |      1 |        1 |
| 2024 |          0 |         13 |          0 |          2 |      5 |        0 |
| 2025 |          0 |          2 |          5 |          0 |      3 |        0 |

#### PubGeneticResourceCrop

> **说明**：本数据集在`techme`项目下参数化爬取全国农作物种质资源信息平台库圃列表（“techme/data-raw/public-site/moa-genetic-resource/”），清洗后的xlsx经由`wfl-PubGeneticResource.R`编译。与按年度批次公示的`PubGeneticResource`口径不同。

**`PubGeneticResourceCrop`**：A **wide format** data set containing the
full list of national crop germplasm resource banks and nurseries.

- Totally 7 columns including: year, index, determineYear, province,
  nature, title, institution.

- Totally 81 rows.

- Years range from 2026 to 2026

``` r

PubGeneticResourceCrop %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | determineYear | province | nature | title | institution |
|---:|---:|---:|:---|:---|:---|:---|
| 2026 | 34 | 2022 | 山东 | 种质圃 | 国家核桃板栗种质资源圃（泰安） | 山东省果树研究所 |
| 2026 | 77 | 2022 | 河北 | 种质圃 | 国家环渤海地区特色果树种质资源圃（昌黎） | 河北省农林科学院昌黎果树研究所 |
| 2026 | 51 | 2022 | 广西 | 种质圃 | 国家野生稻种质资源圃（南宁） | 广西壮族自治区农业科学院 |
| 2026 | 31 | 2022 | 福建 | 种质圃 | 国家闽台特色作物种质资源圃（漳州） | 福建省农业科学院亚热带农业研究所 |
| 2026 | 26 | 2022 | 浙江 | 中期库 | 国家水稻种质资源中期库（杭州） | 中国水稻研究所 |
| 2026 | 3 | 2022 | 北京 | 中期库 | 国家蔬菜种质资源中期库（北京） | 中国农业科学院蔬菜花卉研究所 |
| 2026 | 17 | 2022 | 黑龙江 | 中期库 | 国家甜菜种质资源中期库（哈尔滨） | 黑龙江大学 |
| 2026 | 63 | 2022 | 云南 | 种质圃 | 国家甘蔗种质资源圃（开远） | 云南省农业科学院甘蔗研究所 |
| 2026 | 33 | 2022 | 山东 | 中期库 | 国家烟草种质资源中期库（青岛） | 中国农业科学院烟草研究所 |
| 2026 | 48 | 2022 | 广东 | 种质圃 | 国家荔枝香蕉种质资源圃（广州） | 广东省农业科学院果树研究所 |

#### PubMachineCountyCase

> **说明**：本数据集在`techme`项目下整理农业农村部特色经济作物全程机械化生产模式与典型案例公示名单（“techme/data-raw/public-site/moa-machine-county/”），yaml
> 经 `code-moa-machine-county-case.R` 展开为 xlsx，再由
> `wfl-PubMachineCounty.R` 编译。

**`PubMachineCountyCase`**：A **wide format** data set containing
typical cases of full-process mechanization for specialty economic
crops.

- Totally 9 columns including: year, batch, category, index, order,
  title, province, place, crop.

- Totally 120 rows.

- Years range from 2021 to 2025

``` r

PubMachineCountyCase %>%
  sample_n(size = 10) %>%
  kable()
```

| year | batch | category | index | order | title | province | place | crop |
|---:|---:|:---|---:|---:|:---|:---|:---|:---|
| 2021 | 1 | 蔬菜 | 12 | 12 | 山东章丘大葱机械化生产模式与典型案例 | 山东 | 章丘 | 大葱 |
| 2021 | 1 | 中药材 | 26 | 12 | 辽宁省龙胆草种植机械化生产模式与典型案例 | 辽宁 | 清原县 | 龙胆草 |
| 2021 | 1 | 蔬菜 | 13 | 13 | 山东大蒜机械化生产模式与典型案例 | 山东 | 章丘 | 大蒜 |
| 2022 | 2 | 茶叶 | 26 | 9 | 浙江陡坡茶园（绍兴日铸茶）机械化生产模式与典型案例 | 浙江 | 绍兴 | 日铸茶 |
| 2025 | 5 | 中药材 | 18 | 4 | 安徽太和桔梗机械化生产模式与典型案例 | 安徽 | 太和 | 桔梗 |
| 2021 | 1 | 中药材 | 25 | 11 | 东北人参种植机械化生产模式与典型案例 | 吉林 | 集安市 | 人参 |
| 2022 | 2 | 中药材 | 32 | 4 | 广西藤县粉葛机械化生产模式与典型案例 | 广西 | 藤县 | 粉葛 |
| 2024 | 4 | 蔬菜 | 5 | 5 | 日光温室果菜轨道辅助生产机械化模式与典型案例 | NA | NA | 果菜 |
| 2021 | 1 | 蔬菜 | 4 | 4 | 江苏响水西兰花机械化生产模式与典型案例 | 江苏 | 响水 | 西兰花 |
| 2022 | 2 | 茶叶 | 25 | 8 | 浙江平地茶园（松阳绿茗峰）机械化生产模式与典型案例 | 浙江 | 松阳 | 茶叶 |

#### PubBreedingXmj

> **已弃用**：请改用 `PubXmjBreeding`。本对象为 2010–2020
> 快照，将在后续版本移除。

**`PubBreedingXmj`**：A **wide format** data set containing details of
Officer’ Livestock Breeding List from MOA (Xmj).

- Totally 7 columns including: year, index, province, type, name_origin,
  name_change, mark.

- Totally 287 rows.

- Years range from 2010 to 2020

#### PubXmjBreeding

> **说明**：本数据集在 `techme`
> 项目下整理农业农村部国家畜禽核心育种场等公示名单（`data-raw/public-site/moa-xmj-breeding/`）。2010–2020
> 年由 `scrape-breeding.Rmd` 清洗（空省份已从旧快照回填）；2021 年起
> YAML 经 `code-scrape-breeding.R` 展开为 tidy xlsx，再由
> `wfl-PubXmjBreeding.R` 编译。这是当前唯一应使用的名单。

**`PubXmjBreeding`**：A **wide format** data set containing national
core livestock breeding farms, elite multiplier farms, and core sire
stations from MOA notices.

- Totally 7 columns including: year, index, province, type, name_origin,
  name_change, mark.

- Totally 610 rows.

- Years range from 2010 to 2024

``` r

PubXmjBreeding %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | province | type | name_origin | name_change | mark |
|:---|:---|:---|:---|:---|:---|:---|
| 2020 | 2 | 辽宁 | 国家生猪核心育种场 | 阜新原种猪场 | NA | 资格取消 |
| 2018 | 5 | 上海 | 国家奶牛核心育种场 | 光明牧业有限公司金山种奶牛场 | NA | 遴选公示 |
| 2023 | 22 | 新疆 | 国家奶牛核心育种场 | 昌吉市吉缘牧业有限公司良种繁育场 | NA | 核验通过 |
| 2014 | 9 | 云南 | 国家肉牛核心育种场 | 腾冲县巴福乐槟榔江水牛良种繁育有限公司 | NA | 遴选公示 |
| 2015 | 4 | 上海 | 国家生猪核心育种场 | 上海市上海农场 | NA | 遴选公示 |
| 2024 | 33 | 湖北 | 国家蛋鸡良种扩繁推广场 | 湖北峪口禽业有限公司 | NA | 核验通过 |
| 2024 | 2 | 黑龙江 | 国家奶牛核心育种场 | 北安农垦长鑫牧场专业合作社 | NA | 遴选公示 |
| 2020 | 3 | 江苏 | NA | 江苏省家禽科学研究所家禽育种中心 | 江苏省家禽科学研究所科技创新中心 | 名称变更 |
| 2023 | 9 | 河南 | 国家生猪核心育种场 | 河南省黄泛区鑫欣牧业股份有限公司 | NA | 核验通过 |
| 2015 | 6 | 山东 | 国家肉鸡良种扩繁推广基地 | 山东益生种畜禽股份有限公司 | NA | 遴选公示 |

#### PubStandardXmj

> **已弃用**：请改用 `PubXmjStandard`。本对象为 2010–2020
> 快照，将在后续版本移除。

**`PubStandardXmj`**：A **wide format** data set containing details of
Officer’ Livestock Standard List from MOA (Xmj).

- Totally 5 columns including: year, index, province, prod_name,
  com_name.

- Totally 3377 rows.

- Years range from 2010 to 2020

#### PubXmjStandard

> **说明**：本数据集在 `techme`
> 项目下整理农业农村部畜禽养殖标准化示范场认定名单（`data-raw/public-site/moa-xmj-standard/`）。2010–2020
> 年由 `scrape-standard.Rmd` 清洗（无 2012 年公示）；2021 年起 YAML 经
> `code-scrape-standard.R` 展开为 tidy xlsx，再由 `wfl-PubXmjStandard.R`
> 编译。这是当前唯一应使用的名单。

**`PubXmjStandard`**：A **wide format** data set containing livestock
standardized demonstration farms from MOA designation notices.

- Totally 5 columns including: year, index, area_name, prod_name,
  com_name.

- Totally 3968 rows.

- Years range from 2010 to 2023

``` r

PubXmjStandard %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | area_name | prod_name | com_name                             |
|:-----|:------|:----------|:----------|:-------------------------------------|
| 2020 | 71    | 山东      | 奶牛      | 格润富德农牧科技股份有限公司（牧场） |
| 2014 | 52    | 辽宁      | 肉羊      | 永生养羊专业合作社                   |
| 2015 | 169   | 江西      | 蛋鸡      | 江西小牧童生态农业发展有限公司       |
| 2023 | 83    | 山东      | 生猪      | 青岛新万福食品有限公司(青山猪场)     |
| 2017 | 273   | 山东      | 生猪      | 高唐县庆凯养殖有限公司               |
| 2010 | 69    | 河北省    | 奶牛      | 武邑县茂祥奶牛养殖有限公司           |
| 2023 | 142   | 四川      | 生猪      | 大竹县国牧农业集团有限公司           |
| 2014 | 315   | 宁夏      | 肉羊      | 宁夏易林环境建设有限公司             |
| 2014 | 115   | 安徽      | 生猪      | 合肥市华杰畜禽养殖有限公司           |
| 2017 | 19    | 河北      | 生猪      | 廊坊市安达养殖有限公司               |
