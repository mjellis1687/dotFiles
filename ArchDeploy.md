# Arch Installation / Deploy Notes

## Pre-installation

- Note that the Arch Wiki highly recommends checking the package signature
- Disabled Secure Boot to boot into the installation media (USB)
- Switched SATA operation from `RAID On` to `AHCI` in the BIOS for the M.2 SSD to show up in Arch

## Drive setup

- Dell workstation has two drives:
    * /dev/sda which is the 3TB hard drive
    * /dev/nvme0n1 which is the 512 M.2 SSD
- Partition the drive for UEFI/GPT configuration
    * 512M - EFI system partition
    * 60G - /
    * 16G - Swap
    * Remainder - /home
- Format the partitions
```console
# mkfs.fat -F32 /dev/nvme0n1p1
# mkfs.ext4 /dev/nvme0n1p2
# mkswap /dev/nvme0n1p3
# swapon /dev/nvme0n1p3
# mkfs.ext4 /dev/nvme0n1p4
```
- Mount the partitions
```console
# mount /dev/nvme0n1p2 /mnt
# mkdir /mnt/boot
# mkdir /mnt/home
# mount /dev/nvme0n1p1 /boot
# mount /dev/nvme0n1p4 /home
```

## Install Arch package groups:

```console
pacstrap /mnt base base-devel coin-or
```

Note that there are several other groups that may be installed. Check the Arch Wiki.

## Configuring system

### Fstab

```console
# genfstab -U /mnt >> /mnt/etc/fstab
```

### Chroot

```console
# arch-chroot /mnt
```

### Time Zone

```console
# ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime
# hwclock --systohc
```

### Locale

```
# vim /etc/locale.gen
# echo LANG=en_US.UTF-8 > /etc/locale.conf
# locale-gen
```

### Network Configuration

- Add hostname
```console
# echo <HOSTNAME> > /etc/hostname
```
- Edit `/etc/hosts` to be

```
127.0.0.1    localhost
::1          localhost
127.0.1.1    <HOSTNAME>.localdomain <HOSTNAME>
```
- Enable dhcpcd
```console
# systemctl enable dhcpcd
# systemctl enable systemd-resolved
```

### Users

- Change the root password:
```console
# passwd
```
- Enable `sudo` by `visudo` (uncomment `%wheel ALL=(ALL) ALL`)
- Create user:
```console
# useradd -m -G wheel matt
# passwd matt
$ cd /home/matt
$ xdg-user-dirs-update
```

### Reboot

```console
# exit
# umount -R /mnt
# reboot
```

### Grub Installation

- Install `grub` and `efibootmgr` packages
- Install `grub`:
```console
# grub-install --target=x86_64-efi --efi-directory=/boot --bootload-id=GRUB
```
- To make the grub menu hidden at boot, change `/etc/default/grub`:
```
GRUB_HIDDEN_TIMEOUT=0
GRUB_HIDDEN_TIMEOUT_QUIET=true
GRUB_TIMEOUT_STYLE=hidden
```
- Make the configuration
```console
# grub-mkconfig -o /boot/grub/grub.cfg
```

## Additional packages installed

- vim
- bash-completion
- nvidia
- gnome
- gnome-extra
- tmux
- xorg-xinit
- rxvt-unicode
- firefox
- chromium
- openssh
- chrome-gnome-shell
- VirtualBox
- jupyter
- texlive-most (only selected the relevant packages)
- ufw
- cmake
- wget
- python-pip
- powerline-fonts
- powerline
- cpupower
- atlas-lapack (AUR)
- linux-headers
- cronie
- octave
- ipopt, casadi (installed via compiling source code)
- gnuplot
- swig
- pandoc
- pandoc-crossref pandoc-citeproc
- wl-clipboard (Wayland + vim system clipboard support)
- xclip
- gvim (needed for the system clipboard; this will actually report that vim and gvim are in conflict, which is fine - gvim will install both vim and gvim)
- ktikz
- xdotool (for `ct` command)

## Firewall Configuration

```console
# systemctl enable ufw
# systemctl start ufw
# ufw status
# ufw limit SSH
# ufw enable
```

## Gnome Configuration

- Create an `.xinitrc` file:
```
export GDK_BACKEND=x11
exec gnome-session
```
- Enable (and start) GDM
```bash
$ sudo systemctl enable gdm
$ sudo systemctl start gdm
```
- For `Files` (`nautilus`) to add a `Empty Document` entry in the `New Document` of the right click menu, create an empty text file in `$HOME/Templates` called `Empty Document`
- Setting the default terminal in Gnome. Actually, the below command has been depreciated and thus, does nothing.
```bash
$ gsettings set org.gnome.desktop.default-applications.terminal exec urxvt
$ gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''
```
- Keyboard shortcut for moving a window to the workspace to the right/left (assuming horizontal workspaces):
```bash
$ gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Control><Shift>Right']"
$ gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Control><Shift>Left']"
```

## Dot files:

```console
$ alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
$ echo ".cfg" >> .gitignore
$ git clone --bare https://www.github.com/mjellis1687/dotFiles $HOME/.cfg
$ config checkout
```

## Vim Configuration

- Most of it is done automatically using `PlugInstall` and `PlugUpdate`
- YouCompleteMe server needs to be installed:
```console
$ cd .vim/plugged/YouCompleteMe
$ .install.py --clang-completer
```

## Casadi Installation

- Could not get Casadi to build and install properly. `pip` installs everything directly into: `/usr/lib/python3.8/site-packages/casadi`
- Swig 4 does not build Casadi properly, so need to manually point the build to use Swig 3.
- Flags used during installation:
```console
$ cmake -DWITH_PYTHON=ON -DWITH_PYTHON3=ON -DWITH_IPOPT=ON -DWITH_LAPACK=ON \
    -DCMAKE_PREFIX:PATH=/usr/lib/python3.8/site-packages/casadi/cmake \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr/lib/python3.8/site-packages/casadi \
    -DSWIG_DIR=/usr/share/swig/3.0.12 \
    -DSWIG_EXECUTABLE:FILEPATH=/usr/bin/swig-3 ..
```
- Uninstalling programs built by `cmake` may be accomplished by:
```console
$ cat install_manifest.txt | sudo xargs rm -fv
$ cat install_manifest.txt | xargs -L1 dirname | sudo xargs rmdir -p
```
- For installing Casadi within a `virtualenv`, use the following:
```console
$ cmake -DWITH_PYTHON=ON -DWITH_PYTHON3=ON -DWITH_IPOPT=ON -DWITH_LAPACK=ON -DWITH_CPLEX=ON -DWITH_QPOASES=ON \
    -DCPLEX_ROOT_DIR=/opt/ibm/ILOG/CPLEX_Studio129 \
    -DCMAKE_PREFIX:PATH=${HOME}/Desktop/Repositories/python-optimal-control/venv/lib/python3.7/site-packages/casadi/cmake \
    -DCMAKE_INSTALL_PREFIX:PATH=${HOME}/Desktop/Repositories/python-optimal-control/venv/lib/python3.7/site-packages/casadi \
    -DSWIG_DIR=/usr/share/swig/3.0.12 \
    -DSWIG_EXECUTABLE:FILEPATH=/usr/bin/swig-3 ..
```
- Note that this put all libraries in `venv/lib/python3.7/site-packages/casadi/lib`. For it to work properly, need it put in `casadi`. While there is probably an option to install these files into `casadi` instead of `casadi\lib`, I just copied the files into the root directory to fix it. It turns out need to delete the option `-DLIB_PREFIX:PATH=''`.

## Gitlab Setup

- Because unpacking the Gitlab package takes a long time, I downloaded the `.deb` package and then, ran:
```console
# dpkg --force-unsafe-io --install gitlab-ce_12.1.4-ce.0_amd64.deb
```

## Controls Server

### Base Machine

- I was going to install VirtualBox via the Oracle PPA (see "Manual Install") as I was assuming that I would not need to install extra things (e.g., X11). However, the PPA version also tried to install X11, so I decided to just install VirtualBox from the main repo.
- Get the Ubuntu server iso:
```bash
$ wget -q http://releases.ubuntu.com/20.04/ubuntu-20.04-live-server-amd.iso
```
- hostname: ech-controls
- Drive Partition
	- 3 TB hard drive
		- 512 MB: EFI
		- 250 GB: Base partition (cannot boot the machine via NVMe SSD drive)
	- 512 GB NVMe SSD drive
		- 250 GB: Gitlab server
		- 16 GB: Swap
- Drive Partition (future plan)
	- 3 TB hard drive
		- 512 MB: EFI
		- 250 GB: Base partition
	- 512 GB NVMe SSD drive
		- 250 GB: Gitlab server
		- 80 GB: NextCloud (use harddrive for storage)
		- 80 GB: Website
		- 16 GB: Swap
- Create NVMe partiion
```bash
$ sudo fdisk /dev/nvme0n1
```
	- Create GPT disklabel: `g`
	- Create partition: `n`
	- Create partition: `n` (for swap)
- Create filesystem
```bash
$ sudo mkfs.ext4 /dev/nvme0n1p1
$ sudo mkswap /dev/nvme0n1p2
$ sudo swapon /dev/nvme0n1p2
```
- Mount
```bash
$ mkdir /home/controls/GitLabServer
$ sudo mount /dev/nvme0n1p1 /home/controls/GitLabServer
```

#### VirtualBox - Manual Install

- Installed it as headless
- Necessary packages:
```bash
$ sudo apt install build-essential dkms unzip wget
```
- Make sure the two repositories are added:
```bash
$ sudo add-apt-repository universe
$ sudo add-apt-repository multiverse
```
- Add a source to the source list:
```bash
$ sudo vim /etc/apt/sources.list
```
with
```bash
deb http://download.virtualbox.org/virtualbox/debian focal contrib
```
- Add the Oracle public key:
```bash
$ wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
```

#### GitLab Server Setup

- Create the VM
```bash
VBoxManage createvm --name GitLabServer --ostype Ubuntu_64 --register --basefolder `pwd`
```
- Set memory and network
```bash
VBoxManage modifyvm GitLabServer --memory 16384 --vram 128
VBoxManage modifyvm GitLabServer --ioapic on
VBoxManage modifyvm GitLabServer --nic1 nat
VBoxManage modifyvm GitLabServer --nic1 bridged --bridgeadapter1 eno1
```
- Create the disk and connect the CD ISO
```bash
VBoxManage createhd --filename `pwd`/GitLabServer/GitLabServer_Disk.vdi --size 250000 --format VDI
VBoxManage storagectl GitLabServer --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach GitLabServer --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  `pwd`/GitLabServer/GitLabServer_Disk.vdi
VBoxManage storagectl GitLabServer --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storageattach GitLabServer --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium ~/ubuntu-20.04-live-server-amd64.iso
VBoxManage modifyvm GitLabServer --boot1 dvd --boot2 disk --boot3 none --boot4 none
```
- Set RDP access and start the VM
```bash
VBoxManage modifyvm GitLabServer --vrde on
VBoxManage modifyvm GitLabServer --vrdemulticon on --vrdeport 10001
VBoxManage modifyvm GitLabServer --vrdeproperty VNCPassword=secret
VBoxHeadless --startvm GitLabServer &
```
- Turn off VM
```bash
VBoxManage controlvm GitLabServer poweroff
```
- Showing VM info
```bash
VBoxManage showvminfo GitLabServer
```
- [Setup and configure Postfix as a Send-Only SMTP](https://computingforgeeks.com/how-to-install-and-configure-postfix-as-a-send-only-smtp-server-on-ubuntu/)
