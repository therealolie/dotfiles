
PLATFORM := $(shell [ -d /system ] && echo android || echo pc )

default: ${PLATFORM} ${PLATFORM}-a all

android:


android-a: all
	sed -i -e 's/PLATFORM=pc/PLATFORM=mobile/' -- ~/.config/shell/profile


pc:
	sudo cmp -s ./misc/pl /usr/share/X11/xkb/symbols/pl || sudo cp ./misc/pl /usr/share/X11/xkb/symbols/pl
	sudo cmp -s ./misc/sudoers /etc/sudoers || sudo cp ./misc/sudoers /etc/sudoers
	sudo pacman -S zip android-tools base{,-devel} bluez dex dmenu feh flatpak gimp grub htop i3{-wm,blocks} jq kitty ksnip {lib32-,}pipewire  pipewire{,-{pulse,alsa,jack,audio}} lightdm{,-gtk-greeter} lynx mpv nautils ncdu neovim networkmanager noto-fonts-emoji npm openshot obs-studio parallel python-pynvim qpwgraph steam tmux unrar wine{,-mono,tricks} xautolock xcliip xcompmgr  

pc-a: all
	

all: ${PLATFORM}
	mkdir ~/.config ~/.local/bin -p
	cp -r ./config/* ~/.config
	cp -r ./bin/* ~/.local/bin/
	rm -f ~/.bashrc
	ln -s ~/.config/shell/profile ~/.bashrc
	
