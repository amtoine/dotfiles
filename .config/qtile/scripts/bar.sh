#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#                 __           __         __  _                  _    
#          __    / /  __ _    / /  ___   / / | |__  __ _ _ _  __| |_  
#      _  / _|  / /  / _` |  / /  (_-<  / /  | '_ \/ _` | '_|(_-< ' \ 
#     (_) \__| /_/   \__, | /_/   /__/ /_/   |_.__/\__,_|_|(_)__/_||_|
#                       |_|                                           
#
# Description:  changes the qtile bar with dmenu.
# Dependencies: dmenu, qtile
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

# asks the user for the size of the bar.
default_size="medium"
size=$(echo -e "$default_size (default)\ntiny\nsmall\nmedium\nlarge\nhuge" | dmenu -l 10 -p "bar size")
if [ -z "$size" ]; then
  size="$default_size"
else
  size=$(echo "$size" | sed 's/ .*//')
fi

# asks the user for the content of the bar.
default_style="decreased"
case "$size" in
  huge|large) options="minimal\ndecreased (recommended)\nnormal";;
  *) options="minimal\ndecreased\nnormal";;
esac
style=$(echo -e "$default_style (default)\n$options" | dmenu -l 10 -p "bar style")
if [ -z "$style" ]; then
  style="$default_style"
else
  style=$(echo "$style" | sed 's/ .*//')
fi

# changes the ~/.config/qtile/style.py file to reflect the new bar
echo "size: $size; style: $style"
sed -i "s/ = font_sizes\..*/ = font_sizes\.$size/" ~/.config/qtile/style.py
sed -i "s/ = bars\..*/ = bars\.$style/" ~/.config/qtile/style.py
# restart qtile to apply the changes
qtile cmd-obj -o cmd -f restart
