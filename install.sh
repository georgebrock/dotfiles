#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x


if [[ "$CODESPACES" = "true" ]]; then
  sudo apt-get install -y rcm tmux
  rcup -f -v -d . -t linux -t development
elif [[ "$(uname)" = "Darwin" ]]; then
  brew install rcm
  rcup -v -t macos
  rcup -v
else
  >&2 echo "error: Unknown system"
  exit 1
fi

if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qa
