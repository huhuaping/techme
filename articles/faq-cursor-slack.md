# FAQ：Cursor IDE 与 Slack 的关联和互动

> **工程 FAQ 系列** · `faq-cursor-slack` · 更新于 2026-08-15。
> 本系列放在 `vignettes/articles/faq-*.Rmd`，由 pkgdown 编入「工程
> FAQ」。 操作约定以 Cursor 官方文档为准；本文记录 **techme 维护者在
> Research-Hub / `#cursor-robot` 上的实测结论**。

## 一句话

Cursor 和 Slack 是**两套集成**，不是「IDE 里开对话、频道自动镜像」。要让
Slack 能追踪并互动，必须在频道里 `@Cursor` 启动 Cloud Agent，再用 **Open
in Cursor** 接到同一条 run；在 IDE /
[cursor.com/agents](https://cursor.com/agents)
里追加的话**不会**自动出现在 Slack thread。要从 IDE
往频道发普通消息，另装 Slack MCP，且 MCP 代发的 `@Cursor` **不会**触发
Cloud Agent。

## 症状

同时出现下面几条，通常不是授权没做完，而是把两套集成当成了一条双向管道：

- Dashboard 已经 Connect Slack，但 Cursor IDE 里的本地 Agent
  读不到、也发不了 `#cursor-robot`。
- Agent 输入框选 **Cloud** 后任务能在
  [cursor.com/agents](https://cursor.com/agents) 跑，频道里没有任何
  thread。
- 用 Slack MCP 从 IDE 发出带 `@Cursor` 的消息，频道看得到，且带
  `Sent using @Cursor`，但 bot 不在 thread 里回复。
- 同一条 Cloud Agent 在 IDE 里追问后，Agents 页面有新回复，Slack 原
  thread 仍停在启动那一轮。
- 私有频道里 `@Cursor settings` 设了默认仓库，下次提问仍被要求选仓库。
- 在 Slack 私信（1:1 DM）里 `@Cursor` 没有反应。

本仓库的实测环境：Slack workspace **Research-Hub**，频道
**`#cursor-robot`**（先私有、后改为公开），默认仓库
**`huhuaping/techme`**。

## 来源与根因

### 两套集成

Cursor 官方把 Slack 分成两条互不替代的链路（见 [Cursor Slack
文档](https://cursor.com/docs/integrations/slack) 与论坛对 nightly Slack
MCP 的说明）：

| 集成 | 入口 | 方向 | 身份 | 做什么 |
|----|----|----|----|----|
| Cloud Agents Slack | [Dashboard → Integrations](https://www.cursor.com/dashboard/integrations) | Slack → 云端 Agent | `@Cursor` 应用 | 在频道 thread 里启动 / 跟进 Cloud Agent，可 **Open in Cursor** |
| Slack MCP | Cursor Marketplace `/add-plugin slack` 或 [Slack 官方 Connect to Cursor](https://docs.slack.dev/ai/slack-mcp-server/connect-to-cursor/) | IDE Agent → Slack | 你的 Slack 用户 | 读频道、发普通消息、搜用户；**不**绑定 Cloud Agent thread |

Dashboard 授权只完成第一套。本机 `~/.cursor/mcp.json` 里没有 `slack`
时，当前 IDE 对话调不到第二套。装上插件后，MCP 服务器名一般为
`plugin-slack-slack`。

### 绑定发生在启动那一刻

Cloud Agent 和 Slack thread 的绑定，只在**从 Slack 发出 `@Cursor`
的那一轮**建立：

    Slack 频道里 @Cursor [任务]
      -> 创建 Cloud Agent（bc-xxxx）
      -> 同一 thread 回复 + Open in Cursor
      -> IDE / cursor.com/agents 打开的是同一条 run
      -> 在 IDE 里继续说：只写 Agents / IDE，不回写 Slack
      -> 在同一 thread 再 @Cursor：Slack 与 Agents 都会更新

IDE 里把模式改成 **Cloud** 再发任务，会另开一条
run，默认不进任何频道。`channel=#cursor-robot` 只是 Slack 侧 `@Cursor`
的选项，用来把更新转到另一个频道，不是 IDE 启动参数。

Slack MCP 发出的消息会带 `Sent using @Cursor`。这类消息通常**不会**触发
`@Cursor` 的 `app_mentions`，所以不能用来「从 IDE 拉起 Cloud Agent」。

### 频道类型与选仓库

`@Cursor settings`
的**频道默认仓库只对公开频道生效**。私有频道会跳过这一步，改走：

1.  消息里的仓库名 / `repo=`
2.  最近用过的仓库
3.  Dashboard [Routing
    Rules](https://www.cursor.com/dashboard/cloud-agents)
4.  Dashboard **Default repository**

`#cursor-robot` 若保持私有，必须在 Dashboard 把默认仓库设为
`huhuaping/techme`，或每条任务写 `repo=huhuaping/techme`。官方 bot
**不支持 1:1 DM**；私有频道还要先 `/invite @Cursor`（`channels:join`
只对公开频道自动加入）。

### 和本仓库的关系

Cloud Agent 在 Cursor 云端 VM 里 clone `huhuaping/techme`。**Privacy
Mode (Legacy) 不支持**。提示词和 Slack 摘要都不要读取或粘贴 `data-raw/`
原始表。年鉴入口依赖本机 Office /
[`readline()`](https://rdrr.io/r/base/readline.html) 的步骤，云端 VM
跑不了，不要把 Cloud Agent 当成本机 ETL。

## 解决办法

### 1. 开通 Cloud Agents Slack（频道 → 云端 Agent）

1.  打开
    [Integrations](https://www.cursor.com/dashboard/integrations)，Connect
    Slack，安装到 **Research-Hub**。
2.  同一页连接 GitHub，确认当前账号对 `huhuaping/techme` 有读写权限。
3.  开通 usage-based pricing（Cloud Agent 按所选模型 API
    计价，需付费计划）。
4.  在 [Cloud Agents](https://www.cursor.com/dashboard/cloud-agents) 把
    **Default repository** 设为 `huhuaping/techme`。
5.  在 `#cursor-robot` 执行 `/invite @Cursor`。
6.  频道若是公开的，再发 `@Cursor settings`，把频道默认仓库也设成
    `huhuaping/techme`。
7.  先发 `@Cursor help`，确认 bot 能回命令列表。

### 2. 让 Slack 能追踪的正确开法

在 `#cursor-robot` **新开一条消息**（不要回那些带 `Sent using @Cursor`
的 MCP 帖）：

    @Cursor repo=huhuaping/techme autopr=false
    用一句话说明这个仓库是做什么的，不要改代码。

等 thread 出现 Cursor 回复和 **Open in Cursor**。点开后，IDE / Agents
里应是同一个 `bc-xxxx`。

之后：

| 你在哪 | 怎么说 | Slack thread |
|----|----|----|
| 同一 Slack thread | `@Cursor [跟进]`，或消息 ⋯ → **Add follow-up** | 会更新 |
| IDE / Agents（已打开该 `bc-xxxx`） | 直接输入 | **不**自动出现 |
| 频道里另开一条 | `@Cursor …` | 新 Agent，与上一条无关 |
| 同一 thread 要另开一条 | `@Cursor agent [任务]` | 新 Agent，仍在这个 thread |

同一条 run 的核对：Slack 回复里的链接与
[cursor.com/agents](https://cursor.com/agents) 顶部 ID 相同，形如
`bc-927c83c1-10da-52e2-b623-49415fc8a494`。

需要频道留档时，把问题在 Slack thread 再 `@Cursor` 问一遍，或把 Agents
上的结论复制进 thread。没有「IDE 说一句、Slack 自动跟一句」的开关。

### 3. 从 IDE 往频道发普通消息（Slack MCP）

1.  在 Cursor 聊天框执行 `/add-plugin slack`，或按 [Connect to
    Cursor](https://docs.slack.dev/ai/slack-mcp-server/connect-to-cursor/)
    加入远程 MCP：`https://mcp.slack.com/mcp`。
2.  点 **Connect**，OAuth 登录 **Research-Hub**。workspace
    管理员须先批准 Slack MCP。
3.  Settings → MCP 里 `slack` 为绿灯后，用 **Agent 模式**（不要用
    Ask）发任务，例如：「在 `#cursor-robot` 发一条连通性测试，不要
    `@Cursor`。」
4.  第一次调用会弹出工具确认。发出的是**你的用户消息**，不是 `@Cursor`
    机器人。

不要用这条路径去「启动可被 Slack 跟踪的 Cloud Agent」。要开 Cloud
Agent，回到第 2 步在 Slack 里手 `@Cursor`。

### 4. 不要做

- 以为 IDE 里选 **Cloud** 就等于连上了 `#cursor-robot`。
- 用 Slack MCP 代发 `@Cursor` 来触发 bot。
- 在私有频道依赖 `@Cursor settings` 当默认仓库。
- 在 1:1 DM 里 `@Cursor`。
- 把 Cloud Agent
  当成本机年鉴流水线（`excelcnv.exe`、[`readline()`](https://rdrr.io/r/base/readline.html)、本地
  Office 路径在云端不可用）。
- 在 Slack、Agents 或本 FAQ 里粘贴 `data-raw/` 原始表内容。
- 为了「镜像」去手写第三套 webhook / 自建 Slack
  app；官方集成已经覆盖维护场景。

### 5. 连通性自检

1.  Slack：`@Cursor help` 有回复。
2.  Slack：带 `repo=huhuaping/techme` 的只读任务能在 thread
    里回答，并给出 Open in Cursor。
3.  点开后 IDE / Agents 的 `bc-xxxx` 与 Slack 一致。
4.  在 IDE 里追问一句：Agents 有新回复，Slack thread
    **可以没有**（符合预期）。
5.  回到同一 thread `@Cursor` 再问一句：Slack 与 Agents 都应更新。
6.  （可选）IDE 经 Slack MCP 发一条**不含** `@Cursor`
    的测试帖，频道能看到。

## 相关文档

| 文档 | 职责 |
|----|----|
| [Cursor：Slack](https://cursor.com/docs/integrations/slack) | `@Cursor` 命令、频道设置、权限、`channel=` |
| [Cursor：Cloud Agents](https://cursor.com/docs/cloud-agent) | 从 Slack / IDE / Web 启动云端 Agent |
| [Slack：Connect MCP to Cursor](https://docs.slack.dev/ai/slack-mcp-server/connect-to-cursor/) | IDE 侧 Slack MCP 安装与 OAuth |
| [Cursor Marketplace：Slack](https://cursor.com/marketplace/slack) | `/add-plugin slack` |
| `AGENTS.md` | 本仓库数据安全与 Agent 约束 |
| `vignettes/articles/faq-cursor-r-outline.Rmd` | Cursor 里 R 脚本 Outline 为空 |
| `vignettes/articles/faq-encoding-utf8.Rmd` | 源文件 UTF-8 / 中文乱码 |
| `.cursor/skills/techme-pkgdown-docs/SKILL.md` | 工程 FAQ 的写法与收录 |

## 本系列约定

后续同类说明请复制
`vignettes/articles/_faq-template.Rmd`（下划线前缀，pkgdown
不收录），另存为 `faq-<topic>.Rmd`，并保持：

1.  YAML 含 `%\VignetteEncoding{UTF-8}` 与 `html_vignette`。
2.  结构固定为：**一句话 → 症状 → 来源与根因 → 解决办法 → 相关文档**。
3.  不粘贴 `data-raw/`
    原始表内容；示例用路径、变量名、日志原文，不用业务数据。
4.  默认少求值、不依赖 Office / 本地年鉴路径，保证 pkgdown CI 能渲染。
5.  文件名以 `faq-` 开头；`_pkgdown.yml` 用
    `starts_with("articles/faq-")` 收入「工程 FAQ」。
