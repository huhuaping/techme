# 年鉴更新参考

## 各年鉴入口脚本

| 年鉴 | 入口 |
|------|------|
| 科技统计 | `data-raw/tech-yearbook/wfl-tech-yearbook.R` |
| 农村统计 | `data-raw/rural-yearbook/wfl-rural-yearbook.R` |
| 国家统计 | `data-raw/nation-yearbook/wfl-national-yearbook.R` |
| 农业机械 | `data-raw/agrimachine-yearbook/wfl-agrimachine-yearbook.R` |

## update-yearbook 目录

`data-raw/update-yearbook/` 含 GUI 驱动版本（`wfl_knitGUI.R`）及各步骤脚本的年度更新副本。

## wfl.* 函数链（R/workflow_funs.R）

```
create.dirTable()
wfl.findFiles(dt, dir.case, i.final, pattern)
wfl.Xls2Xlsx(file_path, sheet_drop = c("CNKI"))
wfl.unpivotXlsx(...)
wfl.tidyTable(dt)
wfl.matchVars(dt, block_target, block_lang = "eng")
wfl.addVars(dt_left, dt_right)
wfl.writeXlsx(...)        # 含 readline() 交互
wfl.useData(dt, name, overwrite = TRUE)
```

## 常见问题

1. **CNKI xls 无法打开**：确认 Windows + Office，`get_excelcnv_exe()` 返回有效路径。
2. **变量匹配失败**：检查 varsList 是否含对应 block 组合；可能需要扩展 varsList（见 techme-new-dataset Skill）。
3. **年份列异常**：检查 `header_mode` 是否正确（`"vars"` vs `"year"`）。
