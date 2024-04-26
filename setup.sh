#!/usr/bin/env bash
set -euo pipefail
trap 'echo "Error on line $LINENO — exit code: $?" >&2' ERR

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"
ARCH="$(uname -m)"

is_macos() { [[ "$OS" == "Darwin" ]]; }
is_linux() { [[ "$OS" == "Linux" ]]; }
command_exists() { command -v "$1" &>/dev/null; }

# ─── Directories ──────────────────────────────────────────────────────────────
create_dirs() {
    mkdir -p "$HOME/personal" "$HOME/work"
}

# ─── Package installation ─────────────────────────────────────────────────────
install_packages() {
    if is_macos; then
        # Detect Homebrew prefix (ARM64 vs Intel)
        if [[ "$ARCH" == "arm64" ]]; then
            BREW_BIN="/opt/homebrew/bin/brew"
        else
            BREW_BIN="/usr/local/bin/brew"
        fi

        if ! command_exists brew; then
            echo "Installing Homebrew..."
            NONINTERACTIVE=1 /bin/bash -c \
                "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi

        eval "$("$BREW_BIN" shellenv)"
        echo "Installing packages from Brewfile..."
        brew bundle --file="$DOTFILES_DIR/Brewfile"

    elif is_linux; then
        echo "Installing packages for Linux..."
        if command_exists apt-get; then
            sudo apt-get update -qq
            sudo apt-get install -y curl git zsh stow neovim tmux fzf ripgrep jq wget
        elif command_exists dnf; then
            sudo dnf install -y curl git zsh stow neovim tmux fzf ripgrep jq wget
        elif command_exists pacman; then
            sudo pacman -Sy --noconfirm curl git zsh stow neovim tmux fzf ripgrep jq wget
        else
            echo "No supported package manager found (apt-get, dnf, pacman). Install packages manually." >&2
            exit 1
        fi

        # Install mise (version manager) — single binary, works on all distros
        if ! command_exists mise; then
            echo "Installing mise..."
            curl https://mise.run | sh
        fi
    fi
}

# ─── Default shell ────────────────────────────────────────────────────────────
configure_shell() {
    local zsh_path
    zsh_path="$(command -v zsh)"

    if [[ "$SHELL" != "$zsh_path" ]]; then
        echo "Setting default shell to $zsh_path..."
        # Add to /etc/shells if not present
        if ! grep -qF "$zsh_path" /etc/shells; then
            echo "$zsh_path" | sudo tee -a /etc/shells
        fi
        if is_macos; then
            sudo dscl . -create "/Users/$USER" UserShell "$zsh_path"
        else
            chsh -s "$zsh_path"
        fi
    fi
}

# ─── Oh My Zsh ────────────────────────────────────────────────────────────────
install_omz() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        echo "Installing Oh My Zsh..."
        RUNZSH=no CHSH=no \
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
}

# ─── Zsh plugins ──────────────────────────────────────────────────────────────
install_zsh_plugins() {
    local custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    if [[ ! -d "$custom/plugins/zsh-autosuggestions" ]]; then
        echo "Installing zsh-autosuggestions..."
        git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
            "$custom/plugins/zsh-autosuggestions"
    fi

    if [[ ! -d "$custom/plugins/zsh-syntax-highlighting" ]]; then
        echo "Installing zsh-syntax-highlighting..."
        git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting \
            "$custom/plugins/zsh-syntax-highlighting"
    fi
}

# ─── Powerlevel10k ────────────────────────────────────────────────────────────
install_powerlevel10k() {
    local theme_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    if [[ ! -d "$theme_dir" ]]; then
        echo "Installing Powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$theme_dir"
    fi
}

# ─── Fonts ────────────────────────────────────────────────────────────────────
install_fonts() {
    if is_macos; then
        local font_dest="$HOME/Library/Fonts"
    else
        local font_dest="$HOME/.local/share/fonts"
        mkdir -p "$font_dest"
    fi

    echo "Installing UbuntuMono Nerd Fonts..."
    cp "$DOTFILES_DIR/fonts/"UbuntuMono*.ttf "$font_dest/"

    if is_linux; then
        fc-cache -f "$font_dest"
    fi
}

# ─── Stow symlinks ────────────────────────────────────────────────────────────
# TPM is already checked into the repo at .config/tmux/plugins/tpm — stow will
# symlink it into ~/.config/tmux/plugins/tpm automatically.
stow_dotfiles() {
    echo "Applying symlinks with stow..."
    cd "$DOTFILES_DIR"
    # --adopt moves any conflicting files from $HOME into the repo,
    # then git checkout restores our intended versions.
    stow --adopt .
    git checkout -- .
}

# ─── Main ─────────────────────────────────────────────────────────────────────
main() {
    echo "==> Setting up dotfiles from $DOTFILES_DIR"
    create_dirs
    install_packages
    configure_shell
    install_omz
    install_zsh_plugins
    install_powerlevel10k
    install_fonts
    stow_dotfiles
    echo ""
    echo "Done! Start a new shell session to apply changes."
    echo "Run 'p10k configure' if you haven't set up your prompt yet."
    if is_macos; then
        echo "Run 'tmux new-session' then press Ctrl+A I to install tmux plugins."
    fi
}

main "$@"
