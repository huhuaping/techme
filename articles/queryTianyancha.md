# 机构信息库

``` r

library(techme)
require(knitr)
#> Loading required package: knitr
library(magrittr)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
```

## 机构信息库

### 天眼查工作流程

（1）根据实际需要，进行机构库比对，然后获得唯一化增量机构列表

（2）在R包`techme`中进行天眼查

- 循环查询（`Rselenium`方法，适合批量查询）；或者手动查询（手都更新，适合少量查询）

- 得到结果，并人工确认

- 重新整合更新`qureyTianyan`

- build R包`techme`并push 到github: “huhuaping/techme”

### 增量更新架构

增量更新架构：

（1）获得增量机构名单。对于新引入的机构名单，首先进行唯一化处理。然后再与现有机构信息库`queryTianyan`进行比对，获得新增机构名单。保存到”techme/data-raw/data-tidy/hack-tianyan/ship/ship-tot5-2023-07-11.xlsx”

> **说明**：以上步骤一般在报告写作的具体部分进行操作完成，例如：“tech-report/data-raw/public-site/most-jcs-open-share/scrape-open-share.Rmd”，包含了对最初始数据的爬取、清洗和整理。最后将机构名单输出到后面的`techme`包开发文件夹下”techme/data-raw/data-tidy/hack-tianyan/ship/“。

（2）查询增量机构信息。通过循环查询（`Rselenium`方法，适合批量查询），或者手动查询（手都更新，适合少量查询），得到增量机构信息。保存到”techme/data-raw/data-tidy/hack-tianyan/hub/match-tianyan-tot5-2023-07-11.xlsx”

（3）整合机构信息。读取全部查询到的机构信息表（“techme/data-raw/data-tidy/hack-tianyan/hub/xxx.xlsx”）

（4）更新数据集`queryTianyan`并编译R包`techme`。

> **说明**：以上三个步骤都是在`techme`包开发环境下进行操作完成，例如：““techme/data-raw/hack_tianyan-new.R”，就包含了`Rselenium`方法，以及自动清洗和整理、更新数据集`queryTianyan`的全部代码命令。

### 增量更新来源

以下报告内容的写作中，可能需要增量更新机构数据信息：

（1）科技部公开数据来源：

- `open-share`：中央级高校和科研院所等单位重大科研基础设施和大型科研仪器开放共享评价考核结果。此数据集目前未在`techme`发布，仅在`tech-report`项目下进行维护和更新，维护路径为”tech-report/data-raw/public-site/most-jcs-open-share”。

### queryTianyan数据集

**`queryTianyan`**：A data set containing basic info of institution
enrolled in officer administrator.

- Totally 9 columns including: index, name_origin, name_search, address,
  tel, url, province, city, province_raw.

- Totally 596 rows.

``` r

data(queryTianyan)
queryTianyan %>%
  sample_n(size = 20) %>%
  kable()
```

| index | name_origin | name_search | address | tel | url | province | city | province_raw |
|---:|:---|:---|:---|:---|:---|:---|:---|:---|
| 112 | 中国地质科学院岩溶地质研究所 | 中国地质科学院岩溶地质研究所 | 广西壮族自治区桂林市七星区七星路50号 | 暂无信息 | <https://www.tianyancha.com/company/2998353967> | 广西 | 桂林市 | 广西 |
| 29 | 中国林业科学研究院林业科技信息研究所 | 中国林业科学研究院林业科技信息研究所 | 北京市海淀区东小府2号 | 暂无信息 | <https://www.tianyancha.com/company/2349164917> | 北京 | NA | NA |
| 7 | 中国热带农业科学院广州实验站 | 中国热带农业科学院广州实验站 | 广东省广州市荔湾区康王中路241号 | NA | <https://www.tianyancha.com/company/2325546651> | 广东 | NA | NA |
| 2 | 大连海事大学 | 大连海事大学 | 辽宁省大连市甘井子区凌水街道凌海路1号 | 暂无信息 | <https://www.tianyancha.com/company/521989738> | 辽宁 | 大连市 | 辽宁 |
| 26 | 中国科学院古脊椎动物与古人类研究所 | 中国科学院古脊椎动物与古人类研究所 | 北京市西直门外大街142号 | 暂无信息 | <https://www.tianyancha.com/company/125733723> | 北京 | NA | 北京 |
| 43 | 中国科学院微电子研究所 | 中国科学院微电子研究所 | 北京市朝阳区北土城西路3号 | 010-84025539 | <https://www.tianyancha.com/company/11619487> | 北京 | NA | 北京市 |
| 4 | 中国科学院空天信息创新研究院 | 中国科学院空天信息创新研究院 | 地址 | NA | NA | 北京 | NA | NA |
| 140 | 中国科学院电子学研究所 | 中国科学院电子学研究所 | 北京市海淀区北四环西路19号 | 暂无信息 | <https://www.tianyancha.com/company/789299> | 北京 | NA | 北京 |
| 136 | 中国科学院大气物理研究所 | 中国科学院大气物理研究所 | 北京德胜门外祁家豁子华严里7号楼 | 暂无信息 | <https://www.tianyancha.com/company/2319154562> | 北京 | NA | 北京 |
| 1 | 大连工业大学 | 大连工业大学 | 大连市甘井子区轻工苑1号 | 暂无信息 | <https://www.tianyancha.com/company/472532688> | 辽宁 | 大连市 | NA |
| 20 | 农业部环境保护科研监测所 | 农业部环境保护科研监测所 | 天津市南开区复康路31号 | 暂无信息 | <https://www.tianyancha.com/company/2960438574> | 天津 | NA | 天津市 |
| 16 | 国家海洋环境预报中心 | 国家海洋环境预报中心 | 北京市海淀区大慧寺8号 | 暂无信息 | <https://www.tianyancha.com/company/3372709473> | 北京 | NA | 北京 |
| 34 | 金宇保灵生物药品有限公司 | 金宇保灵生物药品有限公司 | 内蒙古自治区呼和浩特市经济技术开发区沙尔沁工业园区金宇大街1号 | 暂无信息 | <https://www.tianyancha.com/company/745538508> | 内蒙古 | NA | NA |
| 51 | 中国农业科学院农业资源与农业区划研究所 | 中国农业科学院农业资源与农业区划研究所 | 北京市海淀区中关村南大街12号 | 010-86616891 | <https://www.tianyancha.com/company/2318856838> | 北京 | NA | 北京市 |
| 15 | 华智生物技术有限公司 | 华智生物技术有限公司 | 长沙市芙蓉区合平路618号 | 暂无信息 | <https://www.tianyancha.com/company/3423810641> | 湖南 | NA | NA |
| 1 | 北方民族大学 | 北方民族大学 | 宁夏回族自治区银川市西夏区文昌北街204号 | 暂无信息 | <https://www.tianyancha.com/company/3097985620> | 宁夏 | 银川市 | 宁夏 |
| 39 | 中国科学院南海海洋研究所 | 中国科学院南海海洋研究所 | 广东省广州市南沙区海滨路1119号 | 暂无信息 | <https://www.tianyancha.com/company/2325512000> | 广东 | 广州市 | 广东省 |
| 9 | 中国农科院兰州畜牧与兽药研究所 | 中国农业科学院兰州畜牧与兽药研究所 | 甘肃省兰州市七里河区硷沟沿335号 | 暂无信息 | <https://www.tianyancha.com/company/26596773> | 甘肃 | 兰州市 | 甘肃 |
| 239 | 中国石油大学（华东） | 中国石油大学（华东） | 山东省东营市北二路271号 | 暂无信息 | <https://www.tianyancha.com/company/2965372695> | 山东 | 东营市 | 山东 |
| 30 | 袁隆平农业高科技股份有限公司 | 袁隆平农业高科技股份有限公司 | 长沙市芙蓉区合平路618号A座518 | 0731-82183111 | <https://www.tianyancha.com/company/19889710> | 湖南 | 长沙市 | NA |
