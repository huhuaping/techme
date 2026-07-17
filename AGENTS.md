# techme — Agent 开发指南

> **techme** 是服务于《中国旱区农业技术发展报告》的 R 数据包 + ETL 流水线。本文件是 Cursor Agent 的首读入口。

## 数据安全（必读）

- 本仓库为 **private**，原始数据含多渠道抓取的敏感信息，**禁止**在对话、日志或公开提交中粘贴 `data-raw/` 原始内容。
- 标准数据集通过 `data/*.rda` 发布；`.rda` 二进制文件禁止手改，仅经 `usethis::use_data()` 生成。
- 权威设计文档：[vignettes/articles/pkg-design.Rmd](vignettes/articles/pkg-design.Rmd)

## 目录地图

| 目录 | 职责 |
|------|------|
| `R/` | 包源码：工作流函数（`wfl.*`）、数据集桩、工具函数 |
| `data/` | 52 个标准 `.rda` 数据集（`LazyData: true`） |
| `data-raw/` | 原始数据 + 清洗脚本（`.Rbuildignore` 排除，不打包） |
| `man/` | roxygen 自动生成的 `.Rd`（禁止手改） |
| `vignettes/` | 设计文档与数据集说明 |
| `docs/` | pkgdown 构建产物（CI 部署至 GitHub Pages） |
| `renv/` | 依赖隔离（`renv.lock` 锁定 R 4.4.3） |

### data-raw 子目录

- 年鉴原始：`data-raw/xxx-yearbook/` → 清洗后：`data-raw/data-tidy/xxx-yearbook/`
- 公开网站：`data-raw/public-site/` → 成品：`data-raw/data-tidy/xxx-web/{html,xlsx}/`
- 年度更新入口：`data-raw/update-yearbook/`、`data-raw/update-public/`

## 六大工作流（Skills）

执行任务前，读取对应 Skill：

| 工作流 | Skill 路径 |
|--------|-----------|
| 年鉴数据年度更新 | [.cursor/skills/techme-yearbook-update/SKILL.md](.cursor/skills/techme-yearbook-update/SKILL.md) |
| 公开网站数据抓取与更新 | [.cursor/skills/techme-public-site-update/SKILL.md](.cursor/skills/techme-public-site-update/SKILL.md) |
| 新增/调整数据集与 varsList | [.cursor/skills/techme-new-dataset/SKILL.md](.cursor/skills/techme-new-dataset/SKILL.md) |
| R 包工程化（check、test） | [.cursor/skills/techme-r-package-check/SKILL.md](.cursor/skills/techme-r-package-check/SKILL.md) |
| 文档与 pkgdown 维护 | [.cursor/skills/techme-pkgdown-docs/SKILL.md](.cursor/skills/techme-pkgdown-docs/SKILL.md) |
| 与 tech-report 联动 | [.cursor/skills/techme-report-bridge/SKILL.md](.cursor/skills/techme-report-bridge/SKILL.md) |

## 常用 R 命令

```r
renv::restore()              # 恢复依赖
devtools::load_all()         # 开发加载
devtools::document()         # 生成 NAMESPACE 与 man/
devtools::check()            # R CMD check
pkgdown::build_site()        # 本地预览文档站
devtools::install_github("huhuaping/techme")
```

## 核心流水线速览

**年鉴 9 步**（见 `data-raw/wfl_knitAll.R`）：

```
wfl_files → wfl_genDirs → [wfl_rename] → wfl_unlock → wfl_editXls
→ wfl_unpivot → wfl_tidy → wfl_matchVars → wfl_matchData → wfl_useData
```

**公开数据**（见 `R/workflow_pub.R`）：

```
爬取/导入 → wfl.queryInstituton → wfl.write2ship → use_data
```

**变量命名**：区块命名法 block1–block4，如 `v04_gx_nbzh_jcyj` = 科技_高校_内部支出_基础研究。注册表：`varsList`。

## Windows 平台注意

- CNKI 加密 xls 转换依赖 Microsoft Office 的 `excelcnv.exe`（`get_excelcnv_exe()` 自动查找）。
- 含 `readline()` 的交互脚本（如 `wfl.writeXlsx`）须用户在 **RStudio 中手动执行**，Agent 不可无人值守运行。
- 路径使用正斜杠或 `here::here()`，避免硬编码反斜杠。

## 与 tech-report 联动

| 项目 | 职责 | 路径 |
|------|------|------|
| **tech-report** | 报告写作、部分爬取与初洗 | `D:/github/tech-report` |
| **techme** | 标准化数据集发布（`.rda`） | 本仓库 |

数据流：tech-report 爬取/初洗 → 拷贝至 `techme/data-raw/data-tidy/` → 流水线 → `data/*.rda` → 报告端 `library(techme)` 消费。

## Agent 行为约束

### 必须

- 修改 `R/` 后运行或提醒 `devtools::document()`
- 更新数据集走 `data-raw` 流水线 → `use_data()`，不直接编辑 `.rda`
- 新增变量先查/扩 `varsList`，遵循 block 命名法
- 保持最小改动范围，匹配现有命名与风格

### 禁止

- 手改 `NAMESPACE`、`man/*.Rd`、`data/*.rda`
- 在对话中粘贴 `data-raw/` 原始数据内容
- 未经请求做全仓库重构

## 推荐 Agent 指令模板

```
请先阅读 AGENTS.md 和 vignettes/articles/pkg-design.Rmd，
然后按 .cursor/skills/techme-{workflow}/SKILL.md 执行 {具体任务}。
完成后运行 devtools::document() 和 devtools::check() 验证。
```

## 贡献指南

详见 [CONTRIBUTING.md](CONTRIBUTING.md)。
