# ~/.bashrc: executed by bash(1) for non-login shells.
#
# Author: Matt Ellis (based on several .bashrc examples)

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Open tmux by default in uxrvt
# Putting this command at the top prevents sourcing the rest twice
[ "$TERM" == "rxvt-unicode-256color" ] && [ -t 0 ] && [[ -z $TMUX ]] && exec tmux

# SHELL OPTIONS

# Vi mode in bash
set -o vi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# COMPLETION OPTIONS

# Ignore case in tab complete
bind "set completion-ignore-case on"

# Do not tab complete to a PDF when using vim
complete -f -X "*.pdf" vim

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

# ALIAS and FUNCTIONS

[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases" ]] && . "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliases"
[[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/functions" ]] && . "${XDG_CONFIG_HOME:-$HOME/.config}/shell/functions"

# powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

# Turn off flow control commands (prevent Ctrl+s from "freezing" vim)
stty -ixon

# Bash completion for pandoc
eval "$(pandoc --bash-completion)"
