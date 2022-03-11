#!/usr/bin/env bash
#           ___                       personal page: https://a2n-s.github.io/ 
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s 
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles 
#     \__,_/___|_||_|       /__/
#        _     __  _        __  _   _                          _
#       | |   / / | |__    / / | |_| |_  ___ _ __  ___ ___  __| |_
#      _| |  / /  | '_ \  / /  |  _| ' \/ -_) '  \/ -_|_-<_(_-< ' \
#     (_)_| /_/   |_.__/ /_/    \__|_||_\___|_|_|_\___/__(_)__/_||_|
#
# Description:  manages all the themes of my desktop environment.
# Dependencies:
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE
# Contributors: Stevan Antoine

################################################################################################
## Some color definitions ######################################################################
################################################################################################
# Reset
Off=$(printf '\033[0m')        # Text Reset
# Regular Colors
Blk=$(printf '\033[0;30m')     # Black
Red=$(printf '\033[0;31m')     # Red
Grn=$(printf '\033[0;32m')     # Green
Ylw=$(printf '\033[0;33m')     # Yellow
Blu=$(printf '\033[0;34m')     # Blue
Pur=$(printf '\033[0;35m')     # Purple
Cyn=$(printf '\033[0;36m')     # Cyan
Wht=$(printf '\033[0;37m')     # White
# High Intensity
IRed=$(printf '\033[0;91m')    # Red
IGrn=$(printf '\033[0;92m')    # Green
IYlw=$(printf '\033[0;93m')    # Yellow
IBlu=$(printf '\033[0;94m')    # Blue
IPur=$(printf '\033[0;95m')    # Purple
IWht=$(printf '\033[0;97m')    # White
################################################################################################
## 'Global constants' definitions ##############################################################
################################################################################################
# Specific color use. #
#######################
Ok=$Grn    # ok statement
Err=$IRed  # errors
Wrn=$IYlw  # warnings
Cod=$IBlu  # code
Hed=$IPur  # head
Src=$Pur   # source
Dst=$Grn   # destination
Pmt=$Cyn   # prompt
Tip=$IGrn  # tip

[[ ! -v REMOTE ]] && REMOTE="a2n-s/themes"
[[ ! -v BRANCH ]] && BRANCH="main"
CACHE="$HOME/.cache/all-themes"
colordatabase="$CACHE/themes.csv"
colorpreview="$CACHE/themes.clr"
configs="qtile,dunst,alacritty,kitty,doom,dmenu,st"
[[ ! -v QTILE ]] && QTILE="$HOME/.config/qtile"
[[ ! -v DUNST ]] && DUNST="$HOME/.config/dunst/dunstrc"
[[ ! -v ALACRITTY ]] && ALACRITTY="$HOME/.config/alacritty/alacritty.yml"
[[ ! -v KITTY ]] && KITTY="$HOME/.config/kitty/kitty.conf"
[[ ! -v CONKY ]] && CONKY="$HOME/.config/conky"
[[ ! -v SUCKLESS ]] && SUCKLESS="$HOME/ghq/git.suckless.org"
[[ ! -v XRESOURCES ]] && XRESOURCES="$HOME/.Xresources"
_nb_colors=20
_columns=(name bg fg sel_bg sel_fg 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)

update () {
  #
  # download the themes list from remote.
  # or sync the local repo with the remote.
  # 
  if [[ ! -d "$CACHE" ]]; then
    echo -e "Downloading themes from ${Src}$REMOTE${Off} to ${Dst}$CACHE${Off}.";
    git clone "https://github.com/$REMOTE.git" "$CACHE";
  else
    echo -e "Syncing ${Dst}$CACHE${Off} with ${Src}$REMOTE${Off}.";
    git -C "$CACHE" checkout "$BRANCH" || exit 1;
    git -C "$CACHE" pull origin || exit 1;
  fi
}

strip () {
  #
  # strips the themes in the cache to
  # keep only relevant colors
  #
  if [[ -d "$CACHE" ]]; then
    [ -f "$colordatabase" ] && rm "$colordatabase"
    [ -f "$colorpreview" ] && rm "$colorpreview"
    echo "${_columns[@]}" | tr ' ' ',' | tee "$colordatabase" -a > /dev/null
    for theme in $(ls "$CACHE/themes" | sed 's/\.conf$//g');
    do
      echo -en "Stripping ${Src}$theme${Off}... "
      colors=$(grep -Ev 'cursor|active|^\$|^#|url|mark|color ' "$CACHE/themes/$theme.conf" |\
        sed 's/background/bg/; s/foreground/fg/; s/selection/sel/; /^\s*$/d;' |\
        sed 's/^color//g; s/\s\+/ /g;' |\
        sort -g | head -n 20)
      nb_lines=$(echo "$colors" | wc -l)
      if [ "$nb_lines" = "$_nb_colors" ];
      then
        # append the line to the theme database.
        colors="$(echo "$colors" | awk '{print $2}' | tr '\n' ',' | sed 's/,\s*$//g')"
        echo "$theme,$colors" | tee "$colordatabase" -a > /dev/null
        # add the theme preview to $colorpreview
        _gencols.fish "$(echo "$theme,$colors")" | tee "$colorpreview" -a > /dev/null
        echo -e "${Ok}ok${Off}"
      else
        # explain a bit the error to the user.
        echo -e "${Err}not ok${Off} (${Wrn}expected $_nb_colors colors but got $nb_lines${Off})"
        if ! echo "$colors" | grep -e "bg" -q;
        then
          echo -e "${Wrn}  missing bg${Off}"
        fi
        if ! echo "$colors" | grep -e "fg" -q;
        then
          echo -e "${Wrn}  missing fg${Off}"
        fi
        if ! echo "$colors" | grep -e "sel_bg" -q;
        then
          echo -e "${Wrn}  missing sel_bg${Off}"
        fi
        if ! echo "$colors" | grep -e "sel_fg" -q;
        then
          echo -e "${Wrn}  missing sel_fg${Off}"
        fi
      fi
    done
    echo "${Dst}Done${Off}"
  else
    echo -e "No cache to clean at ${Pmt}$CACHE${Off}."
    echo -e "Consider using ${Tip}themes.sh -u${Off} to update the cache.";
  fi
}

print () {
  #
  # print the whole database.
  #
  if [[ -f "$colordatabase" ]]; then
    if command -v bat &> /dev/null; then
      bat "$colordatabase"
    else
      less "$colordatabase"
    fi
  else
    echo -e "No database at ${Pmt}$colordatabase${Off}."
    echo -e "Consider using ${Tip}themes.sh -s${Off} to generate the ${Dst}$colordatabase${Off} database.";
  fi
}

preview () {
  #
  # preview the whole database.
  #
  if [[ -f "$colorpreview" ]]; then
    if command -v bat &> /dev/null; then
      bat "$colorpreview"
    else
      less "$colorpreview"
    fi
  else
    echo -e "No database at ${Pmt}$colorpreview${Off}."
    echo -e "Consider using ${Tip}themes.sh -s${Off} to generate the ${Dst}$colorpreview${Off} database.";
  fi
}

clean () {
  #
  # clean the whole cache.
  #
  if [[ -d "$CACHE" ]]; then
    echo -e "Cleaning cache at ${Src}$CACHE${Off}.";
    rm -rf "$CACHE";
  else
    echo -e "No cache to clean at ${Pmt}$CACHE${Off}."
    echo -e "Consider using ${Tip}themes.sh -u${Off} to update the cache.";
  fi
}

qtile_cfg () {
  #
  # Change the theme of qtile.
  #

  # change all the fields
  fields=(bg fg sel_bg sel_fg color0 color1 color2 color3 color4 color5 color6 color7 color8 color9 color10 color11 color12 color13 color14 color15)
  for i in $(seq 0 19);
  do
    sed -i "s/\(\s*\"${fields[$i]}\": \"\)#......\",\s*\$/\1$(echo "$1" | awk -F, "{print \$$(($i+1))}")\",/" "$QTILE/theme.py"
  done
  # change the name of the current theme
  sed -i "s/# current: .*/# current: $2/" "$QTILE/theme.py"
  # restart qtile
  if pgrep qtile > /dev/null;
  then
    qtile cmd-obj -o cmd -f restart
  fi
  # changes the conky as well
  sed -i "s/\(\s\+color0\s\+=\s\+\)'#......',/\1'$(echo "$1" | awk -F, "{print \$9}")',/" "$CONKY/qtile.conkyrc"
  sed -i "s/\(\s\+color1\s\+=\s\+\)'#......',/\1'$(echo "$1" | awk -F, "{print \$12}")',/" "$CONKY/qtile.conkyrc"
  sed -i "s/\(\s\+color2\s\+=\s\+\)'#......',/\1'$(echo "$1" | awk -F, "{print \$11}")',/" "$CONKY/qtile.conkyrc"
  sed -i "s/\(\s\+color3\s\+=\s\+\)'#......',/\1'$(echo "$1" | awk -F, "{print \$7}")',/" "$CONKY/qtile.conkyrc"
  sed -i "s/\(\s\+--Colors \).*/\1$2/" "$CONKY/qtile.conkyrc"
}

dunst_cfg () {
  #
  # change the theme of the dunst notification server.
  #
  # update the theme inside the dunstrc config file
  bg=$(echo "$1" | awk -F, "{print \$1}")
  cfg=$(echo "$1" | awk -F, "{print \$6}")
  cfc=$(echo "$1" | awk -F, "{print \$16}")
  nfg=$(echo "$1" | awk -F, "{print \$9}")
  lfg=$(echo "$1" | awk -F, "{print \$12}")
  sed -i "s/\(\s\+background\s\+=\s\+\"\)#......\(\"  # URGENCY_CRITICAL BG\)/\1$bg\2/" "$DUNST"
  sed -i "s/\(\s\+background\s\+=\s\+\"\)#......\(\"  # URGENCY_NORMAL BG\)/\1$bg\2/" "$DUNST"
  sed -i "s/\(\s\+background\s\+=\s\+\"\)#......\(\"  # URGENCY_LOW BG\)/\1$bg\2/" "$DUNST"
  sed -i "s/\(\s\+foreground\s\+=\s\+\"\)#......\(\"  # URGENCY_CRITICAL FG\)/\1$cfg\2/" "$DUNST"
  sed -i "s/\(\s\+foreground\s\+=\s\+\"\)#......\(\"  # URGENCY_NORMAL FG\)/\1$nfg\2/" "$DUNST"
  sed -i "s/\(\s\+foreground\s\+=\s\+\"\)#......\(\"  # URGENCY_LOW FG\)/\1$lfg\2/" "$DUNST"
  sed -i "s/\(\s\+frame_color\s\+=\s\+\"\)#......\(\"  # URGENCY_CRITICAL FC\)/\1$cfc\2/" "$DUNST"
  # change the name of the theme.
  sed -i "s/# THEME: .*/# THEME: $2/" "$DUNST"
  # restart dunst and show a preview
  killall dunst
  dunst -conf "$DUNST" &
  dunstify "$(echo $theme | sed 's/.conf$//')" "this is a critical test" -u critical -t 10000
  dunstify "$(echo $theme | sed 's/.conf$//')" "this is a normal test" -u normal -t 10000
  dunstify "$(echo $theme | sed 's/.conf$//')" "this is a low test" -u low -t 10000
  dunstify "$(echo $theme | sed 's/.conf$//') (sample progress bar)" -h "int:value:40" -u low --icon=/usr/share/icons/Adwaita/16x16/legacy/audio-volume-medium.png -t 10000
}

alacritty_cfg () {
  #
  # change the theme of the alacritty terminal emulator.
  #
  sed -i "s/\(\s*background\s*:\s*'0x\)......\('\s*# PRIMARY\)/\1$(echo "$1" | awk -F, '{print $1}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*foreground\s*:\s*'0x\)......\('\s*# PRIMARY\)/\1$(echo "$1" | awk -F, '{print $2}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*text\s*:\s*'0x\)......\('\s*# CURSOR\)/\1$(echo "$1" | awk -F, '{print $3}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*cursor\s*:\s*'0x\)......\('\s*# CURSOR\)/\1$(echo "$1" | awk -F, '{print $4}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*black\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $5}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*red\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $6}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*green\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $7}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*yellow\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $8}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*blue\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $9}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*magenta\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $10}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*cyan\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $11}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*white\s*:\s*'0x\)......\('\s*# NORMAL\)/\1$(echo "$1" | awk -F, '{print $12}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*black\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $13}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*red\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $14}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*green\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $15}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*yellow\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $16}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*blue\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $17}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*magenta\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $18}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*cyan\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $19}' | sed 's/#//')\2/" "$ALACRITTY"
  sed -i "s/\(\s*white\s*:\s*'0x\)......\('\s*# BRIGHT\)/\1$(echo "$1" | awk -F, '{print $20}' | sed 's/#//')\2/" "$ALACRITTY"
  # change the name of the theme.
  sed -i "s/\(\s*# COLORSCHEME: \).*/\1$2/" "$ALACRITTY"
}

kitty_cfg () {
  #
  # change the theme of the kitty terminal emulator.
  #
  sed -i "s/\(^background\s*\)#....../\1$(echo "$1" | awk -F, '{print $1}')/" "$KITTY"
  sed -i "s/\(^foreground\s*\)#....../\1$(echo "$1" | awk -F, '{print $2}')/" "$KITTY"
  sed -i "s/\(^selection_background \s*\)#....../\1$(echo "$1" | awk -F, '{print $3}')/" "$KITTY"
  sed -i "s/\(^selection_foreground \s*\)#....../\1$(echo "$1" | awk -F, '{print $4}')/" "$KITTY"
  sed -i "s/\(^color0\s*\)#....../\1$(echo "$1" | awk -F, '{print $5}')/" "$KITTY"
  sed -i "s/\(^color1\s*\)#....../\1$(echo "$1" | awk -F, '{print $6}')/" "$KITTY"
  sed -i "s/\(^color2\s*\)#....../\1$(echo "$1" | awk -F, '{print $7}')/" "$KITTY"
  sed -i "s/\(^color3\s*\)#....../\1$(echo "$1" | awk -F, '{print $8}')/" "$KITTY"
  sed -i "s/\(^color4\s*\)#....../\1$(echo "$1" | awk -F, '{print $9}')/" "$KITTY"
  sed -i "s/\(^color5\s*\)#....../\1$(echo "$1" | awk -F, '{print $10}')/" "$KITTY"
  sed -i "s/\(^color6\s*\)#....../\1$(echo "$1" | awk -F, '{print $11}')/" "$KITTY"
  sed -i "s/\(^color7\s*\)#....../\1$(echo "$1" | awk -F, '{print $12}')/" "$KITTY"
  sed -i "s/\(^color8\s*\)#....../\1$(echo "$1" | awk -F, '{print $13}')/" "$KITTY"
  sed -i "s/\(^color9\s*\)#....../\1$(echo "$1" | awk -F, '{print $14}')/" "$KITTY"
  sed -i "s/\(^color10\s*\)#....../\1$(echo "$1" | awk -F, '{print $15}')/" "$KITTY"
  sed -i "s/\(^color11\s*\)#....../\1$(echo "$1" | awk -F, '{print $16}')/" "$KITTY"
  sed -i "s/\(^color12\s*\)#....../\1$(echo "$1" | awk -F, '{print $17}')/" "$KITTY"
  sed -i "s/\(^color13\s*\)#....../\1$(echo "$1" | awk -F, '{print $18}')/" "$KITTY"
  sed -i "s/\(^color14\s*\)#....../\1$(echo "$1" | awk -F, '{print $19}')/" "$KITTY"
  sed -i "s/\(^color15\s*\)#....../\1$(echo "$1" | awk -F, '{print $20}')/" "$KITTY"
  # change the name of the theme.
  sed -i "s/\(^# THEME: \).*/\1$2/" "$KITTY"
}

dmenu_cfg () {
  #
  # change the theme of dmenu.
  #
  [ ! -f "$SUCKLESS/dmenu/config.h" ] && cp "$SUCKLESS/dmenu/config.def.h" "$SUCKLESS/dmenu/config.h"
  sed -i "s/\(\[SchemeSel\]            = { \"\)#......\", \"#......\(\" },\)/\1$(echo "$1" | awk -F, '{print $5}')\", \"$(echo "$1" | awk -F, '{print $10}')\2/" "$SUCKLESS/dmenu/config.h"
  sed -i "s/\(\[SchemeSelOut\]         = { \"\)#......\", \"#......\(\" },\)/\1$(echo "$1" | awk -F, '{print $5}')\", \"$(echo "$1" | awk -F, '{print $11}')\2/" "$SUCKLESS/dmenu/config.h"
  sed -i "s/\(\[SchemeMid\]            = { \"\)#......\", \"#......\(\" },\)/\1$(echo "$1" | awk -F, '{print $2}')\", \"$(echo "$1" | awk -F, '{print $3}')\2/" "$SUCKLESS/dmenu/config.h"
  sed -i "s/\(\[SchemeMidOut\]         = { \"\)#......\", \"#......\(\" },\)/\1$(echo "$1" | awk -F, '{print $2}')\", \"$(echo "$1" | awk -F, '{print $13}')\2/" "$SUCKLESS/dmenu/config.h"
  sed -i "s/\(\[SchemeSelHighlight\]   = { \"\)#......\", \"#......\(\" },\)/\1$(echo "$1" | awk -F, '{print $7}')\", \"$(echo "$1" | awk -F, '{print $5}')\2/" "$SUCKLESS/dmenu/config.h"
  sed -i "s/\(\[SchemeNormHighlight\]  = { \"\)#......\", \"#......\(\" },\)/\1$(echo "$1" | awk -F, '{print $7}')\", \"$(echo "$1" | awk -F, '{print $5}')\2/" "$SUCKLESS/dmenu/config.h"
  sed -i "s/\(\[SchemeNorm\]           = { \"\)#......\", \"#......\(\" },\)/\1$(echo "$1" | awk -F, '{print $2}')\", \"$(echo "$1" | awk -F, '{print $1}')\2/" "$SUCKLESS/dmenu/config.h"
  sed -i "s/\(\[SchemeOut\]            = { \"\)#......\", \"#......\(\" },\)/\1$(echo "$1" | awk -F, '{print $5}')\", \"$(echo "$1" | awk -F, '{print $2}')\2/" "$SUCKLESS/dmenu/config.h"
  # change the name of the theme.
  sed -i "s/\(^\/\/ THEME: \).*/\1$2/" "$SUCKLESS/dmenu/config.h"
  cd "$SUCKLESS/dmenu" > /dev/null || exit 1
  sudo make clean install
  cd - > /dev/null || exit 1
}

st_cfg () {
  #
  # change the theme of st.
  #
  [ ! -f "$SUCKLESS/st/config.h" ] && cp "$SUCKLESS/st/config.def.h" "$SUCKLESS/st/config.h"
  sed -i "s/\[16\] = \"#......\",/[16] = \"$(echo "$1" | awk -F, '{print $1}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[17\] = \"#......\",/[17] = \"$(echo "$1" | awk -F, '{print $2}')\",/" "$SUCKLESS/st/config.h"
  # no selection foreground nor background
  sed -i "s/\[0\] = \"#......\",/[0] = \"$(echo "$1" | awk -F, '{print $5}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[1\] = \"#......\",/[1] = \"$(echo "$1" | awk -F, '{print $6}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[2\] = \"#......\",/[2] = \"$(echo "$1" | awk -F, '{print $7}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[3\] = \"#......\",/[3] = \"$(echo "$1" | awk -F, '{print $8}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[4\] = \"#......\",/[4] = \"$(echo "$1" | awk -F, '{print $9}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[5\] = \"#......\",/[5] = \"$(echo "$1" | awk -F, '{print $10}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[6\] = \"#......\",/[6] = \"$(echo "$1" | awk -F, '{print $11}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[7\] = \"#......\",/[7] = \"$(echo "$1" | awk -F, '{print $12}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[8\] = \"#......\",/[8] = \"$(echo "$1" | awk -F, '{print $13}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[9\] = \"#......\",/[9] = \"$(echo "$1" | awk -F, '{print $14}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[10\] = \"#......\",/[10] = \"$(echo "$1" | awk -F, '{print $15}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[11\] = \"#......\",/[11] = \"$(echo "$1" | awk -F, '{print $16}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[12\] = \"#......\",/[12] = \"$(echo "$1" | awk -F, '{print $17}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[13\] = \"#......\",/[13] = \"$(echo "$1" | awk -F, '{print $18}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[14\] = \"#......\",/[14] = \"$(echo "$1" | awk -F, '{print $19}')\",/" "$SUCKLESS/st/config.h"
  sed -i "s/\[15\] = \"#......\",/[15] = \"$(echo "$1" | awk -F, '{print $20}')\",/" "$SUCKLESS/st/config.h"
  # change the name of the theme.
  sed -i "s/\(^\/\/ THEME: \).*/\1$2/" "$SUCKLESS/st/config.h"
  cd "$SUCKLESS/st" > /dev/null || exit 1
  sudo make clean install
  cd - > /dev/null || exit 1
  [ "$(echo -e "No\nYes" | dmenu -c -l 2 -bw 5 -i -p "Kill all instances of st to apply changes: ")" = "Yes" ] && killall st
}

doom_cfg () {
  #
  # change the theme of doom emacs.
  #
  sed -i "s/^\(\*fadeColor:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $5}')/" "$XRESOURCES"
  sed -i "s/^\(\*background:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $1}')/" "$XRESOURCES"
  sed -i "s/^\(\*foreground:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $2}')/" "$XRESOURCES"
  sed -i "s/^\(\*pointerColorBackground:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $3}')/" "$XRESOURCES"
  sed -i "s/^\(\*pointerColorForeground:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $4}')/" "$XRESOURCES"
  sed -i "s/^\(\*cursorColor:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $4}')/" "$XRESOURCES"
  sed -i "s/^\(\*color0:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $5}')/" "$XRESOURCES"
  sed -i "s/^\(\*color1:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $6}')/" "$XRESOURCES"
  sed -i "s/^\(\*color2:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $7}')/" "$XRESOURCES"
  sed -i "s/^\(\*color3:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $8}')/" "$XRESOURCES"
  sed -i "s/^\(\*color4:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $9}')/" "$XRESOURCES"
  sed -i "s/^\(\*color5:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $10}')/" "$XRESOURCES"
  sed -i "s/^\(\*color6:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $11}')/" "$XRESOURCES"
  sed -i "s/^\(\*color7:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $12}')/" "$XRESOURCES"
  sed -i "s/^\(\*color9:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $13}')/" "$XRESOURCES"
  sed -i "s/^\(\*color8:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $14}')/" "$XRESOURCES"
  sed -i "s/^\(\*color10:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $15}')/" "$XRESOURCES"
  sed -i "s/^\(\*color11:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $16}')/" "$XRESOURCES"
  sed -i "s/^\(\*color12:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $17}')/" "$XRESOURCES"
  sed -i "s/^\(\*color13:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $18}')/" "$XRESOURCES"
  sed -i "s/^\(\*color14:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $19}')/" "$XRESOURCES"
  sed -i "s/^\(\*color15:\s\+\)#....../\1$(echo "$1" | awk -F, '{print $20}')/" "$XRESOURCES"
  # change the name of the theme.
  sed -i "s/\(^! THEME: \).*/\1$2/" "$XRESOURCES"
  xrdb "$XRESOURCES"
  [ "$(echo -e "No\nYes" | dmenu -c -l 2 -bw 5 -i -p "Kill all instances of emacs to apply changes: ")" = "Yes" ] && killall emacs
}

theme () {
  #
  # let the user pick a theme.
  # $1 is a preselected theme with the -t=THEME switch.
  #
  theme=$(echo "$1" | sed 's/^\s*//g; s/\s*$//g')
  [ ! "$theme" ] && theme="DEFAULT_TO_DMENU"
  if [[ -f "$colordatabase" ]]; then
    if ! awk -F, '{print $1}' "$colordatabase" | grep -we "$(echo $theme | sed 's/ /_/g')" -q;
    then
      echo -e "${Err}'$theme' not in $colordatabase${Off}"
      theme=$(tail -n +2 "$colordatabase" | awk -F, '{print $1}' | sed 's/_/ /g' | dmenu -bw 5 -c -l 20 -i -p "Choose a theme: ")
      [ ! "$theme" ] && { echo -e "${Wrn}No theme selected${Off}"; exit 0; }
      echo -e "${Ok}'$theme' selected${Off}"
    else 
      echo -e "${Tip}'$theme' found in $colordatabase${Off}"
    fi
    theme=$(echo "$theme" | sed 's/ /_/g')
    colors=$(grep -w "$theme" "$colordatabase" | sed "s/$theme,//")
    for config in $(echo "$2" | tr ',' ' ');do
      case "$config" in
        qtile ) qtile_cfg "$colors" "$theme";;
        dunst ) dunst_cfg "$colors" "$theme";;
        alacritty ) alacritty_cfg "$colors" "$theme";;
        kitty ) kitty_cfg "$colors" "$theme";;
        doom ) doom_cfg "$colors" "$theme";;
        dmenu ) dmenu_cfg "$colors" "$theme";;
        st ) st_cfg "$colors" "$theme";;
        * ) echo "an error occured (got unexpected config '$config')"; exit 1 ;;
      esac
    done
  else
    echo -e "No database at ${Pmt}$colordatabase${Off}."
    echo -e "Consider using ${Tip}themes.sh -s${Off} to generate the ${Dst}$colordatabase${Off} database.";
  fi
}

usage () {
  #
  # the usage function.
  #
  echo "Usage: themes.sh [-huscpaP] [-t=THEME] [-C=C1,C2]"
  echo "Type -h or --help for the full help."
  exit 0
}

help () {
  #
  # the help function.
  #
  echo "themes.sh:"
  echo "     This script allows the user to easily download"
  echo "     preprocess and change colorschemes."
  echo "     Do not forget to puth it in your PATH."
  echo ""
  echo "Usage:"
  echo "     themes.sh [-huscpaP] [-t=THEME] [-C=C1,C2]"
  echo ""
  echo "Switches:"
  echo "     -h/--help           shows this help."
  echo "     -u/--update         download the database or sync the repo."
  echo "     -s/--strip          strip the theme files to keep only relevant colors."
  echo "     -c/--clean          clean the cache."
  echo "     -p/--print          print the local database."
  echo "     -P/--preview        preview the local database."
  echo "     -t/--theme[=THEME]  pick a theme from the local database, possibly with default one."
  echo "     -C/--config=C1,C2   give the configs to apply the selected theme on."
  echo "     -a/--all            same as -C=all."
  echo ""
  echo "Environment variables:"
  echo "     REMOTE              the remote database (defaults to 'a2n-s/themes)"
  echo "     BRANCH              the branch to use on the remote (defaults to 'main')"
  echo "     CACHE**             the location of the cache (set to '\$HOME/.cache/all-themes')"
  echo "     QTILE               the path to the qtile config (defaults to '\$HOME/.config/qtile')"
  echo "     DUNST               the path to the dunst config file (defaults to '\$HOME/.config/dunst/dunstrc')"
  echo "     ALACRITTY           the path to the alacritty config file (defaults to '\$HOME/.config/alacritty/alacritty.yml')"
  echo "     KITTY               the path to the kitty config file (defaults to '\$HOME/.config/kitty/kitty.conf')"
  echo "     CONKY               the path to all the conky configs (defaults to '\$HOME/.config/conky')"
  echo "     SUCKLESS            the path to the suckless source codes (defaults to '\$HOME/ghq/git.suckless.org')"
  echo "     XRESOURCES          the location of the xresources, used for Doom Emacs (defaults to '\$HOME/.Xresources)"
  echo " ** cannot be changed"
  exit 0
}

# parse the arguments.
OPTIONS=$(getopt -o huscpt::C:aP --long help,update,strip,clean,print,theme::,config:,all,preview -n 'themes.sh' -- "$@")
if [ $? != 0 ] ; then usage >&2 ; exit 1 ; fi
eval set -- "$OPTIONS"

main () {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h | --help ) help ;;
      -u | --update ) ACTION="update"; shift 1 ;;
      -s | --strip ) ACTION="strip"; shift 1 ;;
      -c | --clean ) ACTION="clean"; shift 1 ;;
      -p | --print ) ACTION="print"; shift 1 ;;
      -P | --preview ) ACTION="preview"; shift 1 ;;
      -t | --theme ) ACTION="theme"; theme="$(echo "$2" | sed 's/^=//')" ; shift 2;;
      -C | --config ) ACTION="theme"; CONFIG="$(echo "$2" | sed 's/^=//')"; shift 2 ;;
      -a | --all ) CONFIG="all"; shift 1 ;;
      -- ) shift; break ;;
      * ) break ;;
    esac
  done
  [ "$CONFIG" = "all" ] && CONFIG="$configs"

  # an action is required
  [ -z "$ACTION" ] && usage
  case "$ACTION" in
    update ) update ;;
    strip )  strip ;;
    clean )  clean ;;
    print )  print ;;
    preview )  preview ;;
    theme )  theme "$theme" "$CONFIG" ;;
    * ) echo "an error occured (got unexpected action '$ACTION')"; exit 1 ;;
  esac
}

main "$@"
