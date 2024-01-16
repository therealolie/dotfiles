#!/bin/sh

PLATFORM=PC
if [ -d /system ]; then 
	PLATFORM=TERMUX
fi

mkdir ~/.config -p
cp -r ./config/* ~/.config
if [ "${PLATFORM}" = PC ]; then
	sudo cmp -s ./misc/pl /usr/share/X11/xkb/symbols/pl || sudo cp ./misc/pl /usr/share/X11/xkb/symbols/pl
	sudo cmp -s ./misc/sudoers /etc/sudoers || sudo cp ./misc/sudoers /etc/sudoers
fi
rm -f ~/.bashrc
ln -s ~/.config/shell/profile ~/.bashrc
