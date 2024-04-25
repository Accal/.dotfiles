# Custom Aliases
alias vim="nvim"
alias gimme="brew install"
alias k="kubectl"
alias h="helm"

VIM="nvim"

bindkey -s ^f "tmux-sessionizer\n"

PATH="$HOME/Library/Python/3.8/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fzf --zsh)"

export PATH

