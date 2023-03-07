#!/bin/bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x


if [[ "$CODESPACES" = "true" ]]; then
  rm ~/.bashrc
  sudo apt-get install -y rcm tmux universal-ctags
  rcup -f -v -d . -t linux -t development -t github

  if [[ -d /etc/ssh ]]; then
    echo 'AcceptEnv TZ LC_*' >> /etc/ssh/sshd_config
  fi

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

if [[ "$CODESPACES" = "true" ]]; then
  # Default to HTTPS for GitHub access
  git config --global url.https://github.com/.insteadOf git@github.com:
fi
