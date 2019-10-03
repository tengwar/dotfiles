#!/bin/bash
# Where to symlink various dotfiles

# gitconfig -> ~/.config/git/config
# On macOS: ln -s ~/Code/dotfiles/gitconfig ~/.gitconfig
ln -s ~/Code/dotfiles/gitconfig ~/.config/git/config
echo "Please install diff-highlight or diffr manually."

# vimrc -> ~/.vim/vimrc
# If you set up Vim to support the XGD standard, use $XDG_CONFIG_HOME/vim/vimrc
ln -s ~/Code/dotfiles/vimrc ~/.vim/vimrc

# bash_profile -> ~/.bash_profile
ln -s ~/Code/dotfiles/bash_profile ~/.bash_profile
# bashrc -> ~/.bashrc
ln -s ~/Code/dotfiles/bashrc ~/.bashrc
# bash_private -> ~/.bash_private
ln -s ~/Code/dotfiles/bash_private ~/.bash_private
