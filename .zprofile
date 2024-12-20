export XDG_CONFIG_HOME=$HOME/.config
VIM="nvim"

PERSONAL=$HOME/personal
WORK=$HOME/work

for i in `find -L $PERSONAL`; do
    source $i
done

for i in `find -L $WORK`; do
    source $i
done

export GIT_EDITOR=$VIM

# Custom Aliases
alias vim="nvim"
alias gimme="brew install"
alias k="kubectl"
alias h="helm"

VIM="nvim"

bindkey -s ^f "tmux-sessionizer\n"

PATH="$HOME/.local/bin:$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fzf --zsh)"

export PATH
