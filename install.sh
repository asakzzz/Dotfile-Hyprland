#!/bin/bash


read -p "Do you want to install GPU drivers now? (y/n): " confirm
if [[ "$confirm" == [yY] || "$confirm" == [yY][eE][sS] ]]; then
    
    yay -S linux-headers nvidia-580xx-utils nvidia-580xx-dkms
else
    echo "Skipping drivers."
fi


DOTFILES_DIR=$(pwd)

echo "--- Installing Packages ---"
yay -S  --noconfirm --needed rofi discord steam spotify noctalia-shell \
    docker docker-compose zen-browser-bin visual-studio-code \
    make thunar fastfetch kitty ttf-font-awesome \
    zsh

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/share/icons"
mkdir -p "$HOME/Downloads/Wallpapers"

echo "--- Linking .config Directories ---"
configs=("hypr" "kitty" "noctalia" "rofi" "fastfetch")

echo "--- Linking .config Directories ---"
configs=("hypr" "kitty" "noctalia" "rofi" "fastfetch")

for config in "${configs[@]}"; do
    if [ -d "$DOTFILES_DIR/$config" ]; then
        TARGET="$HOME/.config/$config"
        
        # Forcefully remove whatever is currently there (file, folder, or symlink)
        # No sudo needed for your own home folder!
        if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
            echo "Cleaning up existing configuration at $TARGET"
            rm -rf "$TARGET"
        fi
        
        # Link cleanly without trailing slashes
        ln -sf "$DOTFILES_DIR/$config" "$TARGET"
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

echo "--- Linking Home Dotfiles ---"
home_files=(".zshrc" ".profile" ".zprofile")

for file in "${home_files[@]}"; do
    if [ -f "$DOTFILES_DIR/$file" ]; then
        ln -sfn "$DOTFILES_DIR/$file" "$HOME/$file"
        echo "Linked $file to $HOME/"
    else
        echo "Notice: $file not found in $DOTFILES_DIR, skipping."
    fi
done


echo "--- Setup Complete! ---"
echo "Remember to install your GPU drivers before rebooting."