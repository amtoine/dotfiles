#!/bin/sh
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __                   ____                                                 __
#        _______________(_)___  / /______     _/_/  _______  _______/ __/           ____  ____  ___  ____           _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / ___/ / / / ___/ /_   ______   / __ \/ __ \/ _ \/ __ \         / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    (__  ) /_/ / /  / __/  /_____/  / /_/ / /_/ /  __/ / / /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /____/\__,_/_/  /_/              \____/ .___/\___/_/ /_/   (_)  /____/_/ /_/
#                     /_/                                                             /_/
#
# Description:  opens a link or the default homepage in surf tabbed.
# Dependencies: tabbed, surf
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

xidfile="/tmp/tabbed-surf.xid"
uri="file:///home/ants/.config/surf/html/homepage.html"

[ -f $xidfile ] && pidof surf || rm $xidfile

if [ "$#" -gt 0 ];
then
	uri="$1"
fi

runtabbed() {
	tabbed -dcn tabbed-surf -r 2 surf -e '' "$uri" >"$xidfile" \
		2>/dev/null &
}

if [ ! -r "$xidfile" ];
then
	runtabbed
else
	xid=$(cat "$xidfile")
	xprop -id "$xid" >/dev/null 2>&1
	if [ $? -gt 0 ];
	then
		runtabbed
	else
		surf -e "$xid" "$uri" >/dev/null 2>&1 &
	fi
fi
