# 宇尘审查器 (Yuchen Reviewer)

![Version](https://img.shields.io/badge/version-v1.0.0-blue)

一个强大的 opencode 代码审查工具，覆盖 Bug 检测、安全漏洞分析、性能评估和架构审查四大维度。深度适配中文语境与 deepseek、kimi 等模型。

## 特性

- 🔍 四大审查维度：Bug / 安全 / 性能 / 架构
- 🤖 双模式使用：自动触发 Skill + 手动选择 Agent
- 🌐 全局安装：一次安装，任何项目可用
- 🛡️ 内置防死循环行为准则
- 🇨🇳 中文母语输出，结构化报告

## 安装

### 全局安装（推荐）

在任何目录下使用宇尘审查器：

**Windows (PowerShell):**
```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

**Linux/macOS:**
```bash
chmod +x install.sh && ./install.sh
```

安装后重启 opencode 即可生效。

### 项目级安装

```bash
git clone https://github.com/<your-username>/yuchen-reviewer.git
cd yuchen-reviewer
```

然后在 opencode 中打开项目目录即可自动加载。

## 使用方法

### 方法一：自动触发（Skill）

在对话中提出代码审查需求，例如：

> 帮我审查一下这段代码有没有bug
> 检查这段代码的安全问题
> 分析一下这个函数的性能
> review 一下这个模块的架构

宇尘审查器 Skill 会自动激活并执行审查。

### 方法二：手动选择（Agent）

在 opencode 的 agent 选择界面中选择 **宇尘审查器** 代理，然后粘贴或描述代码即可。

## 审查维度

| 维度 | 说明 |
|------|------|
| 🐛 Bug / 逻辑错误 | 边界条件、并发问题、资源管理、状态错误、类型转换等 |
| 🔒 安全漏洞 | 注入攻击、敏感信息泄露、权限缺失、输入验证等 |
| ⚡ 性能问题 | 算法复杂度、内存分配、循环低效、缓存策略等 |
| 🏗️ 架构设计 | 耦合/内聚、职责分离、循环依赖、扩展性等 |

## 输出格式

每个问题包含：严重级别（Critical/Major/Minor）、文件位置、问题维度、详细说明和修复建议。

## 许可证

MIT
