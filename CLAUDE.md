# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

A dotfiles repository for macOS (ARM64 + Intel) and Linux, managed with [GNU Stow](https://www.gnu.org/software/stow/). The directory structure mirrors `$HOME` — running `stow .` from the repo root creates symlinks at the corresponding paths under `~`.

## Installation

```sh
./setup.sh      # Full bootstrap: packages, Oh My Zsh + plugins, Stow symlinks
stow .          # Re-apply symlinks only (safe to re-run; uses --adopt + git checkout)
```

`setup.sh` is idempotent — safe to re-run. It uses `set -euo pipefail` and will exit on any error.

`.stow-local-ignore` excludes `setup.sh`, `Brewfile`, `CLAUDE.md`, `README.md`, `fonts/`, and git internals from being symlinked. Fonts are copied manually to `~/Library/Fonts` (macOS) or `~/.local/share/fonts` (Linux).

## Repository Layout

```
Brewfile            ← declarative package list (macOS only, used by setup.sh)
setup.sh            ← bootstrap script (cross-platform: macOS ARM64/Intel + Linux)
.zprofile           ← login shell: brew init, PATH, env vars, mise shims
.zshrc              ← interactive shell: OMZ, aliases, mise, fzf, keybindings
.config/
  nvim/             ← Neovim config (see .config/nvim/CLAUDE.md for details)
  tmux/
    tmux.conf       ← Tmux config (prefix: Ctrl+A, vim pane navigation)
    plugins/tpm/    ← TPM checked in; other plugins installed by TPM on first run
    .tmux-cht-languages  ← language list for tmux-cht.sh
    .tmux-cht-command    ← command list for tmux-cht.sh
  alacritty/        ← Alacritty terminal (Catppuccin Macchiato, UbuntuMono Nerd Font)
  git/ignore        ← Global gitignore (comprehensive)
.local/bin/
  tmux-sessionizer  ← fzf-based tmux session switcher (bound to Ctrl+F / prefix+f)
  tmux-cht.sh       ← cht.sh lookup tool (bound to prefix+i)
fonts/              ← UbuntuMono Nerd Font .ttf files (copied by setup.sh, not symlinked)
```

## Shell Configuration

**`.zprofile`** — login shell only: Homebrew cross-platform init (`HOMEBREW_PREFIX` set here), PATH (`~/.local/bin` + conditional Linux paths), `GIT_EDITOR`, `SOPS_AGE_KEY_FILE`, mise shims.

**`.zshrc`** — every interactive shell: Oh My Zsh (plugins: `git kubectl helm aws fzf zsh-autosuggestions zsh-syntax-highlighting`), Powerlevel10k theme, all aliases, `bindkey`, mise full activation, fzf shell integration, version-agnostic OpenSSL flags.

**Version manager**: `mise` (replaces asdf). `mise activate zsh --shims` runs in `.zprofile` for scripts; `mise activate zsh` runs in `.zshrc` for interactive use.

## Key Conventions

- **Color scheme**: Catppuccin Macchiato across all tools (Neovim, Tmux, Alacritty).
- **Editor**: Neovim — `vim` alias and `GIT_EDITOR` both point to `nvim`.
- **`claude` command is aliased away** — use `claude-personal` or `claude-work` to target specific Claude CLI configs.
- **Cross-platform paths**: Use `$HOMEBREW_PREFIX` (set by `.zprofile`) rather than hardcoding `/opt/homebrew`.
- **`.config/git/ignore`** is the global gitignore — covers common build artifacts, secrets, and editor files.

## Package Management

macOS: `brew bundle --file=Brewfile` (called by `setup.sh`). To add a package, add it to `Brewfile`.

Linux: `setup.sh` detects apt-get / dnf / pacman and installs a core set. `mise` is installed via `curl https://mise.run | sh`.

## Neovim

Full architecture and conventions are documented in `.config/nvim/CLAUDE.md`. Keybinding reference is in `.config/nvim/CHEATSHEET.md`.
