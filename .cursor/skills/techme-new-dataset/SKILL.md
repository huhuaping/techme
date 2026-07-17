---
name: techme-new-dataset
description: >-
  新增或调整标准数据集与 varsList 变量命名 SOP。Use when adding new datasets,
  extending varsList blocks, or creating Pub/Agri/RD/Basic prefixed data.
---

# 新增/调整数据集

## 何时使用

- 新增指标或全新数据源
- 扩展 varsList 变量命名
- 创建新的 `Pub*` / `Agri*` / `RD*` 数据集

## 前置条件

阅读 `vignettes/articles/pkg-design.Rmd` 中「变量定义系统」章节。

```r
renv::restore()
devtools::load_all()
data(varsList)  # 加载变量注册表
```

## SOP

### Step 1 — 命名决策

| 数据来源 | 前缀 | 文件命名 |
|----------|------|----------|
| 农村统计年鉴 | `Agri` | `R/Agri*.R` 或已有文件扩展 |
| 科技统计年鉴 | `RD` / `Industry` / `Market` | `R/tech-*.R` |
| 政府公开网站 | `Pub` | `R/Pub*.R` |
| 基础参考 | `Basic` | `R/Basic*.R` |
| 专题章节 | `Livestock` / `Machine` | `R/Livestock*.R` |

命名要求：PascalCase，反映数据内容（如 `PubConvergencePark`）。

### Step 2 — 扩展 varsList

按 block1–block4 区块命名法新增变量：

1. 确定 block 层级：`v04_gx_nbzh_jcyj`
2. 在 varsList 数据框追加行（含 unit、chn_block1–4、version）
3. **不删除**旧记录；调整命名时追加新版本行
4. 保存：`usethis::use_data(varsList, overwrite = TRUE)`

验证：

```r
get_vars(df = varsList, lang = "eng",
         block = list(block1 = "v04", block2 = "gx", block3 = "nbzh", block4 = "jcyj"),
         what = "variables")
```

### Step 3 — 创建数据集 roxygen 桩

在 `R/` 创建 `{DatasetName}.R`：

```r
#' Dataset Title (中文说明)
#'
#' @format A data frame:
#' \describe{
#'   \item{province}{character. Province name.}
#'   \item{year}{character. Year.}
#'   \item{value}{numeric. Value.}
#'   \item{units}{character. Unit.}
#'   \item{variables}{character. Coded variable name.}
#' }
#' @source Source description
#' @examples
#' \dontrun{ str(DatasetName) }
"DatasetName"
```

参考模板：`R/tech-RDPatentValid.R`。

### Step 4 — 编写清洗脚本

在 `data-raw/` 对应目录创建 `code-{source}.R` 或扩展现有脚本：

- 年鉴来源 → 走 9 步流水线（见 techme-yearbook-update Skill）
- 公开来源 → 爬取 + 清洗（见 techme-public-site-update Skill）

### Step 5 — 发布数据集

```r
usethis::use_data(DatasetName, overwrite = TRUE)
devtools::document()
```

### Step 6 — 更新 pkgdown 分组

编辑 `_pkgdown.yml`，在对应 `reference` 节的 `contents` 添加 `- DatasetName`。

### Step 7 — 更新 vignette

在 `vignettes/my-vignette.Rmd` 补充变量清单与中文说明。

## 检查清单

- [ ] 数据集命名符合前缀约定
- [ ] varsList 新变量 block 层级正确、版本号已记录
- [ ] roxygen `@format` 列描述完整
- [ ] `data/DatasetName.rda` 已生成
- [ ] `NAMESPACE` 无多余导出（数据集无需 @export）
- [ ] `_pkgdown.yml` 已更新
- [ ] `devtools::check()` 无 ERROR

## 参考

- 变量命名：`.cursor/rules/varslist-naming.mdc`
- 数据集文档：`.cursor/rules/datasets.mdc`
- 设计文档：`vignettes/articles/pkg-design.Rmd`
