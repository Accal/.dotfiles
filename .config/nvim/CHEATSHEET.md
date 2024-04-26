# Neovim Cheatsheet

**Leader**: `<Space>`

---

## File Navigation

| Key | Action |
|-----|--------|
| `-` | Open explorer in current file's directory |
| `<leader>pv` | File explorer (netrw) |
| `<leader>pf` | Find files (Telescope) |
| `<C-p>` | Find git-tracked files (Telescope) |
| `<leader>ps` | Live grep (Telescope) |
| `<leader>pb` | Open buffers (Telescope) |
| `<leader>ph` | Help tags (Telescope) |
| `<leader>pt` | TODOs (Telescope) |

---

## Harpoon — Quick File Marks

| Key | Action |
|-----|--------|
| `<leader>a` | Mark current file |
| `<C-e>` | Toggle quick menu |
| `<C-h>` | Jump to mark 1 |
| `<C-t>` | Jump to mark 2 |
| `<C-n>` | Jump to mark 3 |
| `<C-s>` | Jump to mark 4 |
| `<C-S-P>` | Previous mark |
| `<C-S-N>` | Next mark |

> `<C-h>` is bound to Harpoon mark 1, which takes priority over tmux-navigator left.

---

## LSP (active on any LSP-attached buffer)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>vd` | View diagnostic (float) |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<leader>f` | Format buffer (conform, LSP fallback) |

**Manage servers**: `:Mason`
**Installed by default**: `lua_ls`, `pyright`, `gopls`, `ruby_lsp`, `terraformls`, `cssls`

---

## Completion (blink.cmp)

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<CR>` | Accept item |
| `<C-e>` | Cancel |
| `<Tab>` / `<S-Tab>` | Navigate items / snippet placeholders |
| `<C-b>` / `<C-f>` | Scroll docs |

Signature help shows automatically while typing function arguments.

---

## Formatting (conform.nvim)

Format on save is **enabled by default** for configured filetypes.
`<leader>f` formats manually at any time.

Install formatters: `:MasonInstall stylua black isort prettier goimports`

---

## Git

| Key | Action |
|-----|--------|
| `<leader>gs` | Git status (Fugitive) |
| `<leader>gd` | Diff view (diffview) |
| `<leader>gh` | File history (diffview) |
| `]c` / `[c` | Next / prev hunk (gitsigns) |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage entire buffer |
| `<leader>hu` | Undo staged hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line (full) |
| `<leader>hd` | Diff this file |

Inside `:Git` (Fugitive): `s` stage · `u` unstage · `cc` commit · `=` inline diff · `dv` vimdiff

---

## Surround (nvim-surround)

| Key | Action |
|-----|--------|
| `ys<motion><char>` | Add surround (e.g. `ysiw"` wraps word in `"`) |
| `ds<char>` | Delete surround |
| `cs<old><new>` | Change surround |

---

## Undo Tree

| Key | Action |
|-----|--------|
| `<leader>u` | Toggle undo tree |

---

## Quickfix / Location List

| Key | Action |
|-----|--------|
| `]q` / `[q` | Next / prev quickfix item |
| `]l` / `[l` | Next / prev location list item |
| `]t` / `[t` | Next / prev TODO comment |

---

## Clipboard & Editing

| Key | Action |
|-----|--------|
| `<leader>y` | Yank to system clipboard |
| `<leader>Y` | Yank line to system clipboard |
| `<leader>d` | Delete to void (no clipboard) |
| `<leader>p` (visual) | Paste without overwriting clipboard |
| `<leader>s` | Find & replace word under cursor |
| `<leader>x` | `chmod +x` current file |

---

## Motion Tweaks

| Key | Action |
|-----|--------|
| `J` (normal) | Join lines, cursor stays in place |
| `J` / `K` (visual) | Move selected lines down / up |
| `<C-d>` / `<C-u>` | Scroll half-page, keep cursor centered |
| `n` / `N` | Next / prev search result, centered |
| `Q` | Disabled (prevents accidental Ex mode) |
| `<C-c>` (insert) | Escape |

---

## Tmux Navigation (vim-tmux-navigator)

| Key | Action |
|-----|--------|
| `<C-j>` | Navigate down |
| `<C-k>` | Navigate up |
| `<C-l>` | Navigate right |
| `<C-\>` | Navigate to previous pane |
| `<C-f>` | Open tmux sessionizer in new window |

---

## Misc

| Key | Action |
|-----|--------|
| `<leader>cc` | Toggle Claude Code panel |
| `<leader><leader>` | Source current file (`:so`) |

Press `<leader>` and wait to see a hint popup (which-key).

---

## Installed Plugins

| Plugin | Purpose |
|--------|---------|
| catppuccin/nvim | Colorscheme (Macchiato) |
| nvim-telescope/telescope.nvim | Fuzzy finder |
| telescope-fzf-native | Native FZF sorter (faster) |
| nvim-treesitter | Syntax highlighting & indent |
| williamboman/mason.nvim | LSP/tool installer |
| neovim/nvim-lspconfig | LSP client configuration |
| folke/lazydev.nvim | Lua LSP (vim API completions) |
| saghen/blink.cmp | Completion engine |
| rafamadriz/friendly-snippets | Snippet collection |
| stevearc/conform.nvim | Formatter (format on save) |
| ThePrimeagen/harpoon (v2) | Fast file marking |
| lewis6991/gitsigns.nvim | Inline git signs & blame |
| tpope/vim-fugitive | Git workflow |
| sindrets/diffview.nvim | Diff viewer & merge tool |
| mbbill/undotree | Visual undo history |
| echasnovski/mini.pairs | Auto-close pairs |
| kylechui/nvim-surround | Surround text objects |
| folke/which-key.nvim | Keymap hints popup |
| folke/todo-comments.nvim | Highlight TODOs in code |
| christoomey/vim-tmux-navigator | Vim/tmux pane navigation |
| greggh/claude-code.nvim | Claude Code CLI |
