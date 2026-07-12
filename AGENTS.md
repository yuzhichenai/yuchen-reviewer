# 宇尘审查器 (yuchen-reviewer)

## 项目概述

宇尘审查器是一个 opencode 代码审查 skill 工具，覆盖 Bug 检测、安全漏洞分析、性能评估和架构审查四大维度。以中文为母语，深度适配 deepseek 与 kimi 模型。

- **版本**: v1.0.1
- **GitHub**: https://github.com/yuzhichenai/yuchen-reviewer
- **工作目录**: C:\Users\Admin\Desktop\review工具

## 文件结构

| 文件 | 说明 |
|------|------|
| `opencode.json` | 注册 `.opencode/skills` 路径，使 skill 可被自动发现 |
| `.opencode/skills/宇尘审查器/SKILL.md` | Skill 定义：在对话中自动触发审查 |
| `.opencode/agents/宇尘审查器.md` | Agent 定义：可在 opencode UI 中手动选择 |
| `install.ps1` | Windows 全局安装脚本 |
| `install.sh` | Linux/macOS 全局安装脚本 |
| `README.md` | 项目文档 |
| `AGENTS.md` | 本文件，供 AI 参考的项目上下文 |
| `项目要求.txt` | 原始需求文档（不纳入 git） |

## 核心架构

### 双模式使用
- **Skill 模式**：用户说出「审查代码」「检查bug」「review code」等关键词时自动激活
- **Agent 模式**：在 opencode agent 列表中选择「宇尘审查器」代理手动使用

### 四大审查维度
1. 🐛 **Bug/逻辑错误** — 边界条件、并发、资源管理、状态错误、类型转换、错误处理
2. 🔒 **安全漏洞** — 注入攻击、敏感信息泄露、权限缺失、输入验证
3. ⚡ **性能问题** — 算法复杂度、内存分配、循环低效、缓存策略
4. 🏗️ **架构设计** — 耦合/内聚、职责分离、循环依赖、扩展性

### 输出格式
- 无问题：`✅ 代码质量良好` 简要评述
- 有问题：按 Critical → Major → Minor 排序，包含位置、问题说明、风险分析、修复建议
- 末尾附审查总结和优先处理建议

### 防死循环行为准则（v1.0.1 增强版）
Skill 和 Agent 文件中均嵌入了严厉行为准则，核心规则：
1. 编辑前绝对禁止调用 bash 做任何验证（包括 `node --check`、`ruff`、`tsc --noEmit` 等）
2. 连续 2 次相同 bash 命令 → 死循环信号，须立即用 edit 或求援
3. 「觉察即阻断」：thought 中意识到循环时必须立即调用 edit，禁止再产生下一个 thought
4. 禁止任何空转模式
5. 反循环规则放在文件最顶部，模型第一眼可见
6. Agent 权限改为 `edit: allow` + `bash: ask`，每次 bash 需要用户确认

## 关键开发经验

### install.ps1 编码问题
Windows PowerShell 5.1 默认不识别 UTF-8 无 BOM 的中文字符，会报解析错误。
**解决方案**：
1. `.ps1` 文件必须以 **UTF-8 BOM** 编码保存
2. 脚本开头添加编码设置：
   ```powershell
   [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
   $OutputEncoding = [System.Text.Encoding]::UTF8
   ```

### PowerShell 编码处理
在 PowerShell 中保存带有 BOM 的 UTF-8 文件：
```powershell
$path = "..."
$content = Get-Content -Raw -Encoding UTF8 $path
$utf8Bom = New-Object System.Text.UTF8Encoding $true
[System.IO.File]::WriteAllText($path, $content, $utf8Bom)
```

### 全局安装路径
opencode 的全局 skill 和 agent 存放在：
- `~\.config\opencode\skills\<name>\SKILL.md`
- `~\.config\opencode\agents\<name>.md`

安装后需重启 opencode 生效。

### Git 注意事项
- `.opencode/.gitignore` 已经配置忽略 `node_modules/`, `package.json`, `package-lock.json`
- `项目要求.txt` 不应纳入版本控制
- `install.sh` 需设置执行权限：`git update-index --chmod=+x install.sh`

### 模型适配要点
- **deepseek**：在提示词中强调逐步推理链（chain-of-thought）分析每个问题
- **kimi**：利用长上下文优势，强调全局代码结构理解
- 所有提示词以中文编写，输出使用结构化 Markdown

## 发布流程
1. 更新版本号（SKILL.md, Agent.md, install.ps1, install.sh）
2. 同步更新到全局 `~\.config\opencode\` 对应位置
3. 提交 git、打 tag、push
4. 通知用户重启 opencode
