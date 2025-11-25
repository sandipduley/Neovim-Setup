# 🌟 Neovim Setup

A fast, modern, and highly customized Neovim configuration optimized for
development.\
This setup includes **LSP support, syntax highlighting, fuzzy finding,
formatting, linting**, and various quality-of-life enhancements.

---

## 📌 Requirements

You need **Neovim version above 0.10.x**.\
Some plugins do not work well below **0.11.x**.

If your version is lower, build Neovim from source:\
https://github.com/neovim/neovim/blob/master/INSTALL.md

### ✔️ Required

1.  **Neovim** version **above 0.11.x**
2.  **lua 5.4**
3.  **luarocks**
4.  **Nerd Fonts**
5.  **LuaJIT**
6.  **ripgrep**
7.  **fzf**
8.  **go**
9.  **python3**
10.  **nodejs**
11.  **npm**
12.  **clang**
13.  **gcc**
14.  **make**
15.  **cmake**
---

## 📦 Install Global NPM LSP Servers

```bash
npm install -g vscode-langservers-extracted
npm install -g bash-language-server
npm install -g yaml-language-server
npm install -g dockerfile-language-server-nodejs
npm install -g docker-compose-language-service
npm install -g tailwindcss-language-server
npm install -g sql-language-server
npm install -g typescript-language-server typescript
```
---

## You can install more LSP Servers using Mason
```bash
:Mason
```
---

## 📁 Neovim Folder Structure

    nvim
    ├── init.lua
    ├── lazy-lock.json
    ├── lazyvim.json
    └── lua
        ├── core
        │   ├── keymaps.lua
        │   ├── options.lua
        │   └── snippets.lua
        └── plugins
            ├── alpha.lua
            ├── autocompletion.lua
            ├── bufferline.lua
            ├── cmp.lua
            ├── colortheme.lua
            ├── comments.lua
            ├── debug.lua
            ├── indent-blankline.lua
            ├── lsp.lua
            ├── lualine.lua
            ├── misc.lua
            ├── neotree.lua
            ├── none-ls.lua
            ├── telescope.lua
            ├── treesitter.lua
            └── undotree.lua
---
