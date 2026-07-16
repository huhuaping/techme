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

- Totally 588 rows.

``` r

data(queryTianyan)
queryTianyan %>%
  sample_n(size = 20) %>%
  kable()
```

| index | name_origin | name_search | address | tel | url | province | city | province_raw |
|---:|:---|:---|:---|:---|:---|:---|:---|:---|
| 120 | 中国疾病预防控制中心辐射防护与核安全医学所 | 中国疾病预防控制中心辐射防护与核安全医学所 | 北京市西城区新康街2号 | 暂无信息 | <https://www.tianyancha.com/company/3097986118> | 北京 | NA | 北京 |
| 3 | 中国长城葡萄酒有限公司 | 中国长城葡萄酒有限公司 | 河北省张家口市怀来县沙城镇 | 暂无信息 | <https://www.tianyancha.com/company/334595663> | 河北 | NA | NA |
| 8 | 国家人口计生委科学技术研究所 | 国家人口计生委科学技术研究所计划生育生殖健康技术服务中心 | 北京市海淀区大慧寺路12号 | 暂无信息 | <https://www.tianyancha.com/company/3097982223> | 北京 | NA | 北京 |
| 10 | 广州海洋地质调查局 | 广州海洋地质调查局 | 广东省广州市南沙区环市大道南25号南沙科技创新中心A4栋2楼208-218房 | 暂无信息 | <https://www.tianyancha.com/company/1312458900> | 广东 | 广州市 | 广东 |
| 34 | 中国中医科学院中药研究所 | 中国中医科学院中药研究所 | 北京市东城区东直门内南小街16号 | 暂无信息 | <https://www.tianyancha.com/company/11454755> | 北京 | NA | 北京 |
| 51 | 中国农业科学院农业资源与农业区划研究所 | 中国农业科学院农业资源与农业区划研究所 | 北京市海淀区中关村南大街12号 | 010-86616891 | <https://www.tianyancha.com/company/2318856838> | 北京 | NA | 北京市 |
| 7 | 中国热带农业科学院广州实验站 | 中国热带农业科学院广州实验站 | 广东省广州市荔湾区康王中路241号 | NA | <https://www.tianyancha.com/company/2325546651> | 广东 | NA | NA |
| 148 | 中国科学院光电研究院 | 中国科学院光电研究院 | 暂无信息 | 暂无信息 | <https://www.tianyancha.com/company/22183757> | 四川 | 成都市 | 四川 |
| 144 | 中国科学院分子植物科学卓越创新中心（植物生理生态研究所） | 中国科学院分子植物科学卓越创新中心 | 上海市徐汇区枫林路300号4号楼 | 暂无信息 | <https://www.tianyancha.com/company/3453552820> | 上海 | NA | 上海 |
| 9 | 海通食品集团有限公司 | 海通食品集团有限公司 | 浙江省慈溪市古塘街道海通路528号 | 0574-5899\*\*\*\* | <https://www.tianyancha.com/company/65905634> | 浙江 | NA | 浙江省 |
| 28 | 星光农机股份有限公司 | 星光农机股份有限公司 | 浙江省湖州市和孚镇星光大街1699号 | 0572-3966138 | <https://www.tianyancha.com/company/864512390> | 浙江 | 湖州市 | 浙江省 |
| 24 | 国家康复辅具研究中心 | 国家康复辅具研究中心 | 北京经济技术开发区荣华中路1号 | 暂无信息 | <https://www.tianyancha.com/company/213045> | 北京 | NA | 北京 |
| 1 | 中国农业科学院农业基因组研究所 | 中国农业科学院农业基因组研究所 | 广东省深圳市大鹏新区鹏飞路7号B5栋 | 010- | <https://www.tianyancha.com/company/3097985016> | 广东 | NA | NA |
| 59 | 中国肉类食品综合研究中心 | 中国肉类食品综合研究中心 | 北京市丰台区洋桥70号 | 暂无信息 | <https://www.tianyancha.com/company/8533692> | 北京 | NA | 北京市 |
| 23 | 播恩集团股份有限公司 | 播恩集团股份有限公司 | 江西省赣州经济技术开发区迎宾大道中段 | 暂无信息 | <https://www.tianyancha.com/company/3125580100> | 江西 | NA | NA |
| 9 | 工业和信息化部电子第五研究所 | 工业和信息化部电子第五研究所 | 广州市天河区 | 暂无信息 | <https://www.tianyancha.com/company/1146137548> | 广东 | NA | NA |
| 47 | 中国农业大学 | 中国农业大学 | 北京市海淀区圆明园西路2号 | 13810166051 | <https://www.tianyancha.com/company/5786858> | 北京 | NA | 北京市 |
| 17 | 中国科学院东北地理与农业生态研究所 | 中国科学院东北地理与农业生态研究所 | 吉林省长春市高新技术产业开发区长东北核心区盛北大街4888号 | 暂无信息 | <https://www.tianyancha.com/company/931798166> | 吉林 | 长春市 | 吉林 |
| 247 | 中国水产科学研究院渔业机械仪器研究所 | 中国水产科学研究院渔业机械仪器研究所 | 上海市杨浦区四平街道赤峰路63号 | 暂无信息 | <https://www.tianyancha.com/company/2344962239> | 上海 | NA | 上海 |
| 38 | 中国科学院理化技术研究所 | 中国科学院理化技术研究所 | 北京市海淀区中关村东路29号 | 暂无信息 | <https://www.tianyancha.com/company/1187848> | 北京 | NA | 北京市 |
