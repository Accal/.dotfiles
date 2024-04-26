# ─── Powerlevel10k instant prompt (must be near top) ─────────────────────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ─── Oh My Zsh ────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    kubectl
    helm
    aws
    fzf
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ─── Aliases ──────────────────────────────────────────────────────────────────
alias vim="nvim"
alias gimme="brew install"
alias k="kubectl"
alias h="helm"

alias claude-personal="CLAUDE_CONFIG_DIR=$HOME/.claude-personal command claude"
alias claude-work="CLAUDE_CONFIG_DIR=$HOME/.claude-work command claude"
alias claude="echo 'Use claude-personal or claude-work'"

# ─── Keybindings (after OMZ, which resets keymaps) ───────────────────────────
bindkey -s ^f "tmux-sessionizer\n"

# ─── mise (interactive shell: full hook with completions) ────────────────────
command -v mise &>/dev/null && eval "$(mise activate zsh)"

# ─── fzf shell integration ────────────────────────────────────────────────────
command -v fzf &>/dev/null && eval "$(fzf --zsh)"

# ─── OpenSSL (brew-managed, version-agnostic) ────────────────────────────────
if [[ -n "${HOMEBREW_PREFIX:-}" && -d "$HOMEBREW_PREFIX/opt/openssl@3" ]]; then
    export LDFLAGS="-L$HOMEBREW_PREFIX/opt/openssl@3/lib"
    export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/openssl@3/include"
    export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/openssl@3/lib/pkgconfig"
fi

# ─── Powerlevel10k config ─────────────────────────────────────────────────────
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
