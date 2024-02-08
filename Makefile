
PLATFORM := $(shell [ -d /system ] && echo android || echo pc )

default: ${PLATFORM} ${PLATFORM}-a all

android:


android-a: all
	sed -i -e 's/PLATFORM=pc/PLATFORM=mobile/' -- ~/.config/shell/profile


pc:
	sudo cmp -s ./misc/pl /usr/share/X11/xkb/symbols/pl || sudo cp ./misc/pl /usr/share/X11/xkb/symbols/pl
	sudo cmp -s ./misc/sudoers /etc/sudoers || sudo cp ./misc/sudoers /etc/sudoers

pc-a: all


all: ${PLATFORM}
	mkdir ~/.config -p
	cp -r ./config/* ~/.config
	cp -r ./bin/* ~/.local/bin/
	rm -f ~/.bashrc
	ln -s ~/.config/shell/profile ~/.bashrc
	
