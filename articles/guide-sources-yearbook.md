# 年鉴数据来源

``` r

library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.2.1     ✔ readr     2.2.0
#> ✔ forcats   1.0.1     ✔ stringr   1.6.0
#> ✔ ggplot2   4.0.3     ✔ tibble    3.3.1
#> ✔ lubridate 1.9.5     ✔ tidyr     1.3.2
#> ✔ purrr     1.2.2     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
library(magrittr)
#> 
#> Attaching package: 'magrittr'
#> 
#> The following object is masked from 'package:purrr':
#> 
#>     set_names
#> 
#> The following object is masked from 'package:tidyr':
#> 
#>     extract
library(here)
#> here() starts at /home/runner/work/techme/techme
library(glue)
library(fs)
library(knitr)
library(techme)
library(DT)

safe_dir_tree <- function(path, ...) {
  if (!fs::dir_exists(path)) {
    cat("*目录不存在：*", path, "\n\n")
    return(invisible(NULL))
  }
  fs::dir_tree(path, ...)
}
```

## 年鉴数据

### 数据获取

- \[西农权限\]中国经济社会大数据研究平台<https://data.cnki.net/home>。中国知网推出，主要集中在统计年鉴，资料信息权威稳定。可以下载`xls`（受保护，但是可以处理）！

### 数据进度

### 数据流程

这里我们展示的是数据维护项目R包`techme`对应数据集的文件体系。本文档的渲染，依赖于R包`techme`当前的文件夹状态（如`main`或`dev`分支）。

全部的数据维护主要通过R包`techme`进行管理：

（1）例如下载《中国农村统计年鉴》xls电子版，保存本地（“课题项目文件/数据/中国农村统计年鉴”）。

（2）在R包`techme`项目下完成数据更新、核对和标准化等流程。示例如下：

- 拷贝原始数据到R包项目下对应的文件夹，重命名`xls`文件（例如`raw-2021-2022.xls`）

- 执行R包项目下的数据维护更新流程（主要代码见`techme/data-raw/rural-yearbook/wfl-rural-yearbook.R`）

- 更新编译R包，提交到github（以`dev`分支）。

## 中国统计年鉴

### 公共财政投入

#### 数据说明

1.  年鉴条目

- 表7-6 分地区一般公共预算支出(20xx年)

2.  统计目标

- 梳理指标变量，包括合计、教育、 科学技术、农林水支出。

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

dir_tar <- here::here("data-raw/nation-yearbook/part07-finance/02-public-budget/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/nation-yearbook/part07-finance/02-public-budget/
#> ├── raw-2019.xls
#> ├── raw-2020.xls
#> ├── raw-2021.xls
#> ├── raw-2021.xlsx
#> ├── raw-2022.xls
#> ├── raw-2023.xls
#> └── raw-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

dir_tar <- here::here("data-raw/data-tidy/nation-yearbook/part07-finance/02-public-budget")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/nation-yearbook/part07-finance/02-public-budget
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

数据集`PublicBudget`：

``` r

techme::PublicBudget %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

## 中国农村统计年鉴

### 农业机械`AgriMachine`

#### 数据说明

1.  年鉴条目

- 各地区主要农业机械年末拥有量

2.  统计目标

- 各地区农业机械动力

- 各地区农用拖拉机

- 各地区农用灌溉机械

- 各地区农用收获机械

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

#dir_tar <- here::here("topic/rural-yearbook")
dir_tar <- here::here("data-raw/rural-yearbook/part03-agri-produce/01-machine/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/rural-yearbook/part03-agri-produce/01-machine/
#> ├── backup.xls
#> ├── raw-2018-2019.xls
#> ├── raw-2019-2020.xls
#> ├── raw-2020-2021-01.xls
#> ├── raw-2020-2021-02.xls
#> ├── raw-2020-2021-03.xls
#> ├── raw-2020-2021-04.xls
#> ├── raw-2020-2021-05.xls
#> ├── raw-2020-2021.xlsx
#> ├── raw-2021-2022-unlocked.xlsx
#> ├── raw-2021-2022.xls
#> ├── raw-2021-2022.xlsx
#> ├── raw-2022-2023.xls
#> └── raw-2022-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

#dir_tar <- here::here("topic/rural-yearbook")
dir_tar <- here::here("data-raw/data-tidy/rural-yearbook/part03-agri-produce/01-machine/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/rural-yearbook/part03-agri-produce/01-machine/
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::AgriMachine %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

#### 注意事项

`AgriMachine`：

- 拖拉机分类重新定义：2018年，农业农村部根据工业和信息化部标准对拖拉机的分类重新定义，把大中型拖拉机和小型拖拉机的分类标准由发动机功率14.7千瓦改为22.1千瓦，大中型拖拉机配套农具口径改为“与58.8千瓦及以上拖拉机配套”。同时，取消小型拖拉机配套农具和农用排灌机相关指标。

- 拖拉机配套农具统计口径变更：2018年起大中型拖拉机配套农具统计口径变更为“与58.8千瓦及以上拖拉机配套”，统计口径与往年不可比。

- 谷物联合收割机统计口径变更：2022年，农业农村部对谷物联合收割机口径进行调整，只包括稻麦联合收割机，不再含玉米联合收割机。

### 农用化肥`AgriFertilizer`

#### 数据说明

（1）统计目标

- 各地区农用化肥

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

#dir_tar <- here::here("topic/rural-yearbook")
dir_tar <- here::here("data-raw/rural-yearbook/part03-agri-produce/02-fertilizer/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/rural-yearbook/part03-agri-produce/02-fertilizer/
#> ├── raw-2018-2019-edited.xlsx
#> ├── raw-2018-2019-unlocked.xlsx
#> ├── raw-2018-2019.xls
#> ├── raw-2018-2019.xlsx
#> ├── raw-2019-2020-edited.xlsx
#> ├── raw-2019-2020-unlocked.xlsx
#> ├── raw-2019-2020.xls
#> ├── raw-2019-2020.xlsx
#> ├── raw-2020-2021-01.xls
#> ├── raw-2020-2021-02.xls
#> ├── raw-2020-2021.xlsx
#> ├── raw-2021-2022-edited.xlsx
#> ├── raw-2021-2022-unlocked.xlsx
#> ├── raw-2021-2022.xls
#> ├── raw-2021-2022.xlsx
#> ├── raw-2022-2023.xls
#> └── raw-2022-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

#dir_tar <- here::here("topic/rural-yearbook")
dir_tar <- here::here("data-raw/data-tidy/rural-yearbook/part03-agri-produce/02-fertilizer")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/rural-yearbook/part03-agri-produce/02-fertilizer
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::AgriFertilizer %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

#### 注意事项

`AgriFertilizer`计量单位发生改变：

- 2022年开始，农用薄膜使用量计量单位变更为“万吨”（之前是“吨”）

### 农用薄膜`AgriPlastic`

#### 数据说明

（1）统计目标

- 各地区农用薄膜

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

dir_tar <- here::here("data-raw/rural-yearbook/part03-agri-produce/03-plastic/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/rural-yearbook/part03-agri-produce/03-plastic/
#> ├── raw-2018-2019.xls
#> ├── raw-2019-2020.xls
#> ├── raw-2020-2021.xls
#> ├── raw-2020-2021.xlsx
#> ├── raw-2021-2022.xls
#> ├── raw-2022-2023.xls
#> └── raw-2022-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

dir_tar <- here::here("data-raw/data-tidy/rural-yearbook/part03-agri-produce/03-plastic/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/rural-yearbook/part03-agri-produce/03-plastic/
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::AgriPlastic %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

#### 注意事项

`AgriPlastic`计量单位发生改变：

- 2022年开始，农用薄膜使用量、地膜使用量计量单位变更为“万吨”（之前是“吨”）；

- 2022年开始，地膜覆盖面积计量单位变更为“千公顷”（之前是“公顷”）

### 农药柴油`AgriPesticide`

#### 数据说明

（1）统计目标

- 各地区农用农药柴油

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

#dir_tar <- here::here("topic/rural-yearbook")
dir_tar <- here::here("data-raw/rural-yearbook/part03-agri-produce/04-pesticide/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/rural-yearbook/part03-agri-produce/04-pesticide/
#> ├── raw-2018-2019.xls
#> ├── raw-2019-2020.xls
#> ├── raw-2020-2021.xls
#> ├── raw-2020-2021.xlsx
#> ├── raw-2021-2022.xls
#> ├── raw-2022-2023.xls
#> └── raw-2022-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

#dir_tar <- here::here("topic/rural-yearbook")
dir_tar <- here::here("data-raw/data-tidy/rural-yearbook/part03-agri-produce/04-pesticide/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/rural-yearbook/part03-agri-produce/04-pesticide/
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::AgriPesticide %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

#### 注意事项

`AgriPesticide`计量单位发生改变：

- 2022年开始，农药使用量计量单位变更为“万吨”（之前是“吨”）

## 中国科技统计年鉴

### RD投入经费和强度`RDIntense`

数据集`RDIntense`：实际上采用了公开查询进行数据处理。具体参看[公共数据来源](https://huhuaping.github.io/techme/articles/guide-sources-public-site.qmd#sec-nbs-RD)

（1）公开查询：国家统计局<https://www.stats.gov.cn/>（全国科技经费投入统计公报），包括经费（亿元）和强度。

（2）《中国科技统计年鉴》part02-firm（企业）各地区研究与试验发展(R&D)经费内部支出（万元）、“各地区研究与试验发展(R&D)经费投入强度”

#### 数据集展示

``` r

techme::RDIntense %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

### RD活动支出`RDActivity`

#### 数据说明

（1）统计目标

- 分析RD支出的类型：应用研究、基础研究、试验发展

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

#dir_tar <- here::here("topic/rural-yearbook")
dir_tar <- here::here("data-raw/tech-yearbook/part01-over/03-spend-inner/01-activity/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/tech-yearbook/part01-over/03-spend-inner/01-activity/
#> ├── raw-2018.xls
#> ├── raw-2019.xls
#> ├── raw-2020-soshu.xls
#> ├── raw-2020.xls
#> ├── raw-2020.xlsx
#> ├── raw-2021.xls
#> ├── raw-2021.xlsx
#> ├── raw-2022.xls
#> ├── raw-2023.xls
#> └── raw-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

#dir_tar <- here::here("topic/rural-yearbook")
dir_tar <- here::here("data-raw/data-tidy/tech-yearbook/part01-over/03-spend-inner/01-activity/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/tech-yearbook/part01-over/03-spend-inner/01-activity/
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::RDActivity %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

### RD人员全时当量`RDLaborHour`

（1）统计目标

- 各地区RD人员全时当量（人年）

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

dir_tar <- here::here("data-raw/tech-yearbook/part01-over/01-labor-hour/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/tech-yearbook/part01-over/01-labor-hour/
#> ├── raw-2010.xls
#> ├── raw-2010.xlsx
#> ├── raw-2011.xls
#> ├── raw-2011.xlsx
#> ├── raw-2012.xls
#> ├── raw-2012.xlsx
#> ├── raw-2013.xls
#> ├── raw-2013.xlsx
#> ├── raw-2014.xls
#> ├── raw-2014.xlsx
#> ├── raw-2015.xls
#> ├── raw-2015.xlsx
#> ├── raw-2016.xls
#> ├── raw-2016.xlsx
#> ├── raw-2017.xls
#> ├── raw-2017.xlsx
#> ├── raw-2018.xls
#> ├── raw-2018.xlsx
#> ├── raw-2019.xls
#> ├── raw-2019.xlsx
#> ├── raw-2020.xls
#> ├── raw-2020.xlsx
#> ├── raw-2021.xls
#> ├── raw-2021.xlsx
#> ├── raw-2022.xls
#> ├── raw-2022.xlsx
#> ├── raw-2023.xls
#> └── raw-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

dir_tar <- here::here("data-raw/data-tidy/tech-yearbook/part01-over/01-labor-hour/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/tech-yearbook/part01-over/01-labor-hour/
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::RDLaborHour %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

### RD资金来源`RDSource`

#### 数据说明

（1）统计目标

- 各地区按资金来源分研究与试验发展(R&D)经费内部支出

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

dir_tar <- here::here("data-raw/tech-yearbook/part01-over/03-spend-inner/02-source")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/tech-yearbook/part01-over/03-spend-inner/02-source
#> ├── raw-2010.xls
#> ├── raw-2010.xlsx
#> ├── raw-2011.xls
#> ├── raw-2011.xlsx
#> ├── raw-2012.xls
#> ├── raw-2012.xlsx
#> ├── raw-2013.xls
#> ├── raw-2013.xlsx
#> ├── raw-2014.xls
#> ├── raw-2014.xlsx
#> ├── raw-2015.xls
#> ├── raw-2015.xlsx
#> ├── raw-2016.xls
#> ├── raw-2016.xlsx
#> ├── raw-2017.xls
#> ├── raw-2017.xlsx
#> ├── raw-2018.xls
#> ├── raw-2018.xlsx
#> ├── raw-2019.xls
#> ├── raw-2019.xlsx
#> ├── raw-2020.xls
#> ├── raw-2020.xlsx
#> ├── raw-2021.xls
#> ├── raw-2021.xlsx
#> ├── raw-2022.xls
#> ├── raw-2022.xlsx
#> ├── raw-2023.xls
#> └── raw-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

dir_tar <- here::here("data-raw/data-tidy/tech-yearbook/part01-over/03-spend-inner/02-source")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/tech-yearbook/part01-over/03-spend-inner/02-source
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::RDSource %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

### 专利申请`RDPatentAccept`

#### 数据说明

（1）统计目标

- 国内三种专利申请受理数按地区分布

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

dir_tar <- here::here("data-raw/tech-yearbook/part08-output/01-patent/01-accept/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/tech-yearbook/part08-output/01-patent/01-accept/
#> ├── raw-2010.xls
#> ├── raw-2010.xlsx
#> ├── raw-2011.xls
#> ├── raw-2011.xlsx
#> ├── raw-2012.xls
#> ├── raw-2012.xlsx
#> ├── raw-2013.xls
#> ├── raw-2013.xlsx
#> ├── raw-2014.xls
#> ├── raw-2014.xlsx
#> ├── raw-2015.xls
#> ├── raw-2015.xlsx
#> ├── raw-2016.xls
#> ├── raw-2016.xlsx
#> ├── raw-2017.xls
#> ├── raw-2017.xlsx
#> ├── raw-2018.xls
#> ├── raw-2018.xlsx
#> ├── raw-2019.xls
#> ├── raw-2019.xlsx
#> ├── raw-2020.xls
#> ├── raw-2020.xlsx
#> ├── raw-2021.xls
#> ├── raw-2021.xlsx
#> ├── raw-2022.xls
#> ├── raw-2022.xlsx
#> ├── raw-2023.xls
#> └── raw-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

dir_tar <- here::here("data-raw/data-tidy/tech-yearbook/part08-output/01-patent/01-accept/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/tech-yearbook/part08-output/01-patent/01-accept/
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::RDPatentAccept %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

### 专利授权`RDPatentAuthority`

#### 数据说明

（1）统计目标

- 国内三种专利申请授权数按地区分布

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

dir_tar <- here::here("data-raw/tech-yearbook/part08-output/01-patent/02-authority/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/tech-yearbook/part08-output/01-patent/02-authority/
#> ├── raw-2010.xls
#> ├── raw-2010.xlsx
#> ├── raw-2011.xls
#> ├── raw-2011.xlsx
#> ├── raw-2012.xls
#> ├── raw-2012.xlsx
#> ├── raw-2013.xls
#> ├── raw-2013.xlsx
#> ├── raw-2014.xls
#> ├── raw-2014.xlsx
#> ├── raw-2015.xls
#> ├── raw-2015.xlsx
#> ├── raw-2016.xls
#> ├── raw-2016.xlsx
#> ├── raw-2017.xls
#> ├── raw-2017.xlsx
#> ├── raw-2018.xls
#> ├── raw-2018.xlsx
#> ├── raw-2019.xls
#> ├── raw-2019.xlsx
#> ├── raw-2020.xls
#> ├── raw-2020.xlsx
#> ├── raw-2021.xls
#> ├── raw-2021.xlsx
#> ├── raw-2022.xls
#> ├── raw-2022.xlsx
#> ├── raw-2023.xls
#> └── raw-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

dir_tar <- here::here("data-raw/data-tidy/tech-yearbook/part08-output/01-patent/02-authority/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/tech-yearbook/part08-output/01-patent/02-authority/
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::RDPatentAuthority %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

### 专利有效`RDPatentValid`

#### 数据说明

（1）统计目标

- 国内三种专利有效数按地区分布

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

dir_tar <- here::here("data-raw/tech-yearbook/part08-output/01-patent/03-valid/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/tech-yearbook/part08-output/01-patent/03-valid/
#> ├── raw-2010.xls
#> ├── raw-2010.xlsx
#> ├── raw-2011.xls
#> ├── raw-2011.xlsx
#> ├── raw-2012.xls
#> ├── raw-2012.xlsx
#> ├── raw-2013.xls
#> ├── raw-2013.xlsx
#> ├── raw-2014.xls
#> ├── raw-2014.xlsx
#> ├── raw-2015.xls
#> ├── raw-2015.xlsx
#> ├── raw-2016.xls
#> ├── raw-2016.xlsx
#> ├── raw-2017.xls
#> ├── raw-2017.xlsx
#> ├── raw-2018.xls
#> ├── raw-2018.xlsx
#> ├── raw-2019.xls
#> ├── raw-2019.xlsx
#> ├── raw-2020.xls
#> ├── raw-2020.xlsx
#> ├── raw-2021.xls
#> ├── raw-2021.xlsx
#> ├── raw-2022.xls
#> ├── raw-2022.xlsx
#> ├── raw-2023.xls
#> └── raw-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

dir_tar <- here::here("data-raw/data-tidy/tech-yearbook/part08-output/01-patent/03-valid/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/tech-yearbook/part08-output/01-patent/03-valid/
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::RDPatentValid %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

### 论文国际引用`RDPaperInternational`

#### 数据说明

（1）统计目标

- 国外主要检索工具收录我国科技论文按地区分布

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

dir_tar <- here::here("data-raw/tech-yearbook/part08-output/05-paper-international/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/tech-yearbook/part08-output/05-paper-international/
#> ├── raw-2010.xls
#> ├── raw-2010.xlsx
#> ├── raw-2011.xls
#> ├── raw-2011.xlsx
#> ├── raw-2012.xls
#> ├── raw-2012.xlsx
#> ├── raw-2013.xls
#> ├── raw-2013.xlsx
#> ├── raw-2014.xls
#> ├── raw-2014.xlsx
#> ├── raw-2015.xls
#> ├── raw-2015.xlsx
#> ├── raw-2016.xls
#> ├── raw-2016.xlsx
#> ├── raw-2017.xls
#> ├── raw-2017.xlsx
#> ├── raw-2018.xls
#> ├── raw-2018.xlsx
#> ├── raw-2019.xls
#> ├── raw-2019.xlsx
#> ├── raw-2020.xls
#> ├── raw-2020.xlsx
#> ├── raw-2021.xls
#> ├── raw-2021.xlsx
#> ├── raw-2022.xls
#> └── raw-2022.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

dir_tar <- here::here("data-raw/data-tidy/tech-yearbook/part08-output/05-paper-international/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/tech-yearbook/part08-output/05-paper-international/
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> └── 2022.xlsx
```

#### 数据集展示

``` r

techme::RDPaperInternational %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

### 植物新品种`RDPlantVariety`

#### 数据说明

（1）统计目标

- 农业植物新品种权申请和授权数量（按省份地区分布）

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

dir_tar <- here::here("data-raw/tech-yearbook/part08-output/06-plant-variety/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/tech-yearbook/part08-output/06-plant-variety/
#> ├── raw-2009.xls
#> ├── raw-2009.xlsx
#> ├── raw-2010.xls
#> ├── raw-2010.xlsx
#> ├── raw-2011.xls
#> ├── raw-2011.xlsx
#> ├── raw-2012.xls
#> ├── raw-2012.xlsx
#> ├── raw-2013.xls
#> ├── raw-2013.xlsx
#> ├── raw-2014.xls
#> ├── raw-2014.xlsx
#> ├── raw-2015.xls
#> ├── raw-2015.xlsx
#> ├── raw-2016.xls
#> ├── raw-2016.xlsx
#> ├── raw-2017.xls
#> ├── raw-2017.xlsx
#> ├── raw-2018.xls
#> ├── raw-2018.xlsx
#> ├── raw-2020.xls
#> ├── raw-2020.xlsx
#> ├── raw-2021.xls
#> ├── raw-2021.xlsx
#> ├── raw-2022.xls
#> ├── raw-2022.xlsx
#> ├── raw-2023.xls
#> └── raw-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

dir_tar <- here::here("data-raw/data-tidy/tech-yearbook/part08-output/06-plant-variety/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/tech-yearbook/part08-output/06-plant-variety/
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::RDPlantVariety %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

### 国家高新技术企业`IndustryOperation`

#### 数据说明

（1）统计目标

- 梳理了各地区规模以上高新技术企业数量。

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

dir_tar <- here::here("data-raw/tech-yearbook/part05-industry/01-operation/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/tech-yearbook/part05-industry/01-operation/
#> ├── raw-2010.xls
#> ├── raw-2010.xlsx
#> ├── raw-2011.xls
#> ├── raw-2011.xlsx
#> ├── raw-2012.xls
#> ├── raw-2012.xlsx
#> ├── raw-2013.xls
#> ├── raw-2013.xlsx
#> ├── raw-2014.xls
#> ├── raw-2014.xlsx
#> ├── raw-2015.xls
#> ├── raw-2016.xls
#> ├── raw-2018.xls
#> ├── raw-2019.xls
#> ├── raw-2020-edited.xlsx
#> ├── raw-2020-soshu.xls
#> ├── raw-2020.xls
#> ├── raw-2021.xls
#> ├── raw-2021.xlsx
#> ├── raw-2022.xls
#> ├── raw-2022.xlsx
#> ├── raw-2023.xls
#> └── raw-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

dir_tar <- here::here("data-raw/data-tidy/tech-yearbook/part05-industry/01-operation/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/tech-yearbook/part05-industry/01-operation/
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::IndustryOperation %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

### 技术市场`MarketPull`

#### 数据说明

（1）统计目标

- 梳理各地区技术输入的项目数量和金额

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

dir_tar <- here::here("data-raw/tech-yearbook/part08-output/03-teckmarket-pull/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/tech-yearbook/part08-output/03-teckmarket-pull/
#> ├── raw-type-amount-2019.xls
#> ├── raw-type-amount-2020-edited.xlsx
#> ├── raw-type-amount-2020-soshu.xls
#> ├── raw-type-amount-2020.xls
#> ├── raw-type-amount-2021.xls
#> ├── raw-type-amount-2021.xlsx
#> ├── raw-type-amount-2022.xls
#> ├── raw-type-amount-2023.xls
#> ├── raw-type-amount-2023.xlsx
#> ├── raw-type-funds-2019.xls
#> ├── raw-type-funds-2020-edited.xlsx
#> ├── raw-type-funds-2020-soshu.xls
#> ├── raw-type-funds-2020.xls
#> ├── raw-type-funds-2021.xls
#> ├── raw-type-funds-2021.xlsx
#> ├── raw-type-funds-2022.xls
#> ├── raw-type-funds-2023.xls
#> └── raw-type-funds-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

dir_tar <- here::here("data-raw/data-tidy/tech-yearbook/part08-output/03-teckmarket-pull/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/tech-yearbook/part08-output/03-teckmarket-pull/
#> ├── amount-2000.xlsx
#> ├── amount-2005.xlsx
#> ├── amount-2010.xlsx
#> ├── amount-2012.xlsx
#> ├── amount-2013.xlsx
#> ├── amount-2014.xlsx
#> ├── amount-2015.xlsx
#> ├── amount-2016.xlsx
#> ├── amount-2017.xlsx
#> ├── amount-2018.xlsx
#> ├── amount-2019.xlsx
#> ├── amount-2020.xlsx
#> ├── amount-2021.xlsx
#> ├── amount-2022.xlsx
#> ├── amount-2023.xlsx
#> ├── funds-2000.xlsx
#> ├── funds-2005.xlsx
#> ├── funds-2010.xlsx
#> ├── funds-2012.xlsx
#> ├── funds-2013.xlsx
#> ├── funds-2014.xlsx
#> ├── funds-2015.xlsx
#> ├── funds-2016.xlsx
#> ├── funds-2017.xlsx
#> ├── funds-2018.xlsx
#> ├── funds-2019.xlsx
#> ├── funds-2020.xlsx
#> ├── funds-2021.xlsx
#> ├── funds-2022.xlsx
#> └── funds-2023.xlsx
```

#### 数据集展示

``` r

techme::MarketPull %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

### 技术市场`MarketPush`

#### 数据说明

（1）统计目标

- 梳理各地区技术输出的项目数量和金额

#### 初始数据文件

初始数据文件（年鉴电子版，xls进行了重命名）

``` r

dir_tar <- here::here("data-raw/tech-yearbook/part08-output/04-teckmarket-push/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/tech-yearbook/part08-output/04-teckmarket-push/
#> ├── raw-type-amount-2019.xls
#> ├── raw-type-amount-2020-edited.xlsx
#> ├── raw-type-amount-2020-soshu.xls
#> ├── raw-type-amount-2020.xls
#> ├── raw-type-amount-2021.xls
#> ├── raw-type-amount-2021.xlsx
#> ├── raw-type-amount-2022.xls
#> ├── raw-type-amount-2023.xls
#> ├── raw-type-amount-2023.xlsx
#> ├── raw-type-funds-2019.xls
#> ├── raw-type-funds-2020-edited.xlsx
#> ├── raw-type-funds-2020-soshu.xls
#> ├── raw-type-funds-2020.xls
#> ├── raw-type-funds-2021.xls
#> ├── raw-type-funds-2021.xlsx
#> ├── raw-type-funds-2022.xls
#> ├── raw-type-funds-2023.xls
#> └── raw-type-funds-2023.xlsx
```

#### 清洗后数据文件

清洗后数据文件（标准化xlsx整理表格）

``` r

dir_tar <- here::here("data-raw/data-tidy/tech-yearbook/part08-output/04-teckmarket-push/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/tech-yearbook/part08-output/04-teckmarket-push/
#> ├── amount-2000.xlsx
#> ├── amount-2005.xlsx
#> ├── amount-2010.xlsx
#> ├── amount-2012.xlsx
#> ├── amount-2013.xlsx
#> ├── amount-2014.xlsx
#> ├── amount-2015.xlsx
#> ├── amount-2016.xlsx
#> ├── amount-2017.xlsx
#> ├── amount-2018.xlsx
#> ├── amount-2019.xlsx
#> ├── amount-2020.xlsx
#> ├── amount-2021.xlsx
#> ├── amount-2022.xlsx
#> ├── amount-2023.xlsx
#> ├── funds-2000.xlsx
#> ├── funds-2005.xlsx
#> ├── funds-2010.xlsx
#> ├── funds-2012.xlsx
#> ├── funds-2013.xlsx
#> ├── funds-2014.xlsx
#> ├── funds-2015.xlsx
#> ├── funds-2016.xlsx
#> ├── funds-2017.xlsx
#> ├── funds-2018.xlsx
#> ├── funds-2019.xlsx
#> ├── funds-2020.xlsx
#> ├── funds-2021.xlsx
#> ├── funds-2022.xlsx
#> └── funds-2023.xlsx
```

#### 数据集展示

``` r

techme::MarketPush %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```

### 高技术产业贸易

数据集`IndustryTrade`：梳理了各地区高新技术产业贸易情况。

``` r

data("IndustryTrade",package = "techme")
head(IndustryTrade)
#>   province year chn_block4  value    units   variables
#> 1     全国 2018 出口贸易额 743044 百万美元 v4_cy_my_ck
#> 2     北京 2018 出口贸易额  15031 百万美元 v4_cy_my_ck
#> 3     天津 2018 出口贸易额  15808 百万美元 v4_cy_my_ck
#> 4     河北 2018 出口贸易额   2855 百万美元 v4_cy_my_ck
#> 5     山西 2018 出口贸易额   7544 百万美元 v4_cy_my_ck
#> 6   内蒙古 2018 出口贸易额    900 百万美元 v4_cy_my_ck
```

### 高技术产业研发

数据集`IndustryRD`：梳理了各地区高技术产业研发机构数量。

``` r

data("IndustryRD",package = "techme")
head(IndustryRD)
#>   province year       chn_block4     value units        variables
#> 1     全国 2023       研发机构数     25821    个 v4_cy_RDhd_yfjgs
#> 2     全国 2023 人员折合全时当量   1397796  人年  v4_cy_RDhd_qsdl
#> 3     全国 2023     经费内部支出  69602196  万元  v4_cy_RDhd_nbzc
#> 4     全国 2023       开发项目数    281742    项   v4_cy_xcp_kfxm
#> 5     全国 2023     开发经费支出  90228012  万元   v4_cy_xcp_kfjf
#> 6     全国 2023         销售收入 858901500  万元   v4_cy_xcp_xssr
```

#### 注意事项

（1）统计口径变迁

- 中国科技统计年鉴/高新技术产业研发情况RDattention:
  。2020年及以后，没有“项目数”和“项目经费”！

- 统计口径与中文变量标准对应关系

``` r

tbl_pattern <- tibble(
 ptn = c("新产品开发项目数","新产品开发经费支出",
      "新产品销售收入","有效发明专利数",
      "引进境外技术经费支出", "引进境外技术消化吸收经费支出"),
 rpl = c("开发项目数","开发经费支出",
      "销售收入","有效专利数",
      "技术引进经费支出", "消化吸收经费支出")
  ) %>%
  add_column(case = "IndustryRD", .before = "ptn")

tbl_pattern
#> # A tibble: 6 × 3
#>   case       ptn                          rpl             
#>   <chr>      <chr>                        <chr>           
#> 1 IndustryRD 新产品开发项目数             开发项目数      
#> 2 IndustryRD 新产品开发经费支出           开发经费支出    
#> 3 IndustryRD 新产品销售收入               销售收入        
#> 4 IndustryRD 有效发明专利数               有效专利数      
#> 5 IndustryRD 引进境外技术经费支出         技术引进经费支出
#> 6 IndustryRD 引进境外技术消化吸收经费支出 消化吸收经费支出
```

## 中国农业机械工业年鉴

### 农业机械化服务`MachineService`

#### 数据说明

（1）统计目标

- 各省区农业机械化服务组织和人员情况
- 各省区农业机械化服务投入产出情况

（2）统计口径

- 2023年各地区农业机械化服务组织人员及投入产出情况

- 2016年各地区农业机械化服务组织及人员情况

（3）统计变量表1：服务组织和人员（2010-2013年，三类表分立；2014-2017年，表2与表3合并，2018-2023三类表合并）

- 农机化作业服务组织：年末机构数、年末人数
- （子项）农业专业合作社：年末机构数、年末人数
- 农机户：年末机构数、年末人数
- （子项）农机化作业服务专业户：年末机构数、年末人数
- 农机化中介服务组织：年末机构数、年末人数（2018年以后未统计该变量，设置为缺失变量）
- 乡村农机从业人员：年末人数
- 农机维修厂及维修点：年末机构数、年末人数

（4）统计变量表2：投入变量（2010-2013年，三类表分立；2014-2017年，表2与表3合并，2018-2023三类表合并）

- 4.1 财政资金投入
- （子项）4.1.1 科研投入
- （子项）4.1.2 推广投入
- 4.2 基本建设投入
- 4.3 农业机械购置投入

（5）统计变量表3：产出变量（2010-2013年，三类表分立；2014-2017年，表2与表3合并，2018-2023三类表合并）

- 农机服务收入

#### 初始数据文件

``` r

dir_tar <- here::here("data-raw/agrimachine-yearbook/machine-service/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/agrimachine-yearbook/machine-service/
#> ├── raw-2010-1.xls
#> ├── raw-2010-1.xlsx
#> ├── raw-2010-2.xls
#> ├── raw-2010-2.xlsx
#> ├── raw-2010-3.xls
#> ├── raw-2010-3.xlsx
#> ├── raw-2010.xlsx
#> ├── raw-2011-1.xls
#> ├── raw-2011-1.xlsx
#> ├── raw-2011-2.xls
#> ├── raw-2011-2.xlsx
#> ├── raw-2011-3.xls
#> ├── raw-2011-3.xlsx
#> ├── raw-2011.xlsx
#> ├── raw-2012-1.xls
#> ├── raw-2012-1.xlsx
#> ├── raw-2012-2.xls
#> ├── raw-2012-2.xlsx
#> ├── raw-2012-3.xls
#> ├── raw-2012-3.xlsx
#> ├── raw-2012.xlsx
#> ├── raw-2013-1.xls
#> ├── raw-2013-1.xlsx
#> ├── raw-2013-2.xls
#> ├── raw-2013-2.xlsx
#> ├── raw-2013-3.xls
#> ├── raw-2013-3.xlsx
#> ├── raw-2013.xlsx
#> ├── raw-2014-1.xls
#> ├── raw-2014-1.xlsx
#> ├── raw-2014-2.xls
#> ├── raw-2014-2.xlsx
#> ├── raw-2014.xlsx
#> ├── raw-2015-1.xls
#> ├── raw-2015-1.xlsx
#> ├── raw-2015-2.xls
#> ├── raw-2015-2.xlsx
#> ├── raw-2015.xlsx
#> ├── raw-2016-1.xls
#> ├── raw-2016-1.xlsx
#> ├── raw-2016-2.xls
#> ├── raw-2016-2.xlsx
#> ├── raw-2016.xlsx
#> ├── raw-2017-1.xls
#> ├── raw-2017-1.xlsx
#> ├── raw-2017-2.xls
#> ├── raw-2017-2.xlsx
#> ├── raw-2017.xlsx
#> ├── raw-2018.xls
#> ├── raw-2018.xlsx
#> ├── raw-2019.xls
#> ├── raw-2019.xlsx
#> ├── raw-2020.xls
#> ├── raw-2020.xlsx
#> ├── raw-2021.xls
#> ├── raw-2021.xlsx
#> ├── raw-2022.xls
#> ├── raw-2022.xlsx
#> ├── raw-2023.xls
#> └── raw-2023.xlsx
```

#### 清洗后数据文件

``` r

dir_tar <- here::here("data-raw/data-tidy/agrimachine-yearbook/machine-service/")
safe_dir_tree(dir_tar)
#> /home/runner/work/techme/techme/data-raw/data-tidy/agrimachine-yearbook/machine-service/
#> ├── 2010.xlsx
#> ├── 2011.xlsx
#> ├── 2012.xlsx
#> ├── 2013.xlsx
#> ├── 2014.xlsx
#> ├── 2015.xlsx
#> ├── 2016.xlsx
#> ├── 2017.xlsx
#> ├── 2018.xlsx
#> ├── 2019.xlsx
#> ├── 2020.xlsx
#> ├── 2021.xlsx
#> ├── 2022.xlsx
#> └── 2023.xlsx
```

#### 数据集展示

``` r

techme::MachineService %>%
  head(100) %>%
  DT::datatable(
    rownames = FALSE,
    options = list(
      dom = "ftip",
      pageLength = 10,
      scrollX = TRUE
    )
  )
```
