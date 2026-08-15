---
name: techme-encoding-utf8
description: >-
  Diagnoses and repairs UTF-8 mojibake in techme source on Windows.
  Use when R/Rmd/qmd/md show 乱码, U+FFFD, invalid UTF-8, truncated CJK
  bytes, or after bulk rewrites of files containing Chinese.
---

# techme UTF-8 乱码诊断与修复

Windows + Cursor Agent 改写含中文的源文件时，UTF-8 三字节汉字的**最后续字节**可能被写成 `0x3F`（`?`），文件变成非法 UTF-8。编辑器再保存会变成 U+FFFD，原字节丢失。

详细字节对照见 [reference.md](reference.md)。

## 何时使用

- 用户提到乱码、`�`、编码、UTF-8、GBK
- `bytes.decode("utf-8")` 失败，或文件含 U+FFFD
- 刚对大量 `.R` / `.Rmd` / `.qmd` 做了批量改写

## 禁止

- 在编辑器中打开并保存已损坏文件
- `errors="replace"` 后写回
- PowerShell `>` 重定向源文件（UTF-16 LE）
- 猜测汉字；必须从 git 历史取最后一个合法 UTF-8 版本

## 诊断

```powershell
python scripts/check-utf8.py
python scripts/check-utf8.py data-raw/path/to/file.R
```

非法 UTF-8 与 U+FFFD 为失败。UTF-8 BOM 默认只警告（`--strict-bom` 才失败）。

对每个失败文件：

1. `git log -- <path>`，从新到旧 `git show <sha>:<path>`，找到**最后一个** `decode("utf-8")` 成功且无 U+FFFD 的提交（常见为损坏提交的父提交）。
2. 用 `git diff <good> HEAD -- <path>` 区分：非法 UTF-8 行（恢复底本）vs 有意 ASCII 改动（如 `source("data-raw/deps/...")`，保留 HEAD）。
3. 合并后写回 UTF-8（保持原换行），再跑 `python scripts/check-utf8.py -- <path>`。

## 合并规则

- HEAD 行含 U+FFFD 或非法 UTF-8 → 用 good 行
- HEAD 行合法且为加载器/`library` 替换 → 用 HEAD
- 行数不等的混合块：脏行按 ASCII 骨架匹配 good 中文行，干净行保留 HEAD
- 工作区已有合法业务改动（年份、`dir.case` 等）必须保留

## 改完必检

- [ ] 目标文件 `utf-8` 可解码
- [ ] 无 U+FFFD
- [ ] 汉字数不低于 good 版本
- [ ] `source("data-raw/deps/...")` 等有意改动仍在
- [ ] 未提交 `data-raw/` 原始 xls/html
