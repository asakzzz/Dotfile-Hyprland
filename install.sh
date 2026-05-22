#!/bin/bash

echo "--- Installing Packages ---"
yay -S --needed hyprland rofi discord steam spotify noctalia-shell \
    docker docker-compose zen-browser-bin visual-studio-code \
    make thunar fastfetch kitty ttf-font-awesome 

DOTFILES_DIR=$(pwd)
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/share/icons"


echo "--- Linking Configs ---"
configs=("hypr" "kitty" "noctalia" "rofi" "fastfetch")

for config in "${configs[@]}"; do
    if [ -d "$DOTFILES_DIR/$config" ]; then
        ln -sfn "$DOTFILES_DIR/$config" "$HOME/.config/$config"
        echo "Linked $config to ~/.config/"
    fi
done


if [ -d "$DOTFILES_DIR/icons" ]; then
    echo "--- Linking Cursors ---"
    ln -sfn "$DOTFILES_DIR/icons" "$HOME/.local/share/icons/my-icons"
    ln -sfn "$DOTFILES_DIR/icons" "$HOME/.icons"
    echo "Linked icons/cursors"
fi

if [ -d "$DOTFILES_DIR/Wallpapers" ]; then
    echo "--- Linking Wallpapers ---"
    ln -sfn "$DOTFILES_DIR/Wallpapers" "$HOME/Pictures/Wallpapers"
    echo "Linked Wallpapers to ~/Pictures/Wallpapers"
fi

echo "--- Setup Complete! ---"
echo "Before rebooting , download the necessary drivers for your graphic card"