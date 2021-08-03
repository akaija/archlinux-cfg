#!/bin/sh

# Dependencies
sudo pacman -S chromium i3-gaps i3lock i3status git rxvt-unicode rofi \
	ttf-monoid vim xorg-server xorg-xinit xorg-xrandr zsh

# Configuration files
cp xinitrc ~/.xinitrc; cp Xresources ~/.Xresources
cp Xkbd /etc/X11/xorg.config.d/00-keyboard.conf
mkdir -p .config/i3; cp i3-gaps ~/.config/i3/config
mkdir -p .config/i3status; cp i3status ~/.config/i3status/config
cp zshrc ~/.zshrc

# Configure vim
cat "set autoindent noexpandtab tabstop=8 softtabstop=2 shiftwidth=2" | \
	sudo tee -a /etc/vimrc > /dev/null

# Install cursor
mkdir -p ~/dev/co; cd ~/dev/co
git clone https://aur.archlinux.org/bibata-cursor-translucent.git
cd bibata-cursor-translucent; makepkg -si; cd

# Change shell
chsh -s /bin/zsh
source ~/.zshrc

# Reboot
sudo reboot
