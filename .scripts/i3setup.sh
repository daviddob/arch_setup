#!/bin/bash

declare -a software=(
	'google-chrome'
	'atom-editor'
	'gpmdp'
	'gpmdp-remote'
	'slack-desktop'
	'vlc-git'
	'teamspeak3'
	'remmina'
	'remmina-plugin-teamviewer'
	'rsync'
	'ranger'
	'htop'
	'smartgit'
	'pithos-git'
	'teamviewer'
	'wps-office'
	'vertex-themes'
	'vmware-modules-dkms'
	'filezilla'
	
)

declare -a rice=(
	'xfce4'
	'i3-gaps-git'
	'i3lock-blur'
	'py3status'
	'i3status'
	'rofi-git'
	'dmenu'
	'compton-git'
	'feh'
	'scrot'
	'ttf-font-awesome'
	'vim-promptline-git'
	'vundle-git'
	'vim-nerdtree'
	'playerctl'
	'perl-x11-guitest'
	'perl-smart-comments'
)

declare -a drivers=(
	'nvidia'
	'nvidia-libgl'
	'ckb-git-latest'
	'lib32-nvidia-libgl'
	'alsa-utils'
	'pulseaudio'
	'pulseaudio-alsa'
	'jre8-openjdk'
)

for install in "${software[@]}"
do
	echo $install
	yaourt -S --noconfirm $install
done

for install in "${rice[@]}"
do
	echo $install
	yaourt -S --noconfirm $install
done

for install in "${drivers[@]}"
do
	echo $install
	yaourt -S --noconfirm $install
done
