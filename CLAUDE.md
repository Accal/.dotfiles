# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

A dotfiles repository for macOS (ARM64 + Intel) and Linux, managed with [chezmoi](https://www.chezmoi.io/). The canonical source checkout lives at `~/.local/share/chezmoi`, and `chezmoi apply` materializes real files under `$HOME`.

## Installation

```sh
chezmoi diff
chezmoi apply --dry-run --verbose
chezmoi apply
```

Chezmoi scripts are idempotent and use `bash` with `set -euo pipefail`. Source-root files such as `README.md`, `CLAUDE.md`, `AGENTS.md`, `Brewfile`, and `LinuxPackages` support the repository and are not applied to `$HOME`.

## Repository Layout

```
Brewfile            ← declarative package list for macOS
LinuxPackages       ← conservative Linux package manifest
.chezmoi.toml.tmpl  ← Chezmoi config template with age encryption config
dot_zprofile        ← login shell: brew init, PATH, env vars, mise shims
dot_zshrc           ← interactive shell: OMZ, aliases, mise, fzf, keybindings
dot_config/
  nvim/             ← Neovim config (see dot_config/nvim/CLAUDE.md for details)
  tmux/
    tmux.conf       ← Tmux config (prefix: Ctrl+A, vim pane navigation)
    dot_tmux-cht-languages  ← language list for tmux-cht.sh
    dot_tmux-cht-command    ← command list for tmux-cht.sh
  alacritty/        ← Alacritty terminal (Catppuccin Macchiato, UbuntuMono Nerd Font)
  git/ignore        ← Global gitignore (comprehensive)
dot_local/bin/
  executable_tmux-sessionizer  ← fzf-based tmux session switcher (bound to Ctrl+F / prefix+f)
  executable_tmux-cht.sh       ← cht.sh lookup tool (bound to prefix+i)
private_dot_claude/ ← Claude-specific config and encrypted secrets
```

## Shell Configuration

**`.zprofile`** — login shell only: Homebrew cross-platform init (`HOMEBREW_PREFIX` set here), PATH (`~/.local/bin` + conditional Linux paths), `GIT_EDITOR`, `SOPS_AGE_KEY_FILE`, mise shims.

**`.zshrc`** — every interactive shell: Oh My Zsh (plugins: `git kubectl helm aws fzf zsh-autosuggestions zsh-syntax-highlighting`), Powerlevel10k theme, all aliases, `bindkey`, mise full activation, fzf shell integration, version-agnostic OpenSSL flags.

**Version manager**: `mise` (replaces asdf). `mise activate zsh --shims` runs in `.zprofile` for scripts; `mise activate zsh` runs in `.zshrc` for interactive use.

## Key Conventions

- **Color scheme**: Catppuccin Macchiato across all tools (Neovim, Tmux, Alacritty).
- **Editor**: Neovim — `vim` alias and `GIT_EDITOR` both point to `nvim`.
- **Claude**: one default profile at `~/.claude`.
- **Agent config scope**: no cross-provider sync for skills/prompts/MCP; keep agent configuration local to each tool.
- **Superpowers**: managed as an official Claude plugin (`superpowers@claude-plugins-official`) via `private_dot_claude/settings.json`.
- **Other agent capabilities**: prefer official plugins first; if no plugin equivalent exists, install from upstream source per provider instead of vendoring in this repo.
- **Cross-platform paths**: Use `$HOMEBREW_PREFIX` (set by `.zprofile`) rather than hardcoding `/opt/homebrew`.
- **`.config/git/ignore`** is the global gitignore — covers common build artifacts, secrets, and editor files.

## Package Management

macOS: `brew bundle --file=Brewfile` is run by Chezmoi. To add a package, add it to `Brewfile`.

Linux: Chezmoi scripts detect apt-get / dnf / pacman and install packages listed in `LinuxPackages`. `mise` falls back to `curl https://mise.run | sh` if the package manager does not provide it.

## Neovim

Full architecture and conventions are documented in `dot_config/nvim/CLAUDE.md`. Keybinding reference is in `dot_config/nvim/CHEATSHEET.md`.
