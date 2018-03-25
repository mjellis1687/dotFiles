#!/bin/bash

# findGitConfig - gets the git configuration for current machine

##### Functions

editor()
{
	if [ "${HOSTNAME}" = "matty-2016" ] || [ "${HOSTNAME}" = "matty-Gazelle-Professional" ]; then
		ED="vim"
	else
		ED="/cygdrive/c/cygwin64/bin/vim.exe"
	fi
}

credential()
{
	if [ "${HOSTNAME}" = "matty-2016" ]; then
		CR="/usr/share/git/credential/gnome-keyring/git-credential-gnome-keyring"
	elif [ "${HOSTNAME}" = "matty-Gazelle-Professional" ]; then
		CR="/usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring"
	else
		CR="/cygdrive/C/Users/cellism7/AppData/Local/GitHub/PortableGit_f02737a78695063deace08e96d5042710d3e32db/mingw32/libexec/git-core/git-credential-manager.exe"
	fi
}

email()
{
	if [ "${HOSTNAME}" = "matty-2016" ] || [ "${HOSTNAME}" = "matty-Gazelle-Professional" ]; then
		EM="ellis.matt.j@gmail.com"
	else
		EM="matthew.j.ellis@jci.com"
	fi
}

# MAIN

GITCONFIG=${HOME}/.gitconfig
ED=""
CR=""
EM=""
editor
credential
email
rm -f $GITCONFIG
echo "[user]" >> $GITCONFIG
echo "	name=Matt Ellis" >> $GITCONFIG
echo "	email="$EM >> $GITCONFIG
echo "[core]" >> $GITCONFIG
echo "	editor="$ED >> $GITCONFIG
echo "	trustctime=false" >> $GITCONFIG
echo "[diff]" >> $GITCONFIG
echo "	tool=vimdiff" >> $GITCONFIG
echo "	prompt=false" >> $GITCONFIG
echo "[merge]" >> $GITCONFIG
echo "	tool=vimdiff" >> $GITCONFIG
echo "	conflictstyle=diff3" >> $GITCONFIG
echo '[mergetool "vimdiff"]' >> $GITCONFIG
echo "	tool=vimdiff" >> $GITCONFIG
echo "	keepBackup=false" >> $GITCONFIG
echo "[credential]" >> $GITCONFIG
echo "	helper=!'"$CR"'" >> $GITCONFIG
echo "[alias]" >> $GITCONFIG
echo "	d = diff" >> $GITCONFIG
echo "	m = mergetool" >> $GITCONFIG
echo "	list-conflicts = !git ls-files -u | cut -f 2 | sort -u" >> $GITCONFIG
