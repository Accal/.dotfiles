# Repository Guidelines

## Project Structure & Module Organization
This repo is a Chezmoi-managed home directory source for macOS and Linux. The canonical checkout lives at `~/.local/share/chezmoi`. Chezmoi source names use attributes such as `dot_`, `private_`, `executable_`, and `encrypted_`: `dot_zshrc` applies to `~/.zshrc`, `dot_config/nvim/` applies to `~/.config/nvim/`, and `dot_local/bin/executable_tmux-sessionizer` applies as an executable helper script. Shared cross-agent assets live under `private_dot_ai` and Claude-specific settings/secrets live under `private_dot_claude`. Source-root files such as `README.md`, `AGENTS.md`, `Brewfile`, and `LinuxPackages` support the repo and are not applied to `$HOME`.

## Build, Test, and Development Commands
- `chezmoi diff`: preview changes against the real home directory.
- `chezmoi apply --dry-run --verbose`: validate planned changes before applying.
- `chezmoi apply`: apply managed files and run Chezmoi scripts.
- `brew bundle --file=Brewfile`: install or refresh macOS packages declared in `Brewfile`.
- `zsh -n dot_zprofile dot_zshrc`: syntax-check shell changes before committing.
- `tmux -f dot_config/tmux/tmux.conf start-server && tmux kill-server`: validate tmux config parses cleanly.
- `nvim --headless '+Lazy! sync' +qa`: smoke-test Neovim config and plugin declarations.

## Coding Style & Naming Conventions
Match the style already present in each file instead of reformatting broadly. Shell scripts use `bash` with `set -euo pipefail`, uppercase env vars, and descriptive helper names. Use 4-space indentation in shell blocks and existing Lua plugin/module naming under `dot_config/nvim/lua/ammar/`. Keep filenames aligned to Chezmoi source naming and the tool they configure: `dot_zshrc`, `tmux.conf`, `alacritty.toml`, `ignore`, `config.yml`.

## Testing Guidelines
There is no centralized automated test suite yet. Validate changes with `chezmoi diff`, `chezmoi apply --dry-run --verbose`, and the tool-specific commands above. Do a targeted runtime check when behavior is interactive, for example opening a new `tmux` session or launching `nvim`. If you change `run_*` scripts, preserve idempotency.

## Commit & Pull Request Guidelines
Recent history uses short, imperative subjects like `Add stow` and `Prepare repo for stow`; continue using short imperative subjects, ideally under 72 characters. Keep Chezmoi migration commits focused by concern: scaffolding/scripts, source layout conversion, encrypted secrets, cleanup, and docs. PRs should explain the user-facing change, note OS scope (`macOS`, `Linux`, or both), list validation commands run, and include screenshots only when UI-facing configs such as Alacritty visibly change.

## Security & Configuration Tips
Do not commit machine-specific secrets or tokens in plaintext. Use Chezmoi encryption for approved secrets such as `dot_config/gh/encrypted_hosts.yml.age` and `private_dot_claude/encrypted_dot_claude.json.age`. Do not manage accidental runtime state such as `.local/state`, `.local/share`, `.local/pipx`, `dot_config/tmux/plugins`, app caches, Claude/Codex histories, or generated output. Prefer `$HOMEBREW_PREFIX` and other existing environment-driven paths over hardcoded system paths to preserve cross-platform behavior.
