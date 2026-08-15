# 2026-07 乱码事故对照

## 触发

`615312f`（*Layer renv dependencies and split data-raw package loading.*，Co-authored-by Cursor）批量改写 `data-raw` 脚本时，把 UTF-8 三字节序列的最后一字节改成 `0x3F`。

最后一个完好版本：该提交的父提交（科技年鉴脚本亦可用 `e78fff8`）。

## 字节

| 字符 | 合法 UTF-8 | 损坏后 |
|------|------------|--------|
| `：` | `EF BC 9A` | `EF BC 3F` |
| `地` | `E5 9C B0` | `E5 9C 3F` |
| `区` | `E5 8C BA` | `E5 8C 3F` |
| `新` | `E6 96 B0` | `E6 96 3F` |
| `疆` | `E7 96 86` | `E7 96 3F` |

`0x3F` 不是续字节（续字节须为 `10xxxxxx`），故整文件非法 UTF-8。闭合引号有时一并丢失，R 语法也会坏（如 `pattern.table = "^地.*区"`）。

未改到的行（如 `"续表"`、`"RD经费"`）仍合法，表现为「部分乱码」。

## Windows 二次伤害

| 操作 | 后果 |
|------|------|
| 编辑器打开并保存非法 UTF-8 | 非法序列变成 U+FFFD，工作区无法还原 |
| PowerShell `>` | 写出 UTF-16 LE |
| Python `print` 到控制台 | 系统代码页常为 GBK，打印失败或再误导 |
| `core.autocrlf=true` | 换行是 CRLF；不是首因，但整文件改换行会干扰 diff |

## 修复策略（已验证）

`615312f` 之后这些脚本没有再改逻辑。以父提交为 UTF-8 底本，只重放干净的 `source("data-raw/deps/...")` 等加载器改动即可。
