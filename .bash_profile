#
# ~/.bash_profile
#
# profile file: Runs on login. Environmental variables are set here
#
export PATH=$PATH$( find $HOME/.local/bin/ -type d -printf ":%p" )

# Default programs:

export XDG_DATA_HOME="$HOME/.local/share"
export TEXMFHOME="${XDG_DATA_HOME}/texmf"

# For IPOPT
if [ -d /usr/local/lib/pkgconfig ]; then
	export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
