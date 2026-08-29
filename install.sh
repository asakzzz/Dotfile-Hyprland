#!/bin/bash


read -p "Do you want to install GPU drivers now? (y/n): " confirm
if [[ "$confirm" == [yY] || "$confirm" == [yY][eE][sS] ]]; then
    
    yay -S --noconfirm linux-headers nvidia-580xx-utils nvidia-580xx-dkms
else
    echo "Skipping drivers."
fi


DOTFILES_DIR=$(pwd)

echo "--- Installing Packages ---"
yay -S  --noconfirm --needed rofi discord steam spotify noctalia-shell \
    docker docker-compose zen-browser-bin visual-studio-code 
    make thunar fastfetch kitty zsh


if [ -d "$DOTFILES_DIR/hypr" ]; then
    rm -rf --no-preserve-root ~/.config/hypr 2>/dev/null || sudo rm -rf ~/.config/hypr
    cp -r "$DOTFILES_DIR/hypr" ~/.config/
else
    echo "Notice: hypr folder not found in dotfiles, skipping."
fi

echo "--- Linking .config Directories ---"
configs=( "kitty" "noctalia" "rofi" "fastfetch")

for config in "${configs[@]}"; do
    if [ -d "$DOTFILES_DIR/$config" ]; then
        TARGET="$HOME/.config/$config"

        rm -rf "$TARGET"

        cp -r "$DOTFILES_DIR/$config" "$TARGET"
        echo "copied $config to ~/.config/"
    fi
done

echo "--- Linking Assets ---"

if [ -d "$DOTFILES_DIR/Wallpapers" ]; then
    rm -rf "$HOME/Downloads/Wallpapers"
    cp -r "$DOTFILES_DIR/Wallpapers" "$HOME/Downloads/Wallpapers"
fi

echo "--- Setting Zsh as Default Shell ---"
if [[ "$SHELL" != */zsh ]]; then
    echo "Changing your default shell to zsh..."
    chsh -s "$(which zsh)"
else
    echo "Zsh is already your default shell."
fi

echo "--- Linking Home Dotfiles ---"
home_files=(".zshrc" ".profile" ".zprofile , .p10k.zsh")

for file in "${home_files[@]}"; do
    if [ -f "$DOTFILES_DIR/$file" ]; then
        cp  "$DOTFILES_DIR/$file" "$HOME/$file"
        echo "Linked $file to $HOME/"
    else
        echo "Notice: $file not found in $DOTFILES_DIR, skipping."
    fi
done

echo "--- Installing Oh My Zsh ---"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "Oh My Zsh installed."
else
    echo "Oh My Zsh already installed, skipping."
fi


echo "--- Setup Complete! ---"
