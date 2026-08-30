---
name: techme-report-bridge
description: >-
  techme 与年度报告 Quarto 项目联动 SOP（report-tech2026 / tech-report）。
  Use when copying data between projects, syncing Pub datasets, installing
  local techme into report renv, pinning renv.lock, or when library(techme)
  fails with missing package.rds / data set not found.
---

# 报告项目联动

## 何时使用

- 在年度报告仓与 techme 之间拷贝数据
- 确定某数据集应在哪个项目维护
- 报告端引用 techme 标准数据集
- 从本地 techme 源码仓安装并钉 `renv.lock`

## 项目职责边界

| 项目 | 路径 | 职责 |
|------|------|------|
| **report-tech2026** | `D:/github/report-tech2026` | 2026 年报 Quarto 写作、章节分析与可视化（当前主写作仓） |
| **tech-report** | `D:/github/tech-report` | 历史/旁路爬取与初洗、部分公开站脚本 |
| **techme** | `D:/github/techme`（本仓库） | 标准化 `.rda` 数据集发布、年鉴/公开数据 ETL 流水线 |
| **report-tech2025** | `D:/github/report-tech2025` | 2025 年报归档仓 |

原则：**techme 是数据的 canonical 来源**；报告仓消费 `library(techme)`。

## 数据流向

```mermaid
flowchart LR
    scrape[tech-report 或本地爬取/初洗]
    copy[拷贝至 techme/data-raw]
    pipeline[techme 流水线]
    rda[data/*.rda]
    report[report-tech2026 library techme]
    scrape --> copy --> pipeline --> rda --> report
```

## 拷贝路径约定

### 爬取项目 → techme

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

### techme → report-tech2026

已发布 tag 时：

```r
renv::install("huhuaping/techme@<tag>")
library(techme)
data(RDPatentValid)
```

本地刚升版、要钉当前工作树时，走下面「本地安装并钉 renv」，不要用默认的 `renv::install("D:/github/techme")`。

审计脚本：`scripts/audit-year-coverage-2026.R`。2026 报告覆盖审计见 `report-tech2026/report/data-coverage-audit-2026.md`。

## 本地安装并钉 renv

在 `D:/github/report-tech2026` 执行。源码仓 `D:/github/techme` 常有 gitignore 的 `Meta/`（vignette 构建残留）。`renv::install(本地路径)` 会把整个源码树当成 binary 拷进 library，装出来的包没有 `Meta/package.rds`。

症状：`package 'techme' has no 'package.rds' in Meta/`；`library(techme)` → not a valid installed package；`data("PubGeneticResource")` → data set not found。`packageVersion("techme")` 仍可能读到 DESCRIPTION，不能当验收。

**禁止**

- `renv::install("D:/github/techme")`（未指定 `type = "source"`）
- `renv::record("techme")`（按 CRAN 解析本地包会失败）
- `renv::snapshot()` / `snapshot(packages = "techme")`（implicit 会把 lockfile 里其他包装成删除）

**步骤**

```r
lib <- .libPaths()[[1]]
pkg <- file.path(lib, "techme")
if ("package:techme" %in% search()) detach("package:techme", unload = TRUE)
if (dir.exists(pkg)) unlink(pkg, recursive = TRUE, force = TRUE)
# 必须 type = "source"
install.packages("D:/github/techme", lib = lib, repos = NULL, type = "source")
```

若 `unlink` 失败：先让用户关掉占用 library 的 R 会话再重装。装完后重启交互会话再 `library(techme)`。

验收（只回报版本、是否存在 `package.rds`、`dim` / 列名；不要打印数据集内容）：

```r
stopifnot(requireNamespace("techme", quietly = TRUE))
file.exists(file.path(.libPaths()[[1]], "techme", "Meta", "package.rds"))
as.character(utils::packageVersion("techme"))  # 须等于 techme/DESCRIPTION
data("PubGeneticResource", package = "techme")
```

钉版本：只改 `renv.lock` 里 `techme` 的 `Version`。`Source` 保持 `Local`，`RemoteUrl` 保持 `D:/github/techme`。

## 仅在一方维护的数据集

| 数据集 | 维护位置 | 说明 |
|--------|----------|------|
| `open-share`（科研仪器开放共享） | tech-report only | `tech-report/data-raw/public-site/most-jcs-open-share` |
| 章节专属中间分析 / AI 大模型案例表 | report-tech2026 | 不进入标准 `.rda`，稳定后再考虑入库 |

新增数据集时先确认是否纳入 techme 发布范围。

## 天眼查数据流

1. 报告侧爬取机构名单 → 输出至 techme ship 目录
2. techme `wfl.queryInstituton()` 匹配省份
3. 未匹配导出：`data-raw/data-tidy/hack-tianyan/ship/`

详见 `vignettes/articles/queryTianyancha.Rmd`。

## 同步检查清单

- [ ] 明确数据 canonical 来源（techme vs 报告仓 only）
- [ ] 拷贝路径两端目录结构一致
- [ ] techme 流水线已跑完，`data/*.rda` 含最新年份
- [ ] report-tech2026 中 `library(techme)` 能加载，且 `Meta/package.rds` 存在
- [ ] 版本与 `techme/DESCRIPTION`、`renv.lock` 的 techme `Version` 一致
- [ ] 未将报告仓中间文件误提交至 techme git

## 参考

- 公开数据 Skill：`.cursor/skills/techme-public-site-update/SKILL.md`
- 年鉴更新 Skill：`.cursor/skills/techme-yearbook-update/SKILL.md`
- 历史导入注释：`data-raw/wfl_import.R`
- 设计文档：`vignettes/articles/pkg-design.Rmd`
