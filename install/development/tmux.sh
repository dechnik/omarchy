#!/bin/bash

yay -S --noconfirm --needed \
  tmux pstree fd sesh-bin

mkdir -p ~/.config/tmux/plugins

rm -rf ~/.config/tmux/plugins/tmux-fzf && git clone https://github.com/sainnhe/tmux-fzf.git ~/.config/tmux/plugins/tmux-fzf
rm -rf ~/.config/tmux/plugins/tmux-yank && git clone https://github.com/tmux-plugins/tmux-yank.git ~/.config/tmux/plugins/tmux-yank
rm -rf ~/.config/tmux/plugins/tmux-resurrect && git clone https://github.com/tmux-plugins/tmux-resurrect.git ~/.config/tmux/plugins/tmux-resurrect
rm -rf ~/.config/tmux/plugins/tmux-continuum && git clone https://github.com/tmux-plugins/tmux-continuum.git ~/.config/tmux/plugins/tmux-continuum
