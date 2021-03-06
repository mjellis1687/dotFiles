# Bash Aliases
# Author: Matt Ellis

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" \
		|| eval "$(dircolors -b)"
    alias ls='ls -hF --color=auto'
    alias dir='dir --color=auto --format=vertical'
    alias vdir='vdir --color=auto --format=long'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Dot file git
alias config='/usr/bin/git --git-dir=${HOME}/.cfg --work-tree=${HOME}'

alias ccs="vim ${HOME}/CommandCheatSheet.md"
alias ggs="git status"
alias brc="vim ${HOME}/.bashrc"
alias vrc="vim ${HOME}/.vimrc"
alias gd="git diff"

# When opening a terminal from a folder, it will open GNOME terminal. ct will
# switch to rxvt-unicode
alias ct="$HOME/bin/change_terminal.sh"
