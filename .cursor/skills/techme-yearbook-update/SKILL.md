---
name: techme-yearbook-update
description: >-
  年鉴数据年度更新 9 步流水线 SOP。Use when updating yearbook data from CNKI
  xls, running unpivot/matchVars, or working in data-raw/update-yearbook or
  xxx-yearbook directories.
---

# 年鉴数据年度更新

## 何时使用

- 从中国知网下载新年鉴 xls 并入库
- 运行 unpivot、tidy、matchVars 流水线
- 更新 `Agri*`、`RD*`、`Industry*` 等年鉴来源数据集

## 前置条件

```r
renv::restore()
devtools::load_all()
```

- Windows + Microsoft Office（`excelcnv.exe` 用于 xls 转换）
- 原始 xls 放入对应 `data-raw/xxx-yearbook/` 目录

## 数据源目录

| 年鉴 | 原始目录 | 清洗目录 |
|------|----------|----------|
| 科技统计 | `data-raw/tech-yearbook/` | `data-raw/data-tidy/tech-yearbook/` |
| 农村统计 | `data-raw/rural-yearbook/` | `data-raw/data-tidy/rural-yearbook/` |
| 国家统计 | `data-raw/nation-yearbook/` | `data-raw/data-tidy/nation-yearbook/` |
| 农业机械 | `data-raw/agrimachine-yearbook/` | `data-raw/data-tidy/agrimachine-yearbook/` |

## SOP：9 步流水线

### Step 0 — 配置入口脚本

编辑 `data-raw/wfl_knitAll.R`（或 `data-raw/update-yearbook/wfl_knitGUI.R`）顶部：

```r
dir_final <- c("01-activity", "02-source")   # 目标子目录
dir_media <- "data-raw/tech-yearbook/part01-over/"
i_sel <- 1
file_sel <- "raw-2024.xls"
```

### Step 1–9 — 按序 source

在 RStudio 中逐步执行（项目根目录为 working directory）：

| 步 | 脚本 | 说明 | 自动化 |
|----|------|------|--------|
| 1 | `source("data-raw/wfl_files.R")` | 选择待处理文件 | 半自动 |
| 2 | `source("data-raw/wfl_genDirs.R")` | 创建目录结构 | 自动 |
| 3 | `source("data-raw/wfl_rename.R")` | 重命名（可选，通常跳过） | 半自动 |
| 4 | `source("data-raw/wfl_unlock.R")` | 解除 Excel 保护 | **需 Windows + 人工** |
| 5 | `source("data-raw/wfl_editXls.R")` | 手工编辑 xlsx | **必须人工** |
| 6 | `source("data-raw/wfl_unpivot.R")` | 宽转长 | 自动（配置 `cols_drop`, `header_mode`） |
| 7 | `source("data-raw/wfl_tidy.R")` | 清洗 | 自动 |
| 8 | `source("data-raw/wfl_matchVars.R")` | 匹配 varsList 变量名 | 自动（配置 `block_target`） |
| 9 | `source("data-raw/wfl_matchData.R")` | 导出到 data-tidy | 自动 |

### Step 10 — 发布数据集

执行对应的 `wfl_useData_*.R` 或：

```r
wfl.useData(dt, name = "RDPatentValid", overwrite = TRUE)
# 等价于 usethis::use_data(RDPatentValid, overwrite = TRUE)
devtools::document()
```

## 关键参数

### wfl_unpivot.R

```r
cols_drop <- c(2)           # 需删除的列
header_mode <- "vars"       # "vars" 或 "year"
# header_mode == "year" 时需手动指定 vars_spc：
vars_spc <- get_vars(df = varsList, lang = "eng",
                     block = list(block1 = "v4", block2 = "zh",
                                  block3 = "qd", block4 = "RD"),
                     what = "chn_block4")
```

### wfl_matchVars.R

```r
block_target <- list(block1 = "v4", block2 = "zh", block3 = "qd")
block_lang <- "eng"
```

## 检查清单

- [ ] 原始 xls 已放入正确 yearbook 目录
- [ ] `dir_final` / `dir_media` / `file_sel` 配置正确
- [ ] Step 4–5 人工步骤已完成
- [ ] unpivot 后行数/列数合理（无异常空行）
- [ ] matchVars 匹配率 > 95%（未匹配项已 warning 审查）
- [ ] 新年份已覆盖（检查 `year` 列唯一值）
- [ ] 单位（units）与往年一致
- [ ] `data/*.rda` 已更新
- [ ] `devtools::document()` 已运行
- [ ] `devtools::check()` 无 ERROR

## 参考

- 设计文档：`vignettes/articles/pkg-design.Rmd`
- 工作流函数：`R/workflow_funs.R`（`wfl.findFiles` 至 `wfl.useData`）
- 详细参数说明：同目录 `reference.md`
