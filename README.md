# dotfiles

Personal development environment for macOS (ARM64 + Intel) and Linux, managed with [GNU Stow](https://www.gnu.org/software/stow/).

**Theme**: Catppuccin Macchiato across all tools · **Editor**: Neovim · **Shell**: Zsh + Oh My Zsh + Powerlevel10k · **Terminal**: Alacritty · **Multiplexer**: Tmux

---

## Installation

```sh
git clone https://github.com/ammarrahic/.dotfiles ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

`setup.sh` is fully idempotent — safe to re-run at any time. After it completes, start a new shell session.

**What `setup.sh` does:**
1. Installs Homebrew (macOS) or uses apt/dnf/pacman (Linux)
2. Installs all packages from `Brewfile` (macOS) or a core set (Linux)
3. Installs mise (version manager)
4. Sets the default shell to the Homebrew/system zsh
5. Installs Oh My Zsh, zsh-autosuggestions, zsh-syntax-highlighting, Powerlevel10k
6. Copies UbuntuMono Nerd Fonts to the system font directory
7. Applies symlinks via `stow --adopt` + `git checkout` (handles pre-existing files)

**Re-apply symlinks only** (after pulling changes):
```sh
cd ~/.dotfiles && stow --adopt . && git checkout -- .
```

**Add a package** (macOS): add it to `Brewfile`, then `brew bundle`.

---

## Repository Structure

```
Brewfile                         macOS package list (brew bundle)
setup.sh                         bootstrap script
.zprofile                        login shell: brew init, PATH, env vars, mise shims
.zshrc                           interactive shell: OMZ, aliases, mise, fzf, keybindings
.config/
  nvim/                          Neovim config  ← see .config/nvim/CLAUDE.md
    lua/ammar/
      core/set.lua               vim.opt settings
      core/remap.lua             global keymaps (leader = Space)
      plugins/                   one file per plugin, auto-imported by lazy.nvim
    CHEATSHEET.md                full keybinding reference
  tmux/
    tmux.conf                    tmux config (prefix: Ctrl+A)
    plugins/tpm/                 TPM checked in; other plugins installed by TPM
    .tmux-cht-languages          language list for cheat.sh lookup
    .tmux-cht-command            command list for cheat.sh lookup
  alacritty/
    alacritty.toml               terminal config (font, theme, keybindings)
    themes/catppuccin-macchiato.toml
  git/
    ignore                       global gitignore
.local/bin/
  tmux-sessionizer               fzf-based tmux session switcher
  tmux-cht.sh                    cht.sh lookup via fzf
fonts/                           UbuntuMono Nerd Font .ttf files (copied, not symlinked)
```

---

## Shell (Zsh)

### What's specific about this setup

- **`.zprofile` vs `.zshrc`**: Login-only config (brew init, PATH, env vars) lives in `.zprofile`. Everything interactive (aliases, keybindings, completions, prompt) lives in `.zshrc`. This prevents double-sourcing and keeps non-interactive shells fast.
- **Cross-platform Homebrew**: `.zprofile` detects the brew prefix automatically (`/opt/homebrew` on Apple Silicon, `/usr/local` on Intel, `/home/linuxbrew/.linuxbrew` on Linux). Use `$HOMEBREW_PREFIX` in scripts — never hardcode the path.
- **mise (version manager)**: Replaces asdf. Login shells get `mise activate zsh --shims` (makes shims available in scripts/cron). Interactive shells get `mise activate zsh` (full hook with completions and PATH). Tool versions are declared in `.tool-versions` files per project.
- **Claude profiles**: Two separate Claude CLI configs (`~/.claude-personal`, `~/.claude-work`) are accessed via aliases. The bare `claude` command is intentionally blocked.

### Aliases

| Alias | Expands to |
|-------|-----------|
| `vim` | `nvim` |
| `gimme` | `brew install` |
| `k` | `kubectl` |
| `h` | `helm` |
| `claude-personal` | `CLAUDE_CONFIG_DIR=~/.claude-personal claude` |
| `claude-work` | `CLAUDE_CONFIG_DIR=~/.claude-work claude` |
| `claude` | *(blocked — use the above)* |

### Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+F` | Open tmux-sessionizer in a new tmux window |

### mise — version manager

```sh
# Install a language version
mise install node@22
mise install python@3.12
mise use node@22          # set version for current project (.tool-versions)
mise use -g python@3.12   # set global default

# List installed / available
mise list
mise ls-remote python

# Run a command with a specific version
mise exec python@3.11 -- python script.py
```

---

## Tmux

### What's specific about this setup

- **Prefix**: `Ctrl+A` (remapped from default `Ctrl+B` — easier to reach)
- **Base index**: Windows and panes start at `1`, not `0`
- **Shell**: Uses `$SHELL` — follows whatever shell is set as default
- **Seamless Vim navigation**: `vim-tmux-navigator` lets `Ctrl+J/K/L` move between tmux panes and Neovim splits without thinking about which is which. `Ctrl+H` is reserved for Harpoon in Neovim (see below).
- **Copy mode**: vi-key bindings. `v` begins selection, `y` copies to system clipboard (via tmux-yank).
- **Splits open in current directory**: `"` and `%` pass `#{pane_current_path}`.
- **Session scripts**: `prefix+f` launches tmux-sessionizer (fzf over project dirs). `prefix+i` opens a cht.sh cheat sheet lookup.
- **Theme**: Catppuccin Macchiato. Status bar shows: current application · session name · uptime.

### Prefix: `Ctrl+A`

### Session management

| Key / Command | Action |
|---------------|--------|
| `prefix + f` | Open tmux-sessionizer (fzf project switcher) |
| `prefix + $` | Rename session |
| `tmux ls` | List sessions |
| `tmux attach -t <name>` | Attach to session |
| `tmux kill-session -t <name>` | Kill session |

### Windows

| Key | Action |
|-----|--------|
| `prefix + c` | New window |
| `prefix + ,` | Rename window |
| `prefix + &` | Kill window |
| `prefix + 1-9` | Switch to window N |
| `Shift+Left / Shift+Right` | Previous / next window (no prefix) |
| `Alt+H / Alt+L` | Previous / next window (no prefix) |

### Panes

| Key | Action |
|-----|--------|
| `prefix + "` | Split horizontally (current path) |
| `prefix + %` | Split vertically (current path) |
| `prefix + x` | Kill pane |
| `prefix + z` | Zoom pane (toggle fullscreen) |
| `prefix + h/j/k/l` | Select pane (vim-style, requires prefix) |
| `Alt+Arrow` | Select pane (no prefix) |
| `Ctrl+J / K / L` | Select pane / nvim split (vim-tmux-navigator, no prefix) |

### Copy mode (vi)

| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `v` | Begin selection |
| `Ctrl+V` | Toggle rectangle selection |
| `y` | Copy selection to system clipboard and exit |
| `q` | Exit copy mode |

### Plugin management (TPM)

| Key | Action |
|-----|--------|
| `prefix + I` | Install plugins |
| `prefix + U` | Update plugins |
| `prefix + Alt+U` | Uninstall removed plugins |

### Cheat sheet lookup

`prefix + i` opens an interactive fzf picker sourced from `.config/tmux/.tmux-cht-languages` and `.config/tmux/.tmux-cht-command`. After picking, type a query to look up on [cht.sh](https://cht.sh).

---

## Neovim

**Leader key**: `Space`

### What's specific about this setup

- **Plugin manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) with `{ import = "ammar.plugins" }` — every file in `lua/ammar/plugins/` is auto-imported. Add a plugin by creating a new file there.
- **Completion**: [blink.cmp](https://github.com/Saghen/blink.cmp) (faster alternative to nvim-cmp) with `friendly-snippets` and signature help enabled.
- **Formatting**: [conform.nvim](https://github.com/stevearc/conform.nvim) with **format-on-save enabled** for all configured filetypes. `<leader>f` formats at any time.
- **LSP servers** (auto-installed via Mason): `lua_ls`, `pyright`, `gopls`, `ruby_lsp`, `terraformls`, `cssls`.
- **Formatters** (install manually via `:MasonInstall`): `stylua`, `black`, `isort`, `prettier`, `goimports`, `terraform_fmt`.
- **Harpoon vs tmux-navigator conflict**: `<C-h>` is bound to Harpoon mark 1, which intentionally takes priority over vim-tmux-navigator's "navigate left" binding. Use tmux `Alt+Left` or `prefix+h` to navigate left in tmux instead.
- **HCL/Terraform**: Comment string is set to `#` (not `//`). `Jenkinsfile` is detected as Groovy.
- **Persistent undo**: Undo history survives file closes — stored in `~/.vim/undodir`.
- **Claude integration**: `<leader>cc` opens a profile picker (Work / Personal). `<leader>cw` / `<leader>cp` switch directly.

### File navigation

| Key | Action |
|-----|--------|
| `-` | Open explorer in current file's directory |
| `<leader>pv` | File explorer (netrw) |
| `<leader>pf` | Find files (Telescope) |
| `<C-p>` | Find git-tracked files (Telescope) |
| `<leader>ps` | Live grep (Telescope + ripgrep) |
| `<leader>pb` | Open buffers (Telescope) |
| `<leader>ph` | Help tags (Telescope) |
| `<leader>pt` | TODO comments (Telescope) |

### Harpoon — quick file marks

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

### LSP

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
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>f` | Format buffer |

**Add an LSP server**: install via `:Mason`, then add to `ensure_installed` in `lua/ammar/plugins/lsp.lua`.

### Completion (blink.cmp)

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion |
| `<CR>` | Accept item |
| `<C-e>` | Cancel |
| `<Tab>` / `<S-Tab>` | Navigate items / snippet placeholders |
| `<C-b>` / `<C-f>` | Scroll docs |

Signature help shows automatically while typing function arguments.

### Git

| Key | Action |
|-----|--------|
| `<leader>gs` | Git status (Fugitive) |
| `<leader>gd` | Diff view (DiffView) |
| `<leader>gh` | File history (DiffView) |
| `]c` / `[c` | Next / prev hunk (Gitsigns) |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage entire buffer |
| `<leader>hu` | Undo staged hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line (full) |
| `<leader>hd` | Diff this file |

Inside `:Git` (Fugitive): `s` stage · `u` unstage · `cc` commit · `=` inline diff · `dv` vimdiff

### Surround (nvim-surround)

| Key | Action |
|-----|--------|
| `ys<motion><char>` | Add surround — e.g. `ysiw"` wraps word in `"` |
| `ds<char>` | Delete surround |
| `cs<old><new>` | Change surround |

### Clipboard & editing

| Key | Action |
|-----|--------|
| `<leader>y` / `<leader>Y` | Yank to system clipboard |
| `<leader>d` | Delete to void (clipboard untouched) |
| `<leader>p` (visual) | Paste without overwriting clipboard |
| `<leader>s` | Find & replace word under cursor |
| `<leader>x` | `chmod +x` current file |
| `<leader>u` | Toggle undo tree |

### Motion tweaks

| Key | Action |
|-----|--------|
| `<C-d>` / `<C-u>` | Scroll half-page, cursor stays centered |
| `n` / `N` | Next / prev search result, centered |
| `J` (normal) | Join lines, cursor stays in place |
| `J` / `K` (visual) | Move selected lines down / up |
| `<C-c>` (insert) | Escape |
| `Q` | Disabled (prevents accidental Ex mode) |

### Navigation across tmux and Neovim

| Key | Action |
|-----|--------|
| `<C-j>` | Move to pane / split below |
| `<C-k>` | Move to pane / split above |
| `<C-l>` | Move to pane / split right |
| `<C-\>` | Move to previous pane |
| `<C-f>` | Open tmux-sessionizer in new window |

### Quickfix / location list

| Key | Action |
|-----|--------|
| `]q` / `[q` | Next / prev quickfix item |
| `]l` / `[l` | Next / prev location list item |
| `]t` / `[t` | Next / prev TODO comment |

### Claude Code (in Neovim)

| Key | Action |
|-----|--------|
| `<leader>cc` | Pick Claude profile (Work / Personal) |
| `<leader>cw` | Switch to Work profile |
| `<leader>cp` | Switch to Personal profile |

### Plugin management

| Command | Action |
|---------|--------|
| `:Lazy` | Open plugin manager UI (sync, update, clean) |
| `:Mason` | Open LSP/tool installer UI |
| `:MasonInstall stylua black isort prettier goimports` | Install formatters |
| `:TSUpdate` | Update all Treesitter parsers |
| `:ConformInfo` | Show formatter status for current buffer |
| `<leader><leader>` | Source current file |

---

## Alacritty

### What's specific about this setup

- **Font**: UbuntuMono Nerd Font, 22pt (sized for high-DPI displays)
- **Shell**: Defaults to `$SHELL` — no hardcoded path
- **Theme**: Catppuccin Macchiato, loaded via `import` from `themes/catppuccin-macchiato.toml`
- **Option key as Alt**: Both left and right Option keys act as Alt, enabling Meta keybindings in Neovim (`M-` mappings)
- **Shift+Return**: Sends `ESC + Return` (`\e\r`), used by some terminal apps to distinguish from plain Return

---

## Fonts

UbuntuMono Nerd Font is stored in `fonts/` and copied (not symlinked) by `setup.sh`:
- macOS: `~/Library/Fonts/`
- Linux: `~/.local/share/fonts/` (followed by `fc-cache -f`)

To update the font, replace the `.ttf` files in `fonts/` and re-run `setup.sh`.

---

## Maintenance

### Update everything

```sh
# Packages
brew upgrade                        # macOS
brew bundle --file=~/.dotfiles/Brewfile  # ensure new Brewfile entries are installed

# Neovim plugins
nvim -c ":Lazy update" -c "qa"

# Tmux plugins
# In a tmux session: prefix + U

# Oh My Zsh
omz update

# mise itself
mise self-update
```

### Add a new tool to the environment

| What | How |
|------|-----|
| New brew package (macOS) | Add to `Brewfile`, run `brew bundle` |
| New package (Linux) | Add to all three distro lists in `setup.sh`'s `install_packages()` |
| New language version | `mise install <lang>@<version>` and add to `.tool-versions` |
| New Neovim plugin | Create `~/.dotfiles/.config/nvim/lua/ammar/plugins/<name>.lua` |
| New LSP server | `:Mason` to install, add to `ensure_installed` in `lsp.lua` |
| New formatter | `:MasonInstall <tool>`, add to `formatters_by_ft` in `formatting.lua` |
| New shell alias | Add to `.zshrc` aliases section |

---

## Troubleshooting

**Stow conflict** — if `stow .` fails with "existing target":
```sh
cd ~/.dotfiles && stow --adopt . && git checkout -- .
```
`--adopt` moves the conflicting file into the repo; `git checkout` restores the dotfile version.

**Fonts not showing in Alacritty** — ensure UbuntuMono Nerd Font is installed and restart Alacritty.

**TPM plugins not loaded** — open a tmux session and press `prefix + I` to install.

**mise shims not found in scripts** — ensure `.zprofile` is sourced (login shell). Check with `mise doctor`.

**Powerlevel10k not configured** — run `p10k configure` to generate `~/.p10k.zsh`.
