#!/bin/sh
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __               __                             _
#      ___   / /  ____  _ _ _ / _|___ ___ _ __  ___ _ _    __| |_
#     (_-<  / /  (_-< || | '_|  _|___/ _ \ '_ \/ -_) ' \ _(_-< ' \
#     /__/ /_/   /__/\_,_|_| |_|     \___/ .__/\___|_||_(_)__/_||_|
#                                        |_|
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
