#! /usr/bin/bash
#                        _       __             __        __       __
#        _______________(_)___  / /______     _/_/  _  __/ /______/ /
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   | |/_/ __/ ___/ /
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    _>  </ /_/ /__/ /
#     /____/\___/_/  /_/ .___/\__/____/  /_/     /_/|_|\__/\___/_/
#                     /_/
#
# Description: turns off proprely the Caps_Lock key.
# Dependencies: xdotool, xmodmap.
# GitHub: https://github.com/a2n-s/dotfiles 
# License: https://github.com/a2n-s/dotfiles/LICENSE 
# Contributors: Stevan Antoine

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -e|--on|--enable)
      ENABLE=YES
      shift # past argument
      ;;
    -d|--off|--disable)
      DISABLE=YES
      shift # past argument
      ;;

    -q|--quiet)
      QUIET=YES
      shift # past argument
      ;;

    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done

if [[ ${#POSITIONAL[@]} -eq 1 ]]; then if [[ ! -v QUIET ]]; then echo "unknown flag $POSITIONAL... Aborting."; fi; exit;
else if [[ ${#POSITIONAL[@]} -gt 1 ]]; then if [[ ! -v QUIET ]]; then echo "unknown flags ${POSITIONAL[@]}... Aborting."; fi; exit; fi; fi
if [[ -v ENABLE && -v DISABLE ]]; then if [[ ! -v QUIET ]]; then echo "you cannot enable and disable at the same time... Aborting..."; fi; exit; fi
if [[ ! -v ENABLE && ! -v DISABLE ]]; then if [[ ! -v QUIET ]]; then echo "defaulting to DISABLE"; DISABLE=YES; fi; fi

caps=$(xset -q | grep Caps | cut -d ' '  -f10)

if [[ -v DISABLE ]]; then
	if [[ $caps == "on" ]]; then
		if [[ ! -v QUIET ]]; then echo "turning caps_lock off"; fi
		xdotool key Caps_Lock
	fi
	if [[ ! -v QUIET ]]; then echo "disabling caps_lock"; fi
	xmodmap -e "keycode 66=NoSymbol"
	exit
fi

if [[ -v ENABLE ]]; then
	if [[ ! -v QUIET ]]; then echo "enabling caps_lock"; fi
	xmodmap -e "keycode 66=Caps_Lock"
fi
