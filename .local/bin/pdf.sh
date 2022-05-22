#!/usr/bin/bash
#
# Shows a list of pdf in the $HOME directory of the user inside dmenu and open the selected ones with okular.

choices=$(find "$HOME" -type f -name "*\.pdf" -not -path "$HOME/.cache/*" | dmenu -c -l 10 -bw 5 -p "Choose a pdf:" | sort -u)
[ ! "$choices" ] && { echo -e "User choose to exit"; exit 1; }
okular $choices
