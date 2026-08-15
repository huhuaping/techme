---
name: techme-pkgdown-docs
description: >-
  pkgdown 文档站与 vignette 维护 SOP。Use when updating roxygen docs, building
  pkgdown site, or editing vignettes and _pkgdown.yml.
---

# 文档与 pkgdown 维护

## 何时使用

- 补全或修正 roxygen 文档
- 构建/预览 pkgdown 文档站
- 更新 vignette 或 `_pkgdown.yml` 分组
- CI 文档部署失败排查

## 文档体系

| 类型 | 位置 | 生成方式 |
|------|------|----------|
| 函数/数据集帮助 | `man/*.Rd` | `devtools::document()` |
| 设计 / 来源指南 | `vignettes/articles/`（`pkg-design`、`guide-*`） | knitr 渲染，pkgdown Articles |
| 工程 FAQ | `vignettes/articles/faq-*.Rmd` | 固定结构，见下节 |
| 数据集概览 | `vignettes/my-vignette.Rmd` | vignette 构建 |
| 静态站点 | `docs/` | `pkgdown::build_site()` |

站点 URL：https://huhuaping.github.io/techme/

## SOP

### Step 1 — 补全 roxygen

规范（见 `.cursor/rules/r-package.mdc` 与 `.cursor/rules/datasets.mdc`）：

- 中文或中英双语 `@description`
- 数据集用 `@format` + `\describe{}` 列描述
- 示例用 `\dontrun{}` 包裹依赖本地路径的代码
- 修改后：`devtools::document()`

### Step 2 — 更新 _pkgdown.yml

编辑 `_pkgdown.yml` 的 `reference` 节，按数据来源分组：

- Data Subset from the Agriculture Yearbook
- Data Subset from the Technology Yearbook
- Data Subset from the public sources
- Data Subset for the special chapter
- Some elementary dataset
- Functions for raw data handling

新增数据集/函数时加入对应 `contents` 列表。

### Step 3 — 本地构建预览

```r
pkgdown::build_site()
# 预览：servr::httw("docs") 或直接打开 docs/index.html
```

### Step 4 — CI 部署

`.github/workflows/pkgdown.yaml` 在 push/PR/release 时自动：

1. setup R + Quarto + Pandoc
2. `pkgdown::build_site_github_pages()`
3. 部署到 `gh-pages` 分支（非 PR 时）

排查失败：检查 roxygen 语法错误、缺失依赖（`Config/Needs/website`）。

### Step 5 — vignette 文章

`vignettes/articles/` 在 `.Rbuildignore` 中，**不打进源码包**，但 `pkgdown::build_site()` 仍会渲染并挂到站点 Articles。

两类文章：

| 前缀 | 用途 | 导航分组（`_pkgdown.yml`） |
|------|------|---------------------------|
| `pkg-design`、`guide-*`、既有工作流文 | 设计与数据来源 | 设计与数据来源 |
| `faq-*.Rmd` | 工程故障 FAQ | 工程 FAQ（`starts_with("articles/faq-")`） |

新增 FAQ：复制 `_faq-template.Rmd`（下划线稿，站点不收录）为 `faq-<topic>.Rmd`。必须包含：

- YAML：`html_vignette` + `%\VignetteEncoding{UTF-8}`
- 章节顺序：一句话 → 症状 → 来源与根因 → 解决办法 → 相关文档
- 少 `eval`，不依赖 Office / 本地年鉴路径
- 不粘贴 `data-raw/` 原始表内容

首篇范例：`faq-encoding-utf8.Rmd`。

## 检查清单

- [ ] 新增函数/数据集有 roxygen 文档
- [ ] `devtools::document()` 已运行
- [ ] `_pkgdown.yml` 分组已更新
- [ ] `pkgdown::build_site()` 本地无 ERROR
- [ ] 中文内容编码 UTF-8 正常（`_pkgdown.yml` 中 `lang: zh_CN`）

## 参考

- pkgdown 配置：`_pkgdown.yml`
- CI 工作流：`.github/workflows/pkgdown.yaml`
- DESCRIPTION `Config/Needs/website` 列出网站构建依赖
