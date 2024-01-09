#!/bin/sh

PLATFORM=PC
if [ -d /system ]; then 
	PLATFORM=TERMUX
fi

mkdir ~/.config -p
cp -r ./shell ~/.config/
if [ "${PLATFORM}" = PC ]; then
	cp -r ./i3 ~/.config
	sudo cp ./misc/pl /usr/share/X11/xkb/symbols/pl
	sudo cp ./misc/sudoers /etc/sudoers
fi
ln -s ~/.config/shell/profile ~/.bashrc
