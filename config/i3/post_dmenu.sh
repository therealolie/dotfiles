#!/bin/sh
read -r file
for x in "${HOME}/.local/share/applications" "/usr/share/applications" "/var/lib/flatpak/exports/share/applications"; do
	for f in "$x"/*.desktop; do
		[ -f "$f" ] || continue
		name="$(grep "$f" -e "^Name=" -m 1 | sed -E 's/^Name=(.*)$/\1/;s/\n//g')"
		[ "${file}" = "${name}" ] || continue
		nodisp="$(grep "$f" -e "^NoDisplay=" -m 1 | sed -E 's/^NoDisplay=(.*)$/\1/;s/\n//g')"
		[ "${nodisp}" = "true" ] && return
		echo "$f"
		exit
	done
done
