#!/bin/bash

# XDG_CONFIG_GOME is the path where config files
# should go. By convention $HOME/.config.
export XDG_CONFIG_HOME="$HOME"/.config

# Make directories where projects live
mkdir $HOME/personal
mkdir $HOME/work

# Install brew as package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Set up brew initially. Will be overwritten by our config files
echo >> /Users/$(whoami)/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$(whoami)/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Remove potentially existing config files
rm ~/.zshrc
rm ~/.zsh_profile
rm ~/.zprofile

# Install needed packaged with brew
brew install --cask firefox
brew install --cask alacritty
brew install stow
brew install neovim
brew install tmux
brew install zsh
brew install fzf
brew install ripgrep

# Use zsh that brew installed instead of OS X default
# https://rick.cogley.info/post/use-homebrew-zsh-instead-of-the-osx-default/
if [[ $(which zsh) == /bin/zsh ]]; then
	sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
fi

# Apply symlinks using stow. The structure of the .dotfiles repo
# mirros the structure of the symlinks that will get generated
stow .

# Install needed NerdFont for oh-my-zsh
mkdir -p $HOME/.local/share/fonts
cp $PWD/fonts/UbuntuMono* $HOME/Library/fonts

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
