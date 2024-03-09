.PHONY: all clean test

all:

clean:

test:
	for x in $$(find -type f); do \
		[ "$${x}" != "./Makefile" ] && \
			shellcheck -oall -e2292,2312 "$${x}"; \
	done
