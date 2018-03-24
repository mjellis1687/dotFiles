#!/bin/bash

# findGitConfig - gets the git configuration for current machine

##### Functions

editor()
{
	if [ "${HOSTNAME}" = "matty-2016" ] || [ "${HOSTNAME}" = "matty" ]; then
		ED="vim"
	else
		ED="/cygdrive/c/cygdrive/bin/vim.exe"
	fi
}

credential()
{
	if [ "${HOSTNAME}" = "matty-2016" ]; then
		CR="/usr/share/git/crendential/gnome-keyring/git-credential-gnome-keyring"
	elif [ "${HOSTNAME}" = "matty" ]; then
		CR="/usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring"
	else
		CR="/cygdrive/C/Users/cellism7/AppData/Local/GitHub/PortableGit_f02737a78695063deace08e96d5042710d3e32db/mingw32/libexec/git-core/git-credential-manager.exe"
	fi
}

# MAIN
ED=""
CR=""
case $1 in
	editor)
		editor
		;;
	credential)
		credential
		;;
	*)
		editor
esac

