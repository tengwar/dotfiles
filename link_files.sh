#!/bin/bash
# Where to symlink various dotfiles

# gitconfig -> ~/.config/git/config
# On macOS: ln -s ~/Code/dotfiles/gitconfig ~/.gitconfig
# On Windows add this to ~/.gitconfig file:
# [include]
#    path = C:\\Users\\Username\\Code\\dotfiles\\gitconfig
ln -s ~/Code/dotfiles/gitconfig ~/.config/git/config
echo "Please install a diff highlighter manually."

# vimrc -> ~/.vim/vimrc
# If you set up Vim to support the XGD standard, use $XDG_CONFIG_HOME/vim/vimrc
ln -s ~/Code/dotfiles/vimrc ~/.vim/vimrc

# bash_profile -> ~/.bash_profile
ln -s ~/Code/dotfiles/bash_profile ~/.bash_profile
# bashrc -> ~/.bashrc
ln -s ~/Code/dotfiles/bashrc ~/.bashrc
# bash_private -> ~/.bash_private
ln -s ~/Code/dotfiles/bash_private ~/.bash_private
