# 宇尘审查器 - 全局安装脚本 (Windows PowerShell)
# 运行方式: 右键 -> 使用 PowerShell 运行，或 powershell -ExecutionPolicy Bypass -File install.ps1

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$repoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$globalDir = "$env:USERPROFILE\.config\opencode"

Write-Host "正在安装宇尘审查器到全局 opencode 配置..." -ForegroundColor Cyan

# 创建目录
New-Item -ItemType Directory -Path "$globalDir\skills\宇尘审查器" -Force | Out-Null
New-Item -ItemType Directory -Path "$globalDir\agents" -Force | Out-Null

# 复制文件
Copy-Item -Path "$repoDir\.opencode\skills\宇尘审查器\SKILL.md" -Destination "$globalDir\skills\宇尘审查器\SKILL.md" -Force
Copy-Item -Path "$repoDir\.opencode\agents\宇尘审查器.md" -Destination "$globalDir\agents\宇尘审查器.md" -Force

Write-Host "✅ 宇尘审查器 v1.0.0 安装成功！" -ForegroundColor Green
Write-Host "请重启 opencode 以生效。" -ForegroundColor Yellow
