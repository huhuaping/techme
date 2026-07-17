# 贡献指南

本文档供开发者与 Cursor Agent 共用，描述 techme 数据包的标准工作流程。

## 项目简介

techme 是服务于《中国旱区农业技术发展报告》的 R
数据包，整合年鉴与公开网站数据，发布 50+ 标准化 `.rda` 数据集。

- 设计文档：[vignettes/articles/pkg-design.Rmd](https://huhuaping.github.io/techme/vignettes/articles/pkg-design.Rmd)
- Agent 入口：[AGENTS.md](https://huhuaping.github.io/techme/AGENTS.md)

## 环境搭建

1.  克隆仓库（private，需 GitHub 权限）
2.  用 RStudio 打开 `techme.Rproj`
3.  恢复依赖：

``` r

renv::restore()
devtools::load_all()
```

**Windows 额外要求**：Microsoft Office（CNKI xls 转换需
`excelcnv.exe`）。

## 数据安全

- 禁止将 `data-raw/` 原始数据内容粘贴至公开渠道
- 禁止手改 `NAMESPACE`、`man/*.Rd`、`data/*.rda`
- 标准数据集仅经
  [`usethis::use_data()`](https://usethis.r-lib.org/reference/use_data.html)
  写入

## 工作流索引

| 任务 | 文档 |
|----|----|
| 年鉴年度更新 | [.cursor/skills/techme-yearbook-update/SKILL.md](https://huhuaping.github.io/techme/.cursor/skills/techme-yearbook-update/SKILL.md) |
| 公开网站数据更新 | [.cursor/skills/techme-public-site-update/SKILL.md](https://huhuaping.github.io/techme/.cursor/skills/techme-public-site-update/SKILL.md) |
| 新增数据集 | [.cursor/skills/techme-new-dataset/SKILL.md](https://huhuaping.github.io/techme/.cursor/skills/techme-new-dataset/SKILL.md) |
| 包验证与测试 | [.cursor/skills/techme-r-package-check/SKILL.md](https://huhuaping.github.io/techme/.cursor/skills/techme-r-package-check/SKILL.md) |
| 文档维护 | [.cursor/skills/techme-pkgdown-docs/SKILL.md](https://huhuaping.github.io/techme/.cursor/skills/techme-pkgdown-docs/SKILL.md) |
| tech-report 联动 | [.cursor/skills/techme-report-bridge/SKILL.md](https://huhuaping.github.io/techme/.cursor/skills/techme-report-bridge/SKILL.md) |

## 年鉴数据更新（摘要）

9 步流水线，入口 `data-raw/wfl_knitAll.R`：

1.  配置 `dir_final`、`dir_media`、`file_sel`
2.  逐步 `source("data-raw/wfl_*.R")`
3.  Step 4–5 需人工（unlock、edit xlsx）
4.  最终 `wfl_useData_*.R` →
    [`devtools::document()`](https://devtools.r-lib.org/reference/document.html)

## 公开数据更新（摘要）

1.  在 `data-raw/public-site/{source}/` 找或创建 `code-*.R`
2.  爬取 → 清洗 xlsx →
    [`wfl.queryInstituton()`](https://huhuaping.github.io/techme/reference/workflow_pub_site.md)
    匹配省份
3.  [`usethis::use_data()`](https://usethis.r-lib.org/reference/use_data.html)
    → 更新 `_pkgdown.yml`

## 新增数据集（摘要）

1.  确定命名前缀（Agri/RD/Pub/Basic）
2.  扩展 varsList（block 命名法，不删旧记录）
3.  创建 `R/{Name}.R` roxygen 桩
4.  编写 `data-raw/` 清洗脚本
5.  `use_data()` + `document()` + 更新 pkgdown 分组

## 变量命名体系

区块命名法 block1–block4：`v04_gx_nbzh_jcyj` =
科技_高校_内部支出_基础研究。

- 注册表：`data/varsList.rda`
- 查询：`get_vars(df = varsList, block = ..., what = "variables")`
- 版本迭代：追加不删除

## 提交前检查

``` r

devtools::document()
devtools::test()
devtools::check()
```

CI 自动运行 R CMD check（`.github/workflows/R-CMD-check.yaml`）与
pkgdown 部署。

## 与 tech-report 协作

- **tech-report**（`D:/github/tech-report`）：报告写作、部分爬取
- **techme**（本仓库）：标准化数据发布
- 数据流：tech-report 爬取 → 拷贝至 techme/data-raw → 流水线 → `.rda` →
  报告 [`library(techme)`](https://github.com/huhuaping/techme)

## 获取帮助

- 包设计问题：阅读 `vignettes/articles/pkg-design.Rmd`
- Agent 协作：阅读 `AGENTS.md` 并按 Skill 执行
- Bug 报告：<https://github.com/huhuaping/techme/issues>
