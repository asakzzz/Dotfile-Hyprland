#!/bin/bash

DOTFILES_DIR=$(pwd)

echo "--- Installing Packages ---"
yay -S  --noconfirm hyprland rofi discord steam spotify noctalia-shell \
    docker docker-compose zen-browser-bin visual-studio-code \
    make thunar fastfetch kitty ttf-font-awesome \
    zsh

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/share/icons"
mkdir -p "$HOME/Downloads/Wallpapers"

echo "--- Linking .config Directories ---"
configs=("hypr" "kitty" "noctalia" "rofi" "fastfetch")

for config in "${configs[@]}"; do
    if [ -d "$DOTFILES_DIR/$config" ]; then
        ln -sfn "$DOTFILES_DIR/$config" "$HOME/.config/$config"
        echo "Linked $config to ~/.config/"
    fi
done

echo "--- Linking Home Dotfiles ---"
home_files=(".zshrc" ".profile" ".zprofile")

for file in "${home_files[@]}"; do
    if [ -f "$DOTFILES_DIR/zsh/$file" ]; then
        ln -sfn "$DOTFILES_DIR/zsh/$file" "$HOME/$file"
        echo "Linked $file to $HOME/"
    else
        echo "Notice: $file not found in $DOTFILES_DIR/zsh/, skipping."
    fi
done

echo "--- Linking Assets ---"
# Link Icons
if [ -d "$DOTFILES_DIR/icons" ]; then
    ln -sfn "$DOTFILES_DIR/icons" "$HOME/.local/share/icons/my-icons"
    echo "Linked icons"
fi

if [ -d "$DOTFILES_DIR/Wallpapers" ]; then
    ln -sfn "$DOTFILES_DIR/Wallpapers" "$HOME/Downloads/Wallpapers"
    echo "Linked Wallpapers"
fi

echo "--- Setting Zsh as Default Shell ---"
if [[ "$SHELL" != */zsh ]]; then
    echo "Changing your default shell to zsh..."
    chsh -s "$(which zsh)"
else
    echo "Zsh is already your default shell."
fi

echo "--- Setup Complete! ---"
echo "Remember to install your GPU drivers before rebooting."