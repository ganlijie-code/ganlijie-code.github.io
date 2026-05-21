# 将上级 DS/output 下图表复制到 ds2026_G03_ex_Team02/images/（本书独立部署用）
$bookRoot = Split-Path $PSScriptRoot -Parent
$dsRoot   = Split-Path $bookRoot -Parent
$src      = Join-Path $dsRoot "output"
$dst      = Join-Path $bookRoot "images"

if (-not (Test-Path $src)) {
    Write-Warning "未找到 $src 。若在独立仓库中部署，请直接将 PNG 放入 $dst"
    exit 1
}

New-Item -ItemType Directory -Force -Path $dst | Out-Null
Copy-Item -Path (Join-Path $src "*.png") -Destination $dst -Force -ErrorAction SilentlyContinue
$n = (Get-ChildItem $dst -Filter "*.png" -ErrorAction SilentlyContinue).Count
Write-Host "已同步 $n 个 PNG 到 $dst"
