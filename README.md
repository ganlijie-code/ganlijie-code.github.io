# 长鑫科技估值研究 · Quarto Book（ds2026_G03_ex_Team02）

**在线阅读**：**https://ganlijie-code.github.io/ds2026_G03_ex_Team02/**  
源码仓库：[ganlijie-code/ganlijie-code.github.io](https://github.com/ganlijie-code/ganlijie-code.github.io)

参考 [Quarto Book 示例](https://lianxhcn.github.io/quarto_book/) 组织。本书发布在用户站点的子路径 `/ds2026_G03_ex_Team02/`（`gh-pages` 分支对应该目录）。

## 目录结构

```
├── _quarto.yml          # site-url 已指向子路径
├── index.qmd
├── chapters/
├── images/
├── scripts/sync_images.ps1
└── _book/               # 本地渲染（勿提交）
```

## 推送到 GitHub

本书已配置为发布到 **`gh-pages/ds2026_G03_ex_Team02/`**，对应 URL 子路径。

在 `ganlijie-code.github.io` 仓库中，推荐将本书放在 **`ds2026_G03_ex_Team02/` 子目录**（与现有 `ds2026-G03-T-A2` 等并列），并使用仓库根目录工作流 `.github/workflows/publish-ds2026_G03_ex_Team02.yml`。

本地已准备在 `DS/_pages_deploy/` 的合并提交，使用 **ganlijie-code** 账号推送：

```powershell
Set-Location G:\ganlijie\git\DS\_pages_deploy
git push origin main
```

若单独维护本书目录，也可将 `ds2026_G03_ex_Team02/` 整体复制进上述仓库后提交。

## 启用 GitHub Pages

仓库 **Settings → Pages**：

- **Source**：Deploy from a branch  
- **Branch**：`gh-pages` / **(root)**

访问地址：**https://ganlijie-code.github.io/ds2026_G03_ex_Team02/**

## 本地开发

```powershell
# 同步插图（在 DS 根目录）
Set-Location G:\ganlijie\git\DS
.\ds2026_G03_ex_Team02\scripts\sync_images.ps1

# 渲染（子路径预览与线上一致）
Set-Location G:\ganlijie\git\DS\ds2026_G03_ex_Team02
quarto render
quarto preview
```

## 插图路径

相对 `chapters/`：`../images/fig*.png`
