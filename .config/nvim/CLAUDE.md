# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Prerequisites

- Neovim 0.11+ (required for `vim.lsp.enable()`, `vim.diagnostic.jump()`)
- `ripgrep` — used by Telescope live grep
- `make` — required to build `telescope-fzf-native`
- `git` — lazy.nvim bootstraps itself via git

## Applying Changes

No build or test step. Changes take effect by:
- Restarting Neovim
- `:so` or `<leader><leader>` to source the current file in-session

Plugin management: `:Lazy` (sync, update, clean)
LSP/formatter installer: `:Mason`

## Architecture

```
init.lua                   ← entry: requires core then lazy
lua/ammar/
  core/
    init.lua               ← requires options + keymaps
    set.lua                ← vim.opt settings, filetype detection
    remap.lua              ← global keymaps; sets mapleader = " "
  lazy.lua                 ← bootstraps lazy.nvim, imports plugins/
  plugins/                 ← one file per concern, each returns a lazy spec table
    colorscheme.lua        ← catppuccin-macchiato
    treesitter.lua         ← syntax highlighting + indent
    telescope.lua          ← fuzzy finding + fzf-native
    lsp.lua                ← mason + mason-lspconfig + nvim-lspconfig + lazydev
    completion.lua         ← blink.cmp + friendly-snippets
    formatting.lua         ← conform.nvim (format on save)
    harpoon.lua            ← harpoon v2 (quick file marks)
    git.lua                ← fugitive + gitsigns + diffview
    editor.lua             ← mini.pairs, nvim-surround, undotree, which-key, todo-comments, tmux-navigator
    claude.lua             ← claude-code.nvim
after/plugin/              ← intentionally empty stubs (migrated to plugins/)
```

`lazy.lua` uses `{ import = "ammar.plugins" }` which auto-imports every file in `plugins/`. No manual registration needed when adding a new plugin file.

## Key Conventions

**Adding a plugin**: create a new file in `lua/ammar/plugins/` that returns a lazy spec table. It will be picked up automatically.

**Adding an LSP server**: install via `:Mason`, then add to `ensure_installed` in `plugins/lsp.lua`. Custom server config goes in the `handlers` table.

**Adding a formatter**: install via `:MasonInstall <tool>`, then add to `formatters_by_ft` in `plugins/formatting.lua`.

**Global keymaps** go in `core/remap.lua`. Plugin-specific keymaps go in the plugin's `keys` spec (preferred — lazy loads on first keypress) or in `config`.

**`<C-h>` is bound to Harpoon mark 1** — this intentionally overrides vim-tmux-navigator's left-pane binding. Do not "fix" this.

**`<C-j>`/`<C-k>` are tmux navigation** — quickfix uses `]q`/`[q` instead to avoid conflicts.

## Full Keybinding Reference

See `CHEATSHEET.md`.
