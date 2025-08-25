#!/bin/bash

if ! command -v nvim &>/dev/null; then
  yay -S --noconfirm --needed neovim luarocks tree-sitter-cli

  # Install LazyVim
  rm -rf ~/.config/nvim
fi

if [[ ! -d "$HOME/.config/nvim" ]]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  cp -R ~/.local/share/omarchy/config/nvim/* ~/.config/nvim/
  rm -rf ~/.config/nvim/.git
  echo "vim.opt.relativenumber = false" >>~/.config/nvim/lua/config/options.lua
fi
