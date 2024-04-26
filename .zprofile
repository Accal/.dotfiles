# ─── XDG ──────────────────────────────────────────────────────────────────────
export XDG_CONFIG_HOME="$HOME/.config"

# ─── Homebrew (cross-platform: macOS ARM64, macOS Intel, Linux) ───────────────
if   [[ -x /opt/homebrew/bin/brew ]];              then eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]];                 then eval "$(/usr/local/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ─── PATH ─────────────────────────────────────────────────────────────────────
PATH="$HOME/.local/bin:$PATH"

# AWS Session Manager Plugin (Linux path — skip on macOS where it installs elsewhere)
[[ "$(uname)" == "Linux" ]] && PATH="/usr/local/sessionmanagerplugin/bin:$PATH"

export PATH

# ─── Environment ──────────────────────────────────────────────────────────────
export GIT_EDITOR=nvim
export SOPS_AGE_KEY_FILE="$HOME/keys.txt"

# ─── mise shims (for non-interactive contexts: scripts, cron, etc.) ───────────
command -v mise &>/dev/null && eval "$(mise activate zsh --shims)"
