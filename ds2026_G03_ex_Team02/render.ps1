# 本地编译电子书（便携 Quarto 或系统 PATH 中的 quarto）
$quarto = "G:\ganlijie\page\tools\quarto\bin\quarto.exe"
if (-not (Test-Path $quarto)) { $quarto = "quarto" }
Set-Location $PSScriptRoot
& $quarto render
New-Item -ItemType Directory -Force -Path "$PSScriptRoot\docs\body\figures" | Out-Null
Copy-Item "$PSScriptRoot\body\figures\*.png" "$PSScriptRoot\docs\body\figures\" -Force
Copy-Item "$PSScriptRoot\.nojekyll" "$PSScriptRoot\docs\.nojekyll" -Force
Write-Host "输出: $PSScriptRoot\docs\index.html"
