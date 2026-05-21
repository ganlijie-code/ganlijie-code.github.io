# 使用 GitHub Pages 发布

本章说明如何将本 Quarto Book 部署到 GitHub Pages，访问地址为：

**[https://ganlijie-code.github.io/ds2026_G03_ex_Team02/](https://ganlijie-code.github.io/ds2026_G03_ex_Team02/)**

## 发布流程

> **Step 1**：确保 `docs` 文件夹在主分支

- 运行 `quarto render` 后，HTML 输出位于项目根目录的 `docs/` 文件夹。

> **Step 2**：推送本地代码到 GitHub

1. 在 GitHub Desktop 或命令行中提交更改。
2. 确保主分支（`main`）与远程仓库 `ganlijie-code/ds2026_G03_ex_Team02` 同步。

> **Step 3**：在 GitHub 仓库中启用 Pages

1. 打开仓库 **Settings** → **Pages**
2. **Source** 选择 “Deploy from a branch”
3. **Branch**：`main`（或当前主分支）
4. **Folder**：`/docs`
5. 保存设置。

> **Step 4**：访问网页

等待数分钟后访问：[https://ganlijie-code.github.io/ds2026_G03_ex_Team02/](https://ganlijie-code.github.io/ds2026_G03_ex_Team02/)

::: {.callout-note}
### 注意事项

- 每次修改书稿后需重新运行 `quarto render`，并将更新后的 `docs/` 推送到 GitHub。
- `_quarto.yml` 中的 `site-url` 须与上述 Pages 地址一致，否则站内链接可能错误。
:::

## 本地重新编译

在项目根目录执行：

```bash
quarto render
```

Windows 下若未全局安装 Quarto，可使用本仓库同级的便携版：

```powershell
G:\ganlijie\page\tools\quarto\bin\quarto.exe render
```

## 参考文档

- [GitHub Pages 官方指南](https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages)
- [Quarto 发布到 GitHub Pages](https://quarto.org/docs/publishing/github-pages.html)
