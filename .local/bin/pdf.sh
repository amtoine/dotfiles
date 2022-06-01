#!/usr/bin/bash
#
# Shows a list of pdf in the $HOME directory of the user inside dmenu and open the selected ones with okular.

BASE="$HOME"
EXCLUDE="$HOME/.cache"
dunstify "pdf.sh" "pulling pdfs from:\n'$BASE'\nexcluding:\n'$EXCLUDE'"
choices=$(find "$BASE" -type f -name "*\.pdf" -not -path "$EXCLUDE/*" | dmenu -c -l 10 -bw 5 -p "Choose a pdf:" | sort -u)
[ ! "$choices" ] && { echo -e "User choose to exit"; exit 1; }
okular $choices
