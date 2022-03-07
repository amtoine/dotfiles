allmsg="Install all packages below "
pending=$(checkupdates)

[ ! "$pending" ] && { echo "ok" | dmenu -bw 5 -p "No pending update!" > /dev/null; exit 0; }

pkgs=$(echo -e "$allmsg\n$pending" | dmenu -l 10 -bw 5 -p "Update" | sed 's/ [0-9.\-]\+ -> [0-9.\-]\+//g' | tr '\n' ' ');
[ ! "$pkgs" ] && exit 0

if echo "$pkgs" | grep -e "$allmsg" -q
then
  sudo pacman -Syu
else
  sudo pacman -Sy $pkgs
fi

