# Command Cheat Sheet

## Setup Updates and Configuration Notes

### `$HOME` Clean-up Notes

- Use utility: `xdg-ninja`
- `BCL` - Building component library from `OpenStudio`?
- `.cmake` - Used for the user registry (hardcoded). Builds of CasADi created this (moved to backup)

### TODO

- Move vim

### Code42 (CrashPlan)

Using Code42, formally CrashPlan, to backup computer. Code42 does not officially support Arch Linux. Thus, it will try to install a SYSV start script into `/etc/init.d`. Thus, I manually create a service file based on one someone posted for CrashPlan [here](https://gist.github.com/takitani/c1fc85bbc410e219fea3caf45a014f7d)

The script is:
```bash
# Paste this into:
# /usr/lib/systemd/system/crashplan.service
#
# Then:
# sudo systemctl enable crashplan.service
# sudo systemctl start crashplan.service
#
# Based on: https://gist.github.com/qertoip/f670594c81bf90565805c28530280fc8

[Unit]
Description=Code42 Backup Engine
After=network.target

[Service]

Type=forking
WorkingDirectory=/usr/local/crashplan
PIDFile=/usr/local/crashplan/Code42Service.pid

ExecStart=/usr/local/crashplan/bin/service.sh start
ExecStop=/usr/local/crashplan/bin/service.sh stop

[Install]
WantedBy=multi-user.target
```

### `dwmblocks`

`dwmblocks` was not loading after launching `dwm` with a display manager (`gdm`). The reason is that the `$PATH` was not being set, since `bash_profile` is not sourced by `gdm`. Instead, added this to `~/.config/x11/xprofile`:
```bash
if [ "$GDMSESSION" == "dwm" ]; then
	source ${HOME}/.bash_profile
	xrandr --output DP-4 --auto --output HDMI-0 --left-of DP-4 --auto --output DP-3 --right-of DP-4 --auto
	{ killall dunst ; setsid -f dunst ;} >/dev/null 2>&1
	setbg &
	remaps &
fi
```

### tmux

Currently, `.tmux.conf` is manually configured to find the location of `powerline` within Python installed packages. This means every time Python is upgraded one has to update the configuration.

### Octave

Update all packages:
```
pkg update
```

### Vim

#### Getting Clipboard Working

- Need `+clipboard` feature enabled. Check via:
```
vim --version
```
- From Arch wiki, the `vim` package is build without `Xorg` support; specifically, the `+clipboard` feature is missing.
- Install `gvim` (needed for the system clipboard; this will actually report that `vim` and `gvim` are in conflict, which is fine - `gvim` will install both `vim` and `gvim`)

#### Vim Plugin Manager

Currently, using the vim plug-in manager found [here](https://github.com/junegunn/vim-plug). For updating plug-ins, use the command:
```
:PlugUpdate
```

#### Set-up YouCompleteMe Server

`YouCompleteMe` is a plug-in that helps with auto-complete.
```bash
$ cd ~/.vim/plugged/YouCompleteMe
$ ./install.py
```

### Python

- `matplotlib` requires `gobject` to show figures on screen.

### AUR/User Built Packages

#### Atlas-Lapack

Steps for disabling the CPU-governor:
1.  Edit `/etc/default/grub`:
```
GRUB_CMDLINE_LINUX_DEFAULT="intel_pstate=disable"
```
1. Update grub:
```bash
# grub-mkconfig -o /boot/grub/grub.cfg
```
1. Enable `apci-cpufreq` module:
```
# echo "apci-cpufreq" > /etc/modules-load.d/acpi-cpufreq.conf
```
1. Restart
1. Set governor via `cpupower`:
```bash
# cpupower frequency-set -g performance
```

```
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
```

## Pacman Tips and Tricks

- Print out user installed packages (excluding packages from `base` and `base-devel`
```bash
comm -23 <(pacman -Qqett | sort) <(pacman -Qqg base -g base-devel | sort | uniq)
```
- Print out comma-separated package name and description
```bash
pacman -Qi zoom | awk -F' [:<=>] ' '/^Name/{name=$2} /^Description/{print name"," $2}'
```
- To browse all installed packages with an instant preview of each package:
```bash
pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
```

## Git Commands

### Diffs and Checkouts
- Uncommitted file to HEAD
```bash
$ git diff <path>
```
- Uncommitted file to before last commit
```bash
$ git diff HEAD^ -- <filename>
```
- Diff between current and last commit
```bash
$ git diff HEAD^ HEAD -- <filename>
```
- Difference between HEAD and n-th grandparent
```
$ git diff HEAD~n HEAD -- <filename>
```
- Another cool feature is `whatchanged` command
```bash
$ git whatchanged -- <filename>
```
- Checkout file from different branch
```bash
$ git checkout <branch_name> file
```

### Branches
- Delete local branch
```bash
$ git branch -d <branch_name>
```
- Delete local branch if the branch contains unmerged contains
```bash
$ git branch -D <branch_name>
```
- Delete remote branch
```bash
$ git push origin --delete <branch_name>
```
- Create a new branch
```bash
$ git checkout -b <branch_name>
```
- Merge changes to a single file from another branch
```bash
$ git checkout --patch <branch_name> file
```

### Commits
- Undo a commit and redo
```bash
$ git commit -m "Something terribly misguided"
$ git reset HEAD~
$ git add ...
$ git commit -c ORIG_HEAD
```

### Tags

- Move tag
	1. Delete the tag on any remote before you push
	```
	git push origin :refs/tags/<tagname>
	```
	2. Replace the tag to reference the most recent commit
	```
	git tag -fa <tagname>
	```
	3. Push the tag to the remote origin
	```
	git push origin --tags
	```

## Vim commands

### Movements

- Move viewpoint down - `Ctrl+Y`
- Move viewpoint up - `Ctrl+E`
- Move to the end of the line - `$`
- Move to the last non-block character of the line - `g`
- Move to the first non-block character of the line - `^`
- Move to tag under cursor - `^]`
- Use `g^]` for ambiguous tags
- Use `^t` to jump back up the tag stack
- `gi` switches to insertion mode placing the cursor at the same location it was previously
- `g;` puts the cursor at the place an edit was made
- `ge` go to the end of the previous word

### Files and Searching

- Search down into subfolders. Provide tab-completion for all file-related tasks
```bash
set path+=**
```
- With above, we can: hit tab to :find by partial match and use * to make it fuzzy
- :b lets you autocomplete any open buffer (without tab)
- Display all matching files when we tab complete
```bash
set wildmenu
```
- Create the tags file (may need to install ctags first)
```bash
command! MakeTags !ctags -R .
```
- Find the next/previous occurrence of variable under cursor: `*`/`#`

### Editing

- Lowercase line: `guu`
- Uppercase line: `gUU`
- Invert case: `~`
- Swap next two characters around: `xp`
- Increment, decrement next number on same line as the cursor: `Ctrl+A,Ctrl+X`
- (Re)indent the text on the current line or on the area selected: `=`
- (Re)indent the current braces { ... }: `=%`
- Auto (re)indent entire document: `G=gg`

## Bash Commands

### Compressed files
- Create a `.tar.gz` file
```bash
$ tar -cvzf file file.tar.gz
```
- Extract `.tar.gz` file
```bash
$ tar -xvzf example.tar.gz
```

### Find and Grep

- Find word in files - returns line numbers
```bash
$ find . -type f -exec grep -n "word" {} \;
```
- Find word in files - returns line numbers and filename
```bash
$ find . -type f -exec grep -Hn "word" {} \;
```
- Recursively find files with extension
```bash
$ find . -type f -name ".<file_type>"
```

## tmux
- Create a new tab: Ctrl + B, C
- Move to next/previous tab: Ctrl + B, N/P
- Move window:
	- Let window number 3 and window number 1 swap positions:
	```
	swap-window -s 3 -t 1
	```
	- Swap the current window with the top window, do:
	```
	swap-window -t 0
	```
	- Move current window back three:
	```
	swap-window -t -3
	```

## Converting Files

- Convert `.bib` file to `.xml` that can be imported in Word:
```
bib2xml mybib.bib | xml2wordbib | sed -e 's/PeriodicalName/PeriodicalTitle/g' -e 's/>Proceedings/>ConferenceProceedings/g' > word.xml
```

## Convert PDFs to PDF/As

- To convert the PDF to PDF/A format, use the following command:
```bash
gs -dPDFA=2 -dBATCH -dNOPAUSE -sProcessColorModel=DeviceRGB -sDEVICE=pdfwrite -sPDFACompatibilityPolicy=1 -sOutputFile=output.pdf input.pdf
```
- In the above command:
	- `-dPDFA=2` specifies the PDF/A version (PDF/A-2).
	- `-dBATCH` and `-dNOPAUSE` options ensure that Ghostscript processes the file without prompting for additional input.
	- `-sProcessColorModel=DeviceRGB` sets the color model to RGB.
	- `-sDEVICE=pdfwrite` specifies the output device as PDF writer.
	- `-sPDFACompatibilityPolicy=1` enables strict PDF/A compliance.
	- `-sOutputFile=output.pdf` specifies the output file name (replace output.pdf with your desired file name).
	- `input.pdf` is the name of your input PDF file.
- Note: The conversion process may vary depending on the complexity of your PDF file and the version of Ghostscript installed on your system. Make sure to review the output PDF/A file to ensure that the conversion meets your requirements.
- If this does not work, you can use an online convert (e.g., [https://docupub.com/pdfconvert/](https://docupub.com/pdfconvert/))

## Password Management

The `pass` utility is a password manager that stores passwords in an encrypted format, using a GPG key.

1. **Generate a GPG key pair:** `pass` uses GPG encryption to secure your passwords. The GPG key pair can be generated from:
   ```bash
   gpg --full-generate-key
   ```
   Follow the prompts to set up the GPG key pair, including choosing the key type and size, setting the expiration date, and providing a passphrase.
2. Set permissions on the GnuPG's directory:
   ```bash
   chmod 600 ~/.local/share/gnupg/*
   chmod 700 ~/.local/share/gnupg
   ```
3. **Initialize the password store:** Run the following command:
   ```bash
   pass init <email or GPG_KEY_ID>
   ```
   where `<GPG_KEY_ID>` is the ID of he GPG key, which can be find by running `gpg --list-keys`.
4. **Add passwords:** To add a new password to `pass`, use `pass insert` followed by a name for the password. For example:
   ```bash
   pass insert Email/Gmail
   ```
5. **Retrieve passwords:** To retrieve a password, use the `pass` command followed by the name of the password to retrieve. For example:
   ```bash
   pass Email/Gmail
   ```
   This command will decrypt and display the password on the terminal.
6. **Integrate with a browser extension (optional):** If you want to conveniently fill passwords in web forms, you can install a browser extension like `passff` (for Firefox) or `chromium-pass` (for Chromium-based browsers). These extensions integrate with `pass` and allow you to autofill passwords.

## Determining What Package Provides a Library

In Arch Linux, you can use the `pkgfile` utility to determine which package provides a shared library. `pkgfile` allows you to search for files in the Arch Linux package repositories. Before using `pkgfile`, you need to make sure it's installed on your system. If you don't have it yet, you can install it using the package manager, `pacman`.

Here's how to install `pkgfile` and use it to find the package that provides a shared library:

- Step 1: Install `pkgfile` (if you haven't already)
	```bash
	sudo pacman -S pkgfile
	```
- Step 2: Update `pkgfile` database. After installing `pkgfile`, you need to update its database to make sure it's up-to-date. Run the following command:
	```bash
	sudo pkgfile --update
	```
- Step 3: Search for the package providing the shared library. Once the database is updated, you can use `pkgfile` to search for the package that provides a specific shared library. For example, let's say you want to find the package that provides the `libssl.so.1.1` library. You can use the following command:
	```bash
	pkgfile libssl.so.1.1
	```
	`pkgfile` will then search its database and show you the package(s) that provide the specified shared library. If the library is available in multiple packages, it will list all of them.

Keep in mind that `pkgfile` will only be able to find the package if the library is part of the official Arch Linux repositories. If the library comes from the AUR (Arch User Repository) or other external sources, you may need to use other methods to determine the package providing it.

## FortiClient VPN

- Dependencies: `openfortivpn` and `openfortivpn-webview`
- Get cookie:
```bash
openfortivpn-webview <Remote Gateway>
```
- Copy cookie
- Then, this can be piped into `openfortivpn`:
```bash
echo $SVPNCOOKIE | sudo openfortivpn <remote gateway> --username=<username> --trusted-cert <cert-here> --cookie-on-stdin
```

### `ppp` Version 2.5.0

Something as of `ppp` version 2.5.0 changed, resulting in the error: "Peer refused to agree to his IP address" (see [here](https://aur.archlinux.org/packages/networkmanager-fortisslvpn#comment-933331) and [here](https://bbs.archlinux.org/viewtopic.php?id=288717)). One of the reported solutions or work-rounds is to uncomment `ipcp-accept-remote` in `/etc/ppp/options`, which seemed to resolve the issue.

## Editing Videos with `ffmpeg`

### Cutting Video between Specific Times


To cut a video between two specific times using `ffmpeg`, you can use:
```bash
ffmpeg -i input.mp4 -ss START_TIME -to END_TIME -c:v copy -c:a copy output.mp4
```
Replace the following placeholders:

- `input.mp4`: The name of your input video file.
- `START_TIME`: The start time from where you want to cut the video (in the format `hh:mm:ss` or `ss` for seconds).
- `END_TIME`: The end time where you want to stop cutting the video (also in the format `hh:mm:ss` or `ss` for seconds).
- `output.mp4`: The name of the output video file.

Here's a breakdown of the options used in the command:

- `-i input.mp4`: Specifies the input video file.
- `-ss START_TIME`: Sets the start time for the cut.
- `-to END_TIME`: Sets the end time for the cut.
- `-c:v copy`: This option copies the video codec without re-encoding, which is faster and lossless.
- `-c:a copy`: This option copies the audio codec without re-encoding.

If your `ffmpeg` version supports the `-t` option for duration, you can use it instead of `-to` like this:

```bash
ffmpeg -i input.mp4 -ss START_TIME -t DURATION -c:v copy -c:a copy output.mp4
```

In this case, replace `DURATION` with the duration of the segment you want to cut (also in the format `hh:mm:ss` or `ss` for seconds).

Here's an example command:

```bash
ffmpeg -i input.mp4 -ss 00:01:30 -to 00:03:45 -c:v copy -c:a copy output.mp4
```

This command will cut a segment from 1 minute and 30 seconds into the video to 3 minutes and 45 seconds and save it as `output.mp4`.

If you experience a brief blank screen when cutting a video with `ffmpeg`, you can try re-encoding the video to ensure consistent video and audio streams throughout the cut. Here's how to do it:

```bash
ffmpeg -i input.mp4 -ss START_TIME -to END_TIME -vf "select=gte(n\,0)" -af "aselect=gte(n\,0)" -c:v libx264 -c:a aac output.mp4
```

where

- `input.mp4`: The name of your input video file.
- `START_TIME`: The start time from where you want to cut the video (in the format `hh:mm:ss` or `ss` for seconds).
- `END_TIME`: The end time where you want to stop cutting the video (also in the format `hh:mm:ss` or `ss` for seconds).
- `output.mp4`: The name of the output video file.
- `-vf "select=gte(n\,0)"`: This filter selects all video frames starting from the first frame (frame number `n` greater than or equal to 0). This ensures that no frames are dropped from the beginning of the cut, eliminating the blank screen issue.
- `-af "aselect=gte(n\,0)"`: This filter selects all audio frames starting from the first frame (frame number `n` greater than or equal to 0).
- `-c:v libx264`: This specifies the video codec to use (libx264 in this case). You can change it to another codec if needed.
- `-c:a aac`: This specifies the audio codec to use (AAC in this case). You can change it to another codec if needed.

This command will re-encode both the video and audio, which may take some additional time compared to the previous method that copied streams. However, it should result in a video without any blank screens during playback.

### Merging Videos

To merge two video files with `ffmpeg`, you can use the `concat` demuxer. This method allows you to concatenate multiple video files together without re-encoding, which preserves the original video and audio quality. Here's a step-by-step guide:

1. Create a text file (e.g., `input.txt`) and list the video files you want to merge in the desired order, one file per line. For example:

   ```
   file 'video1.mp4'
   file 'video2.mp4'
   ```

   Replace `'video1.mp4'` and `'video2.mp4'` with the actual filenames and paths of your video files. You can include as many video files as you need in this list.

2. Run the following `ffmpeg` command to merge the video files:

   ```bash
   ffmpeg -f concat -safe 0 -i input.txt -c:v copy -c:a copy output.mp4
   ```

   - `-f concat`: Specifies the format as `concat` for the demuxer.
   - `-safe 0`: This option allows `ffmpeg` to read files outside of the current directory. You may need this if your input files are in different directories.
   - `-i input.txt`: Specifies the input text file containing the list of video files.
   - `-c:v copy`: Copies the video streams without re-encoding, preserving the original video quality.
   - `-c:a copy`: Copies the audio streams without re-encoding, preserving the original audio quality.
   - `output.mp4`: The name of the output video file.

3. `ffmpeg` will merge the video files listed in `input.txt` and create a single output video file named `output.mp4`.

This method is safe and efficient because it doesn't involve re-encoding, so there is no loss of quality, and it is generally faster than re-encoding. However, it requires that the video files have compatible codecs and settings for successful concatenation. If you encounter any issues with incompatible formats, you may need to preprocess or convert the videos before merging them.

## Rotate a HIEC Image

- ImageMagick will do it
```bash
magick input.heic -rotate 90 output.heic
```
