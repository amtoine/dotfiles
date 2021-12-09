#! /bin/bash

dir="$HOME/.pkgslists"
echo "updating packages list..."
pacman -Qqe > $dir/allpkglist.txt
pacman -Qqent > $dir/pkglist.txt
echo "updating dependencies list..."
comm -13 <(pacman -Qqdt | sort) <(pacman -Qqdtt | sort) > $dir/optdeplist.txt
echo "updating foreign packages list..."
pacman -Qqem > $dir/foreignpkglist.txt
echo "all done!"
