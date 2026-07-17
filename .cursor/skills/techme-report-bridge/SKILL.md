---
name: techme-report-bridge
description: >-
  techme 与 tech-report 报告项目联动 SOP。Use when copying data between
  projects, syncing Pub datasets, or clarifying which project owns a dataset.
---

# tech-report 联动

## 何时使用

- 在 tech-report 与 techme 之间拷贝数据
- 确定某数据集应在哪个项目维护
- 报告端引用 techme 标准数据集

## 项目职责边界

| 项目 | 路径 | 职责 |
|------|------|------|
| **tech-report** | `D:/github/tech-report` | 报告 Quarto/Rmd 写作、部分爬取与初洗、章节分析 |
| **techme** | `D:/github/techme`（本仓库） | 标准化 `.rda` 数据集发布、年鉴/公开数据 ETL 流水线 |

原则：**techme 是数据的 canonical 来源**；tech-report 消费 `library(techme)`。

## 数据流向

```mermaid
flowchart LR
    scrape[tech-report 爬取/初洗]
    copy[拷贝至 techme/data-raw]
    pipeline[techme 流水线]
    rda[data/*.rda]
    report[tech-report library techme]
    scrape --> copy --> pipeline --> rda --> report
```

## 拷贝路径约定

### tech-report → techme

爬取/初洗完成后，拷贝至 techme 对应目录：

```
D:/github/tech-report/data-raw/public-site/{source}/xlsx/
  → D:/github/techme/data-raw/data-tidy/{source}/xlsx/

D:/github/tech-report/data-raw/public-site/{source}/xlsx/tbl-json-{Year}.rds
  → 同上或 techme 清洗脚本输入路径
```

示例（moa-seed-firm，见 `data-raw/public-site/moa-seed-firm/code-01-scrape-seed-firm.R`）：

```r
# path_to <- glue("D:/github/tech-report/data-raw/public-site/moa-seed-firm/xlsx/tbl-json-{Year}.rds")
```

### techme → tech-report

报告端安装并加载：

```r
devtools::install_github("huhuaping/techme")
library(techme)
data(RDPatentValid)
```

tech-report 的 `data-extract/`、`data-analysis/` 中历史 xlsx 路径（见 `data-raw/wfl_import.R` 注释）为 legacy 导入，新数据应直接用 `.rda`。

## 仅在一方维护的数据集

部分数据集 intentionally 不在 techme 发布：

| 数据集 | 维护位置 | 说明 |
|--------|----------|------|
| `open-share`（科研仪器开放共享） | tech-report only | `tech-report/data-raw/public-site/most-jcs-open-share` |
| 章节专属中间分析 | tech-report | 不进入标准 `.rda` |

新增数据集时先确认是否纳入 techme 发布范围。

## 天眼查数据流

1. tech-report 爬取机构名单 → 输出至 techme ship 目录
2. techme `wfl.queryInstituton()` 匹配省份
3. 未匹配导出：`data-raw/data-tidy/hack-tianyan/ship/`

详见 `vignettes/articles/queryTianyancha.Rmd`。

## 同步检查清单

- [ ] 明确数据 canonical 来源（techme vs tech-report only）
- [ ] 拷贝路径两端目录结构一致
- [ ] techme 流水线已跑完，`data/*.rda` 含最新年份
- [ ] tech-report 中 `library(techme)` 版本与本地开发一致
- [ ] 未将 tech-report 中间文件误提交至 techme git

## 参考

- 公开数据 Skill：`.cursor/skills/techme-public-site-update/SKILL.md`
- 历史导入注释：`data-raw/wfl_import.R`
- 设计文档：`vignettes/articles/pkg-design.Rmd`
