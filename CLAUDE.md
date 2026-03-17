# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A LazyVim-based Neovim configuration for React/TypeScript and C++/OpenGL development. Built on [LazyVim](https://lazyvim.org) (a Lazy.nvim distribution), it extends the defaults minimally through `lua/plugins/` and `lazyvim.json`.

## Architecture

- **`init.lua`** — entry point; just calls `require("config.lazy")`
- **`lua/config/lazy.lua`** — bootstraps Lazy.nvim, loads LazyVim core + `lua/plugins/*`
- **`lua/config/`** — `options.lua`, `keymaps.lua`, `autocmds.lua` (mostly empty; LazyVim defaults apply)
- **`lua/plugins/`** — custom plugin specs that extend or override LazyVim
- **`lazyvim.json`** — controls which LazyVim extras are enabled (edit via `:LazyExtras` in Neovim)
- **`lazy-lock.json`** — pinned plugin commits; update with `:Lazy update` in Neovim or `nvim --headless "+Lazy! update" +qa`

## Enabled LazyVim Extras

Managed via `lazyvim.json` (use `:LazyExtras` to toggle):

- **AI**: `ai.claudecode`, `ai.copilot`
- **Coding**: `coding.mini-comment`, `coding.mini-snippets`, `coding.mini-surround`, `coding.yanky`
- **Editor**: `editor.dial`, `editor.inc-rename`
- **Formatting**: `formatting.prettier`
- **Languages**: `lang.astro`, `lang.clangd`, `lang.cmake`, `lang.git`, `lang.helm`, `lang.json`, `lang.markdown`, `lang.toml`, `lang.typescript`
- **Test**: `test.core`
- **Util**: `util.dot`, `util.mini-hipatterns`


## Custom Plugin Configs (`lua/plugins/`)

| File | Purpose |
|------|---------|
| `colorscheme.lua` | Sets tokyonight as the active colorscheme |
| `git.lua` | Enables gitsigns inline blame (`  <author>, <date> - <summary>`) |
| `snippets.lua` | Loads friendly-snippets via LuaSnip's VS Code loader |
| `test.lua` | Configures neotest-jest with `node_modules/.bin/jest` and `CI=true` |
| `glsl.lua` | GLSL support: glsl-analyzer LSP (via Mason) and treesitter grammar |
| `example.lua` | Disabled example patterns (returns `{}`) |

## Code Style

Lua files use **StyLua** for formatting:
- 2-space indentation
- 120-character line width

Format with: `stylua lua/`

## Adding/Modifying Plugins

To override a LazyVim plugin or add a new one, add a spec file under `lua/plugins/`. LazyVim merges specs by plugin name, so you only need to specify the keys you want to change:

```lua
return {
  { "plugin/name", opts = { some_option = true } },
}
```

To disable a LazyVim-included plugin:
```lua
return {
  { "plugin/name", enabled = false },
}
```
