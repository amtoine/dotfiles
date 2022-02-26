#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __     _                          _
#      ___   / /  __| |_ __  _ _ _  _ _ _    __| |_
#     (_-<  / /  / _` | '  \| '_| || | ' \ _(_-< ' \
#     /__/ /_/   \__,_|_|_|_|_|  \_,_|_||_(_)__/_||_|
#
# Description:  wrapper around dmenu_run to launch dmenu in the middle and in a grid fashion.
# Dependencies: dmenu
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

DMWIDTH=700;
DMHEIGHT=10;
DMCOLUMNS=3;
DMLINES=9;
DMBORDER=5;
dmenu_run -g $DMCOLUMNS -l $DMLINES \
          -x $((960 - $DMWIDTH/2)) -y $((540 - ($DMLINES+1)*$DMHEIGHT/2)) \
          -z $DMWIDTH -h $DMHEIGHT -bw $DMBORDER -fn "mononoki Nerd Font-20"
