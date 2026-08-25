# 附件抽取：MCP 与本机 CLI

配置在用户级 `C:/Users/huhua/.cursor/mcp.json`。改 MCP 后需在 Cursor Settings → MCP 里确认绿点。

## MCP 命名空间

Agent 调用前先 `GetDynamicTools` 核对 schema。

| 配置名 | 命名空间 | 常用工具 |
|--------|----------|----------|
| markdownify | `user-markdownify` | `docx-to-markdown`、`pdf-to-markdown`、`xlsx-to-markdown`、`pptx-to-markdown`、`webpage-to-markdown`、`image-to-markdown`、`get-markdown-file` |
| unlock_pdf | `user-unlock_pdf` | `read_pdf`：`file_path`（必填），`pages`（1-indexed 可选），`password`（可选） |
| pdf-reader | `user-pdf-reader` | **日常不用**。`PDF_PATH` 写死单份论文，换文件要改配置并重启 |
| literature | `user-literature` | 仅 `@citekey` 论文 PDF / OCR 缓存，不读 `data-raw/public-site` 公示件 |

markdownify 底层：`uv run` + 仓库内 `.venv` 的 `markitdown`。已设 `PYTHONIOENCODING=utf-8`。

`webpage-to-markdown` 只要 **URL**，不要本地路径。本地 html 用 Read，或下面 CLI。

`get-markdown-file` 只要 `.md` / `.markdown`。

## 本机路径（Windows）

```
markdownify 入口：D:/github-follow/markdownify-mcp/dist/index.js
markitdown.exe：D:/github-follow/markdownify-mcp/.venv/Scripts/markitdown.exe
uv：C:/Users/huhua/.local/bin/uv.exe
pandoc：C:/Users/huhua/AppData/Local/Pandoc/pandoc.exe
```

系统 Python 已有 PyMuPDF（`import fitz`）。不要为一次抽取再装一套 markdownify MCP。

## CLI 兜底（MCP 失败时）

```powershell
& "D:/github-follow/markdownify-mcp/.venv/Scripts/markitdown.exe" "D:/github/techme/data-raw/public-site/.../file.docx"
```

无扩展名参数时 markitdown 读 stdin。输出不要用 PowerShell `>` 重定向进源码目录（会变成 UTF-16 LE）；需要落盘时用 Python `Path.write_bytes(text.encode("utf-8"))`。

文本层 PDF 也可用：

```python
import fitz
doc = fitz.open(r"D:/github/techme/data-raw/public-site/.../file.pdf")
```

核心育种场已有按页抽取约定：`data-raw/public-site/moa-xmj-breeding/_extract/*.fitz.txt`。优先复用，不要重复 OCR。

## 扫描件

1. unlock_pdf 或 fitz 抽一页；几乎为空再考虑 OCR。
2. 论文：literature `extract_to_cache`（Mathpix `mpx`）。
3. 公示扫描件：不默认跑 OCR；可请用户补文本层或手工入 xlsx。
