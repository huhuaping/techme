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
| 设计文章 | `vignettes/articles/` | knitr/Quarto 渲染 |
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

`vignettes/articles/` 含 pkg-design、queryTianyancha 等。注意：

- 该目录在 `.Rbuildignore` 中，不打包进 R 包
- 可在 pkgdown 中手动链接或作为内部参考

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
