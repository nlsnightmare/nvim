# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Personal Neovim configuration (Neovim 0.13-dev; requires 0.11+ for the native `vim.lsp.config` API). Plugins are managed by lazy.nvim.

## Commands

- Reload the edited file into the running instance: `<leader><leader>` (`:so`)
- Plugin manager UI: `<C-l>` or `:Lazy`
- Sync plugins headless: `nvim --headless "+Lazy! sync" +qa`
- Format Lua: `stylua .` (stylua defaults — tabs, width 4; there is no `stylua.toml`)
- Check config health: `:checkhealth`
- Tests here mean tests of the *edited project*, not this repo: `<leader>tr` / `:Neotest run` (phpunit adapter only)

`lazy-lock.json` is committed; plugin version bumps show up as changes to it.

## Load order

1. `init.lua` → `require("maru")` → `lua/maru/init.lua` (all `vim.opt` settings, WSL clipboard detection) → `lua/maru/keys.lua` (leader = space, global non-plugin maps).
2. `require("lazy").setup("plugins")` — lazy.nvim imports **every file** in `lua/plugins/`, each returning a spec table (or a list of them). Adding a plugin = adding a file there; no central registry to update. `lua/plugins/init.lua` is the catch-all for small plugins that need no config (colorschemes, mason, autopairs, commentary…).
3. `after/plugin/*.lua` runs after all plugins are loaded: `lsp.lua` (LSP + LspAttach keymaps), `colors.lua` (colorscheme selection via the global `SetColorScheme()` function), `treesitter.lua` (fully commented out).
4. `after/ftplugin/<ft>.lua` — per-filetype indent width only.

## Conventions

- **LSP is configured natively**, not through `lspconfig.setup()`. Servers are declared with `vim.lsp.config("name", {...})` and turned on with a single `vim.lsp.enable({...})` list in `after/plugin/lsp.lua`. Servers with no override are enabled straight from that list. Buffer-local LSP keymaps live in the `LspAttach` autocmd there.
- **Indentation: hard tabs**, `expandtab = false`, width 4 globally; `after/ftplugin/` overrides width to 2 for lua/html/blade/typescript. Lua files in this repo are tab-indented.
- **Formatting** is conform.nvim (`lua/plugins/conform.lua`) via `format_after_save`, with `lsp_fallback`. Set `vim.b.disable_autoformat = true` to opt a buffer out — `lua/maru/init.lua` does this for `*/mails/**.blade.php` and friends.
- **Linting** is nvim-lint (`lua/plugins/lint.lua`), re-run on `BufWritePost`/`BufReadPost`/`InsertLeave`.
- **Completion** is blink.cmp with LuaSnip; snippets are snipmate-format files in `snippets/<ft>.snippets`, edited via `:EditSnippets`. Neovim has no built-in detection for `*.snippets`, so `lua/maru/init.lua` registers the `snippets` filetype and the LuaSnip spec carries `ft = "snippets"` — that pairing is what puts LuaSnip's own `syntax/`+`ftplugin/` for the format on the runtimepath.
- **New-file templates** are skel-nvim: glob → `skeleton/*.skel` in `lua/plugins/skel.lua`, with `@KEY@` markers filled by the `substitutions` callbacks (which receive `config.filename`). `NAMESPACE` branches on extension: `php.skel` derives it from the path after `/app/`, `cs.skel` from `maru.snippets.namespace()` (`dotnet msbuild -getProperty:RootNamespace` on the nearest `.csproj`, plus the folders below it). Note the plugin's built-in mappings (`*.lua`, `*.py`, `*.go`…) stay active but have no matching `.skel` file here.
- **Snippet/template helpers live in `lua/maru/snippets.lua`** — a plain module, no globals. Snippets reach it with `` `v:lua.require'maru.snippets'.fn()` `` backticks (LuaSnip evaluates backtick contents as a vim expression). `class_name(name?)` is the snake_case→PascalCase helper, defaulting to the buffer's filename.
- Call such a helper at **every** occurrence in a snippet. Do not wrap it in a `${1:...}` tabstop to get mirrors — the snipmate parser turns a tabstop whose default contains a backtick into a non-interactive dynamicNode, and its `$1` mirrors then stop tracking edits.
- Filetypes without treesitter grammars (blade, razor) fall back to regex-syntax plugins pulled in by `lua/plugins/treesitter.lua`.

## Gotchas

- `lua/plugins/easymotion.lua` actually configures **leap.nvim**; the `<Plug>(easymotion-*)` maps still in `lua/maru/keys.lua:26-27` are dead — the plugin is gone.
- `<leader>pi` in `keys.lua` sources a `lua/maru/packer.lua` that no longer exists.
