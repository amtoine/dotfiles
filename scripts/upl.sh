#! /bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __            _      _
#      ___   / /  _  _ _ __| |  __| |_
#     (_-<  / /  | || | '_ \ |_(_-< ' \
#     /__/ /_/    \_,_| .__/_(_)__/_||_|
#                     |_|
#
# Description:  updates some lists of installed packages.
# Dependencies: pacman, comm
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

dir="$HOME/.pkgslists"
echo "updating packages list..."
  pacman -Qqe > $dir/allpkglist.txt
  pacman -Qqent > $dir/pkglist.txt
echo "updating dependencies list..."
  comm -13 <(pacman -Qqdt | sort) <(pacman -Qqdtt | sort) > $dir/optdeplist.txt
echo "updating foreign packages list..."
  pacman -Qqem > $dir/foreignpkglist.txt
echo "updating cargo commands list..."
  cargo --list > $dir/cargocmdlist.txt
echo "updating python packages list..."
  /usr/bin/pip list > $dir/pippkglist.txt
echo "all done!"
