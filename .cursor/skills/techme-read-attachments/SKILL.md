---
name: techme-read-attachments
description: >-
  从 HTML、PDF、Word、Excel、PPT 抽取文本并选择 MCP 工具。
  Use when reading attachments, converting html/pdf/docx to markdown,
  using markdownify or unlock_pdf, extracting MOA gazette tables,
  or working with local html/pdf/word files in data-raw/public-site.
---

# 附件文本抽取

MCP 是「眼睛」：看清结构、列名、跨页表、异常。入库仍走 xlsx 与现有 `scrape-*.Rmd`，不要把 Markdown 当 tidy 成品。

路径一律**绝对路径、正斜杠**。MCP / CLI 细节见 [reference.md](reference.md)。

## 何时使用

- 用户要读 html、pdf、docx、xlsx、pptx、ofd，或提到 markdownify / unlock_pdf
- 公开网站通知附件（核心育种场、种子基地等）需要先看清再落表
- 已有 `_extract/*.txt` 或 `.fitz.txt`，要对齐列名或查漏

## 工具路由（先看这张表）

| 来源 | 首选 | 备选 | 不要用 |
|------|------|------|--------|
| 本地 `.docx` | markdownify `docx-to-markdown` | pandoc | — |
| 本地 `.xlsx` | markdownify `xlsx-to-markdown` | R `openxlsx` / `readxl`（要入库时优先） | 先转 md 再猜表格 |
| 本地 `.pptx` | markdownify `pptx-to-markdown` | — | — |
| 本地 `.pdf`（有文本层） | markdownify `pdf-to-markdown` 或 unlock_pdf `read_pdf` | PyMuPDF 写 `_extract/*.fitz.txt` | **pdf-reader**（`PDF_PATH` 写死） |
| 扫描件 / 无文本层 pdf | 先 fitz / unlock_pdf 确认是否为空 | 论文用 literature + Mathpix | 只靠 markdownify |
| 本地 `.html` | Cursor `Read` 文件 | 表格用 `rvest`；CLI `markitdown` | `webpage-to-markdown` |
| 在线网页 | markdownify `webpage-to-markdown` | 先下载再 `Read` | 动态 JS 页可能抓不全 |
| `.ofd` | 用户先转 pdf | — | 现有 MCP 都不认 |
| `@citekey` 论文 | literature | — | 不要拿 literature 读公示 PDF |

政府公示 PDF 常分页表，markdownify 会打散行列。结构名单优先 unlock_pdf 指定页，或沿用目录里已有的 `.fitz.txt`。

## SOP

1. **定位文件**：要绝对路径。用户只给相对路径时，用工作区根拼出 `D:/github/techme/...`。
2. **按上表选工具**：一次只转一份附件；多文件逐个处理。
3. **看结构，不贴原文**：从结果归纳标题、附件序号、表头、约行数、年份。`data-raw/` 单元格值禁止写入对话。
4. **异常只记类型**：如机构名含换行、跨页表、列错位、空文本层。不要举例贴出单位全称列表。
5. **落表走现有流水线**：写入 `data-raw/public-site/{source}/xlsx/`，tidy 到 `data-raw/data-tidy/...`。公开数据后续步骤见 `techme-public-site-update`。

## 对话回报模板

```
文件：<绝对路径>
工具：markdownify | unlock_pdf | Read | fitz
结构：附件数 / 表头字段 / 约行数 / 年份
异常：<类型，无则写无>
下一步：<是否已有 scrape 脚本可接>
```

## 检查清单

- [ ] 选对工具（本地 html 未走 webpage-to-markdown；pdf 未走 pdf-reader）
- [ ] 路径为正斜杠绝对路径
- [ ] 未在对话中粘贴 `data-raw/` 原始表
- [ ] 名单任务未把 Markdown 当作入库文件
- [ ] ofd 已先转为 pdf

## 参考

- MCP 名称、本机 CLI、pdf-reader 限制：[reference.md](reference.md)
- 公开网站入库：`.cursor/skills/techme-public-site-update/SKILL.md`
- 数据安全：`.cursor/rules/data-privacy.mdc`
