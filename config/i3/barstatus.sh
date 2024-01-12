#!/bin/sh
esc(){
	printf "%s" "$1" | sed -Ee "s/([\"\\])/\\\1/"
}
prin(){
	COLOR="${2:-000000}"
	TEXT="${1}"
	SHORT_TEXT="${3:-${TEXT}}"
	printf "{\"full_text\":\"$(esc "${TEXT}")\",\"short_text\":\"$(esc "${SHORT_TEXT}")\",\"color\":\"#${COLOR}\",\"separator\":false,\"separator_block_width\":0},\n"
}
sep(){
	printf '{"full_text":" ","separator":false,"separator_block_width":0},\n'
}

printf '{"version":1}\n[\n[]\n'
while true;do
	printf ",["

	prin "$(date +"%Y.%m.%d (%b, %a)")" 008ab3 "$(date +"%Y.%-m.%-d")"
	sep
	prin "$(date +"%-H:%M:%S")"
	printf "{\"full_text\":\"\"}]"
	sleep 1
done
