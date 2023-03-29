export PATH="$HOME/.bin:$PATH"

short_codespace_name="$(echo "$CODESPACE_NAME" | sed -Ee 's/^georgebrock-(.+)-[^-]+$/\1/')"
export PS1="\[\033[00;33m\]${short_codespace_name:-\h} \[\033[00;36m\]\W\[\033[31m\]\$ \[\033[0m\]"

export EDITOR=vim
export VISUAL=vim

alias psg="ps auxwww | head -n 1 ; ps auxwww | grep -Ei"
alias ll="ls -l"

export HISTFILESIZE=10000
export CLICOLOR=1
export LSCOLORS=gxFxCxDxBxegedabagacad

# Completion
export hostname_completion_file=~/.bash_hosts
complete -A hostname ssh

for path in $(ls -a ~/.bash_profile.*); do
  source $path
done
