
# ~/.bash_profile
#
# profile file: Runs on login. Environmental variables are set here
#
export PATH=$PATH$( find $HOME/.local/bin/ -type d -printf ":%p" )

# Default programs:
export EDITOR="vim"  # TODO: consider neovim?
export TERMINAL="urxvt"	 # TODO: change
export BROWSER="firefox"  # TODO: change

# XDG stuff
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Programs that partially support XDG
export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave/octave_hist"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"
export TEXMFHOME="${XDG_DATA_HOME}/texmf"
export SSB_HOME="${XDG_DATA_HOME}/zoom"  # (Zoom)
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"

# For IPOPT
if [ -d /usr/local/lib/pkgconfig ]; then
	export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
