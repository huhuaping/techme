---
name: techme-public-site-update
description: >-
  公开网站数据抓取与更新 SOP。Use when scraping MOA/MOST/MOE public data,
  updating Pub* datasets, or working in data-raw/public-site or update-public.
---

# 公开网站数据抓取与更新

## 何时使用

- 更新农业农村部（MOA）、科技部（MOST）、教育部（MOE）等公开数据
- 新增或维护 `Pub*` 前缀数据集
- 运行机构省份匹配（`wfl.queryInstituton`）

## 前置条件

```r
renv::restore()
devtools::load_all()
```

## 目录结构

```
data-raw/public-site/{source-name}/
├── code-*.R              # 爬取/清洗脚本
├── guide-scrape-*.qmd    # 操作指南（部分数据源）
└── scrape-*.Rmd          # 交互式爬取文档

data-raw/data-tidy/{source-name}-web/
├── html/                 # 原始 html
└── xlsx/                 # 清洗后 xlsx
```

## SOP

### Step 1 — 定位现有脚本

在 `data-raw/public-site/` 下按数据源找模板：

| 数据源 | 示例目录 | 数据集 |
|--------|----------|--------|
| 农业农村部 | `moa-seed-firm/`, `moa-firm-leader/` | `PubSeedFirm`, `PubFirmLeader` |
| 科技部 | `most-convergence/`, `most-jcs-open-share/` | `PubConvergencePark` |
| 教育部 | 各子目录 | 视具体数据源 |

优先阅读目录下的 `guide-scrape-*.qmd` 或 `scrape-*.Rmd`。

### Step 2 — 爬取/导入

- 静态页面：R 脚本 + `rvest` 或手工下载
- 动态页面：Docker Selenium（见下方）
- 输出 html 至 `data-raw/data-tidy/xxx-web/html/`

### Step 3 — 清洗为 xlsx

编写或修改 `code-*.R`，输出至 `data-raw/data-tidy/xxx-web/xlsx/`。

### Step 4 — 机构省份匹配

```r
dt_matched <- wfl.queryInstituton(dt)
wfl.write2ship(dt_matched, date = "2024-01-15")
```

- `wfl.queryInstituton()`：机构名 → 省份（依赖 `queryTianyan` 参考数据）
- `wfl.write2ship()`：未匹配机构导出至 `data-raw/data-tidy/hack-tianyan/ship/`

### Step 5 — 发布数据集

```r
usethis::use_data(PubSeedFirm, overwrite = TRUE)
devtools::document()
```

更新 `_pkgdown.yml` 中 Public sources 分组。

## Docker Selenium（Windows PowerShell）

用于天眼查等动态页面：

```powershell
docker run --name chrome -v /dev/shm:/dev/shm -d -p 4445:4444 -p 5901:5900 selenium/standalone-chrome-debug:latest
```

- WebDriver 端口：`4445`
- VNC 端口：`5901`（可视化调试）

详见 `vignettes/articles/queryTianyancha.Rmd` 与 `data-raw/hack_tianyan-new.R`。

## 与 tech-report 数据拷贝

部分数据源先在 tech-report 爬取，再拷贝至 techme：

```
D:/github/tech-report/data-raw/public-site/{source}/xlsx/
  → D:/github/techme/data-raw/data-tidy/{source}/xlsx/
```

示例（moa-seed-firm）：

```
D:/github/tech-report/data-raw/public-site/moa-seed-firm/xlsx/tbl-json-{Year}.rds
```

## 检查清单

- [ ] 数据源 URL 与年份正确
- [ ] html/xlsx 存放路径符合规范
- [ ] 机构省份匹配率可接受（未匹配已导出 ship 文件）
- [ ] `Pub*` 数据集 roxygen 文档完整
- [ ] `_pkgdown.yml` 已更新
- [ ] 敏感机构信息未泄露至对话或公开提交

## 参考

- 公开数据工作流：`R/workflow_pub.R`
- 天眼查流程：`vignettes/articles/queryTianyancha.Rmd`
- tech-report 联动：`.cursor/skills/techme-report-bridge/SKILL.md`
