export PATH=./bin/stubs:~/bin:/usr/local/bin:/opt/local/bin:/usr/local/heroku/bin:/usr/local/share/npm/bin:~/code/git-browse/bin:$PATH

source ~/bin/git-completion.sh
export PS1="\[\033[00;36m\]\w\[\033[31m\]\$(__git_ps1 ' %s') > \[\033[0m\]"

bind '"\e3"':'"#"'

alias vim='mvim -v'
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

alias vup="vagrant halt; vagrant up; vagrant ssh -- -t 'cd /vagrant; bash -l'"

alias psg="ps auxwww | head -n 1 ; ps auxwww | grep -Ei"
alias ll="ls -l"

alias brake="bundle exec rake -s"

export RUBYOPT='rubygems'
export HISTFILESIZE=10000
export CLICOLOR=1
export LSCOLORS=gxFxCxDxBxegedabagacad
export HOMEBREW_NO_EMOJI="get off my lawn"
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB.UTF-8"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
