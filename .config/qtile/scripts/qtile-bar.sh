#! /usr/bin/bash

default_size="medium"
size=$(echo -e "$default_size (default)\ntiny\nsmall\nmedium\nlarge\nhuge" | dmenu -l 10 -p "bar size")
if [ -z "$size" ]; then
  size="$default_size"
else
  size=$(echo "$size" | sed 's/ .*//')
fi

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

echo "size: $size; style: $style"
sed -i "s/ = font_sizes\..*/ = font_sizes\.$size/" ~/.config/qtile/style.py
sed -i "s/ = bars\..*/ = bars\.$style/" ~/.config/qtile/style.py
qtile cmd-obj -o cmd -f restart
