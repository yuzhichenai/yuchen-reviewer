#!/bin/bash
# 宇尘审查器 - 全局安装脚本 (Linux/macOS)
# 运行方式: chmod +x install.sh && ./install.sh

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
GLOBAL_DIR="$HOME/.config/opencode"

echo "正在安装宇尘审查器到全局 opencode 配置..."

mkdir -p "$GLOBAL_DIR/skills/宇尘审查器"
mkdir -p "$GLOBAL_DIR/agents"

cp "$REPO_DIR/.opencode/skills/宇尘审查器/SKILL.md" "$GLOBAL_DIR/skills/宇尘审查器/SKILL.md"
cp "$REPO_DIR/.opencode/agents/宇尘审查器.md" "$GLOBAL_DIR/agents/宇尘审查器.md"

echo "✅ 宇尘审查器 v1.0.0 安装成功！"
echo "请重启 opencode 以生效。"
