#!/bin/bash

# XDG_CONFIG_GOME is the path where config files
# should go. By convention $HOME/.config.
export XDG_CONFIG_HOME="$HOME"/.config

# Remove potentially existing config files
rm ~/.zshrc
rm ~/.zsh_profile

# Apply symlinks using stow. The structure of the .dotfiles repo
# mirros the structure of the symlinks that will get generated
stow .

# Get the font out of the way first, it's the most annoying
mkdir -p $HOME/.local/share/fonts
cp $PWD/fonts/UbuntuMono* $HOME/.local/share/fonts
