---
name: techme-r-package-check
description: >-
  R 包工程化验证 SOP：R CMD check、testthat、lint。Use before commits or PRs,
  or when setting up tests and CI for the techme package.
---

# R 包工程化验证

## 何时使用

- 提交代码或创建 PR 前
- 新增/修改 R 函数或数据集后
- 设置或运行 testthat 测试

## 标准验证流程

在项目根目录 R 控制台执行：

```r
renv::restore()
devtools::load_all()
devtools::document()
devtools::test()       # 运行 testthat
devtools::check()      # R CMD check
```

## 提交前检查清单

- [ ] `devtools::document()` 已运行，`NAMESPACE` 与 `man/` 同步
- [ ] 无新增未导出函数泄漏到 `NAMESPACE`
- [ ] `devtools::check()` 无 ERROR
- [ ] 新功能有对应 testthat 测试（纯函数优先）
- [ ] 未手改 `NAMESPACE`、`man/*.Rd`、`data/*.rda`

## testthat 结构

```
tests/
├── testthat.R
└── testthat/
    └── test-get_vars.R
```

运行：

```r
devtools::test()
# 或
testthat::test_dir("tests/testthat")
```

### 优先测试的纯函数

- `get_vars()` — 变量查询
- `get.vars()` — 变量查询（legacy）
- `gen_dirs_vec()` — 目录生成
- 不依赖本地 xls 路径或 Office 的辅助函数

### 测试模板

```r
test_that("get_vars returns expected variables", {
  skip_if_not_installed("techme")
  data(varsList, package = "techme", envir = environment())
  block_sel <- list(block1 = "v7", block2 = "sctj", block3 = "nyjx",
                    block4 = "zdl")
  result <- get_vars(df = varsList, block = block_sel, what = "variables")
  expect_type(result, "character")
  expect_true(length(result) > 0)
})
```

## CI：R CMD check

工作流：`.github/workflows/R-CMD-check.yaml`

- 触发：push/PR 到 main/master
- 使用 r-lib/actions 标准模板
- 在 ubuntu-latest 运行 `rcmdcheck::rcmdcheck()`

## Lint（可选）

`.lintr` 配置已启用基本规则。本地运行：

```r
lintr::lint_dir("R/")
```

## 常见问题

| 问题 | 处理 |
|------|------|
| NAMESPACE 冲突 | 重新 `devtools::document()`，检查 roxygen `@export` |
| 缺失依赖 | `renv::install()` 后 `renv::snapshot()` |
| check WARNING: no tests | 添加 `tests/testthat/` 内容 |
| 示例失败 | 用 `\dontrun{}` 包裹依赖本地数据的示例 |

## 参考

- DESCRIPTION 中 `Config/testthat/edition: 3`
- r-lib actions: https://github.com/r-lib/actions
