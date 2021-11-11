#!/bin/sh
#

screenshot() {
	case $1 in
	full)
		scrot -m '%Y-%m-%d_%H-%M-%S_$wx$h_scrot.png' -e 'mv $f ~/images/shots/'
		;;
	window)
		sleep 1
		scrot -s '%Y-%m-%d_%H-%M-%S_$wx$h_scrot.png' -e 'mv $f ~/images/shots/'
		;;
	*)
		;;
	esac;
}

screenshot $1
