#! /bin/bash
#             ___
#       ____ |__ \ ____              _____      personal page: https://a2n-s.github.io/ 
#      / __ `/_/ // __ \   ______   / ___/      github   page: https://github.com/a2n-s 
#     / /_/ / __// / / /  /_____/  (__  )       my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/____/_/ /_/           /____/
#                        _       __             __               __              __
#        _______________(_)___  / /______     _/_/  __  ______  / /        _____/ /_
#       / ___/ ___/ ___/ / __ \/ __/ ___/   _/_/   / / / / __ \/ /        / ___/ __ \
#      (__  ) /__/ /  / / /_/ / /_(__  )  _/_/    / /_/ / /_/ / /   _    (__  ) / / /
#     /____/\___/_/  /_/ .___/\__/____/  /_/      \__,_/ .___/_/   (_)  /____/_/ /_/
#                     /_/                             /_/
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
echo "all done!"
