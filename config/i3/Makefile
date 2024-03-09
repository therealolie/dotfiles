.PHONY: all clean

all: post_dmenu.elf dmenu_path.elf

clean:
	rm -f post_dmenu.elf dmenu_path.elf

post_dmenu.elf: post_dmenu.c
	cc $^ -o $@

dmenu_path.elf: dmenu_path.c
	cc $^ -o $@
