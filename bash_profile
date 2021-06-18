export PATH="~/.bin:$PATH"

source ~/.bin/git-completion.sh
export PS1="\[\033[00;33m\]\h \[\033[00;36m\]\W\[\033[31m\]\$ \[\033[0m\]"

export EDITOR=vim
export VISUAL=vim

alias g=git
alias gc="git commit -v"
alias gca="git commit --amend -v"
alias gs="git status"
alias gd="git diff"
alias gds="git diff --stat"
alias gdc="git diff --cached"
alias ga="git add"
alias gf="git fetch"
alias gb="git branch"
alias gg="git grep -En"

alias psg="ps auxwww | head -n 1 ; ps auxwww | grep -Ei"
alias ll="ls -l"

export RUBYOPT='rubygems'
export HISTFILESIZE=10000
export CLICOLOR=1
export LSCOLORS=gxFxCxDxBxegedabagacad
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB.UTF-8"

# Completion
export hostname_completion_file=~/.bash_hosts
complete -A hostname ssh

export GPG_TTY=$(tty)

[[ -s ~/.bash_profile.local ]] && source ~/.bash_profile.local
