#!/bin/bash

# Ensure that script fails as soon as any error reached
set -e

echo "Copy .bashrc config..."
cp ~/.bashrc ./.bashrc

echo "Copy nvim config..."
mkdir -p ./.config/nvim
cp ~/.config/nvim/init.lua ./.config/nvim/init.lua

echo "Copy alacritty config..."
mkdir -p ./.config/alacritty
cp ~/.config/alacritty/alacritty.toml ./.config/alacritty/alacritty.toml
cp ~/.config/alacritty/catppuccin-mocha.toml ./.config/alacritty/catppuccin-mocha.toml

echo "Copy tmux config..."
cp ~/.tmux.conf ./.tmux.conf

