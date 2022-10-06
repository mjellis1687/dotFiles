# Author: Matt Ellis (based on several .bashrc examples)

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# SHELL OPTIONS

# Vi mode in bash
set -o vi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|screen*)
	reset=$(tput sgr0)
	red=$(tput setaf 1)
	blue=$(tput setaf 4)
	green=$(tput setaf 7)
	PS1='\[$red\][\u@\h\[$reset\] \[$blue\]\W\[$reset\]\[$red\]]\$ \[$reset\]\[$green\]'
    ;;
*)
	PS1="\u@\h:\W$ "
    ;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# COMPLETION OPTIONS

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Ignore case in tab complete
bind "set completion-ignore-case on"

# Show if ambiguous
bind "set show-all-if-ambiguous on"

# HISTORY OPTIONS
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# ALIAS

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
[[ -f ${XDG_CONFIG_HOME}/shell/aliases ]] && . ${XDG_CONFIG_HOME}/shell/aliases

# FUNCTIONS

[[ -f ${XDG_CONFIG_HOME}/shell/functions ]] && . ${XDG_CONFIG_HOME}/shell/functions

# powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

# Turn off flow control commands (prevent Ctrl+s from "freezing" vim)
stty -ixon

# if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
# 	tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
# fi

# Open tmux by default
if [ -t 0 ] && [[ -z $TMUX ]] && [[ $- = *i* ]]; then exec tmux; fi

# Bash completion for pandoc
eval "$(pandoc --bash-completion)"
