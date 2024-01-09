#!/bin/sh
out="ə"
for x in "/usr/share/applications" "/var/lib/flatpak/exports/share/applications" "${HOME}/.local/share/applications"; do
	for f in "$x"/*.desktop; do
		[ -r "$f" ] || continue
		nodisp="$(grep "$f" -e "^NoDisplay=" -m 1 | sed -E 's/^NoDisplay=(.*)$/\1/;s/\n//g')"
		name="$(grep "$f" -e "^Name=" -m 1 | sed -E 's/^Name=(.*)$/\1/;s/\n//g')"
		if [ "${nodisp}" = true ]; then
			out="$(echo "${out}" | sed -E "s|ə${name}ə|ə|g")"
		else
			echo "${out}" | grep -q "ə${name}ə" || out="${out}${name}ə"
		fi
	done
done
IFS=ə
for x in $out; do
	[ "$x" ] && echo "$x"
done
