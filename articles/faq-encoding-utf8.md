# FAQ：Windows 下源文件中文乱码

> **工程 FAQ 系列** · `faq-encoding-utf8` · 更新于 2026-08-15。
> 本系列放在 `vignettes/articles/faq-*.Rmd`，由 pkgdown 编入「工程
> FAQ」。 操作细则以仓库内 Cursor 规则 / Skill
> 为准；本文说明**现象与原理**。

## 一句话

`data-raw` 等源文件必须是 **UTF-8 无
BOM**。乱码的典型原因不是「文件本来是 GBK」，而是 UTF-8
汉字的**最后一个续字节被改成 `0x3F`（`?`）**，文件变成非法
UTF-8；再在编辑器里保存就会变成不可逆的替换字符 U+FFFD。

## 症状

同时出现下面几条，基本可以认定是本问题，而不是普通的 GBK/UTF-8
整文件误转：

- 同一文件里**一部分中文正常**（如「续表」「经费」），另一部分变成
  U+FFFD 或 `?`。
- 注释里的全角冒号 `：` 变成 `?`，例如 `## setting 3?specify`。
- 正则字面量损坏，且**闭合引号丢失**，R 无法解析：

``` r
# 损坏（示意，不要运行）
pattern.table = "^?*?, # default is "^?*?
```

- [`readLines()`](https://rdrr.io/r/base/readLines.html) / Python
  `bytes.decode("utf-8")` 报 *invalid continuation byte*。
- 用 GBK 打开也读不通（因为字节已经不是合法 GBK，也不是合法 UTF-8）。

合法 UTF-8 下，汉字「地」应是三个字节 `E5 9C B0`：

``` r

charToRaw("地")
#> [1] e5 9c b0
Encoding("地区")
#> [1] "UTF-8"
```

## 来源

本仓库在 Windows + Cursor Agent
环境下维护，源文件大量使用中文注释、中文正则（`地.*区`、`新.*疆`）和中文
XPath。

一次已确认的引入点是提交 `615312f`（2026-07-17，*Layer renv dependencies
and split data-raw package loading.*）。该提交批量改写 `data-raw`
脚本、把 [`library()`](https://rdrr.io/r/base/library.html) /
[`require()`](https://rdrr.io/r/base/library.html) 换成
`source("data-raw/deps/...")` 时，把许多三字节 UTF-8
序列截坏。其后这些脚本没有再改逻辑，因此可以用该提交的**父提交**作为合法底本。

未改到的行仍是完好 UTF-8，所以看起来像「部分乱码」。

## 根因

UTF-8 中一个常用汉字占 **3
字节**：`1110xxxx 10xxxxxx 10xxxxxx`。第三字节必须是续字节（`10xxxxxx`，即
`0x80`–`0xBF`）。

损坏模式是：只改第三字节为 `0x3F`（ASCII `?`）。`0x3F`
不是续字节，解码器失败。

| 字符 | 合法 UTF-8 |   损坏后   |
|:----:|:----------:|:----------:|
| `：` | `EF BC 9A` | `EF BC 3F` |
| `地` | `E5 9C B0` | `E5 9C 3F` |
| `区` | `E5 8C BA` | `E5 8C 3F` |
| `新` | `E6 96 B0` | `E6 96 3F` |
| `疆` | `E7 96 86` | `E7 96 3F` |

Windows 上还会**二次损坏**：

| 操作                             | 后果                                |
|----------------------------------|-------------------------------------|
| 编辑器打开并保存非法 UTF-8       | 非法序列变成 U+FFFD，工作区无法还原 |
| PowerShell `>` / `Out-File`      | 默认写出 UTF-16 LE                  |
| `errors = "replace"` 后写回      | 永久写成 `?` 或 U+FFFD              |
| `files.autoGuessEncoding = true` | 可能把 UTF-8 当成 GBK 再另存        |

`core.autocrlf=true` 只影响
CRLF/LF，**不是**这次乱码的首因；但整文件改换行会让 diff 难以阅读。

## 解决办法

### 已经损坏时

1.  **不要**在编辑器里打开并保存该文件。
2.  用 git 找到最后一个 `decode("utf-8")` 成功、且不含 U+FFFD
    的版本（常见为损坏提交的父提交）。
3.  以该版本为中文底本，只重放之后**有意的 ASCII 改动**（例如
    `source("data-raw/deps/load-dev.R")`）。
4.  工作区里尚未提交的合法业务改动（年份、`dir.case` 等）必须保留。
5.  写回 UTF-8 无 BOM，保持原换行，再检查。

操作清单见 `.cursor/skills/techme-encoding-utf8/SKILL.md`。

### 日常如何避免

对话改文件时遵守始终生效规则 `.cursor/rules/encoding-utf8.mdc`：

- 含中文的文件优先做**局部补丁**，不要整文件重写。
- 直接以 UTF-8 写入；不要按 GBK / latin-1 解码后再存。
- 禁止 `errors="replace"` 后写回；禁止用 PowerShell 重定向导出源文件。

仓库里还有三道机械约束：

- `afterFileEdit` hook（`.cursor/hooks.json`）：Agent 写完源文件后抽查
  UTF-8，失败则把原因打回对话。
- 工作区
  `.vscode/settings.json`：`files.encoding = utf8`，`files.autoGuessEncoding = false`。
- `.editorconfig`：`charset = utf-8`。

### 检查命令

在项目根目录：

``` bash
python scripts/check-utf8.py
python scripts/check-utf8.py data-raw/tech-yearbook/wfl-tech-yearbook.R
```

非法 UTF-8 与 U+FFFD 为失败。UTF-8 BOM 默认只警告（`--strict-bom`
才失败）。

在 R 中也可快速看字节（文件必须已经是合法 UTF-8）：

``` r

charToRaw(readLines("data-raw/tech-yearbook/wfl-tech-yearbook.R",
                    encoding = "UTF-8", n = 1))
```

## 相关文档

| 文档                                               | 职责                   |
|----------------------------------------------------|------------------------|
| `.cursor/rules/encoding-utf8.mdc`                  | 每次对话的写入约定     |
| `.cursor/skills/techme-encoding-utf8/SKILL.md`     | 乱码诊断与从 git 恢复  |
| `.cursor/skills/techme-encoding-utf8/reference.md` | `615312f` 字节对照     |
| `scripts/check-utf8.py`                            | 仓库级 UTF-8 检查      |
| `AGENTS.md`                                        | Agent 入口中的编码约束 |

## 本系列约定

后续同类说明请复制
`vignettes/articles/_faq-template.Rmd`（下划线前缀，pkgdown
不收录），另存为 `faq-<topic>.Rmd`，并保持：

1.  YAML 含 `%\VignetteEncoding{UTF-8}` 与 `html_vignette`。
2.  结构固定为：**一句话 → 症状 → 来源与根因 → 解决办法 → 相关文档**。
3.  不粘贴 `data-raw/`
    原始表内容；示例用路径、变量名、字节，不用业务数据。
4.  默认少求值、不依赖 Office / 本地年鉴路径，保证 pkgdown CI 能渲染。
5.  文件名以 `faq-` 开头；`_pkgdown.yml` 用
    `starts_with("articles/faq-")` 收入「工程 FAQ」。
