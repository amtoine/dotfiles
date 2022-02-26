#!/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __                  _     __      ____  __     _                      _   _               _
#      ___   / /  ____ __  ___ __| |_ _ \ \    / /  \/  |___| |__  __ _ _ _ __ _ __| |_(_)___ _ _    __| |_
#     (_-<  / /  (_-< '_ \/ -_) _|  _| '_\ \/\/ /| |\/| |___| '_ \/ _` | '_/ _` / _|  _| / _ \ ' \ _(_-< ' \
#     /__/ /_/   /__/ .__/\___\__|\__|_|  \_/\_/ |_|  |_|   |_.__/\__,_|_| \__,_\__|\__|_\___/_||_(_)__/_||_|
#                   |_|
#
# Description:   the baraction script for the spectwm windows manager.
# Dependencies:  mpstat, amixer, nmcli, ifstat, setxkbmap, play.
# License:       https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

hostname="${HOSTNAME:-${hostname:-$(hostname)}}"

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#              DISK
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<

hddicon() {
#  echo "HDD"
  echo ""
}
hdd() {
  free="$(df -h /home | grep /dev | awk '{print $3}' | sed 's/G/Gb/')"
  perc="$(df -h /home | grep /dev/ | awk '{print $5}')"
  cache=$(du ~/.cache/ -sh | awk '{ print $1 }')
  venvs=$(du ~/.venvs/ -sh | awk '{ print $1 }')
  echo "$perc($free/$cache/$venvs)"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#              RAM
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
memicon() {
#  echo "MEM"
  echo ""
}

mem() {
  used="$(free | grep Mem: | awk '{print $3}')"
  total="$(free | grep Mem: | awk '{print $2}')"
  human="$(free -h | grep Mem: | awk '{print $3}' | sed s/i//g)"
  ram="$(( 200 * $used/$total - 100 * $used/$total ))%($human)"
  echo "$ram"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#              CPU
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
cpuicon() {
#  echo "CPU"
  echo ""
}
cpu() {
  echo "$(mpstat | tail -n 1 | awk '{print $3}')%"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#            VOLUME
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
volicon() {
#  echo "VOL"
  stat=$(amixer get Master | grep "Mono:" | sed 's/[][]//g' | awk '{ print $6 }')
  if [[ $stat = "on" ]]; then
      echo ""
  else
      echo "婢"
  fi
}
vol() {
  amixer get Master | grep "Mono:" | sed 's/[][]//g' | awk '{ print $4 }'
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#          PACKAGES
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
pkgicon() {
#  echo "PKGs"
  echo ""
}
pkgs() {
  pkgs=$(pacman -Qq | wc -l)
  echo "$pkgs"
}
removable() {
  rems=$(pacman -Qdt | wc -l)
  echo "$rems"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#           NETWORK
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
networkicon() {
  wire="$(ip a | grep "eth" | grep inet | wc -l)"
  wifi="$(ip a | grep "wl" | grep inet | wc -l)"

  if [ $wire = 1 ]; then
      echo ""
  elif [ $wifi = 1 ]; then
      echo ""
  else
      echo "睊"
  fi
}
connection() {
  echo "$(nmcli d | grep "\<connected\>" | awk '{ print $4 }')"
}
upicon(){
  echo "TX"
}
downicon(){
  echo "RX"
}
up(){
  ifstat | grep $(nmcli d | grep "\<connected\>" | awk '{ print $1 }') | awk '{ print $9}'
}
down(){
  ifstat | grep $(nmcli d | grep "\<connected\>" | awk '{ print $1 }') | awk '{ print $7}'
}
ipaddress() {
  address=$(ip a | grep \.255 | awk '{ print $2 }' | cut -d/ -f1)
  echo "$address"
}
vpnicon(){
  echo "VPN"
}
vpnconnection() {
  state="$(ip a | grep tun0 | grep inet | wc -l)"

  if [ $state = 1 ]; then
    echo "ﱾ"
  else
      echo ""
  fi
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#           ENTROPY
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
entropyicon() {
#  echo "ENT"
  echo "✨"
}
entropy(){
  echo "$(cat /proc/sys/kernel/random/entropy_avail)"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#           BATTERY
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
batstat() {
  stat="$(cat /sys/class/power_supply/BAT0/status)"
  echo "$stat"
}
batlevel() {
  level="$(cat /sys/class/power_supply/BAT0/capacity)"
  echo "$level"
}
baticon() {
  bat_stat="$(batstat)"
  bat_level="$(batlevel)"
  if [[ $bat_stat = 'Unknown' ]]; then
    bat_icon="x"
  elif [[ $bat_stat = 'Charging' ]]; then
    bat_icon=""
  elif [[ $bat_level -eq 100 ]] && [[ $bat_stat = 'Not charging' ]]; then
    bat_icon=""
  elif [[ $bat_level -ge 5 ]] && [[ $bat_level -le 19 ]]; then
    bat_icon=""
  elif [[ $bat_level -ge 20 ]] && [[ $bat_level -le 39 ]]; then
    bat_icon=""
  elif [[ $bat_level -ge 40 ]] && [[ $bat_level -le 59 ]]; then
    bat_icon=""
  elif [[ $bat_level -ge 60 ]] && [[ $bat_level -le 79 ]]; then
    bat_icon=""
  elif [[ $bat_level -ge 80 ]] && [[ $bat_level -le 95 ]]; then
    bat_icon=""
  elif [[ $bat_level -ge 96 ]] && [[ $bat_level -le 100 ]]; then
    bat_icon=""
  fi
  echo "$bat_icon"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#        DATE AND TIME
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
dateicon() {
  echo "DATE"
}
clockicon() {
  CLOCK=$(date '+%I')

  case "$CLOCK" in
  "00") icon="" ;;
  "01") icon="" ;;
  "02") icon="" ;;
  "03") icon="" ;;
  "04") icon="" ;;
  "05") icon="" ;;
  "06") icon="" ;;
  "07") icon="" ;;
  "08") icon="" ;;
  "09") icon="" ;;
  "10") icon="" ;;
  "11") icon="" ;;
  "12") icon="" ;;
  esac

  echo "$(date "+$icon")"
}
dateinfo() {
  echo "$(date "+%D")"
}
clockinfo() {
  echo $(date +"%H:%M:%S")
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#       KEYBOARD LAYOUT
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
kbicon() {
  echo "KB"
}
kbinfo() {
  setxkbmap -query | grep layout | awk '{ print $2 }'
}


# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#         BAR PRINT
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
DELAY=1
#loops forever outputting a line every SLEEP_SEC secs
while :; do
    bat_level=$(batlevel)
    bat_stat=$(batstat)
    if [[ "$bat_level" -le 15  && "$bat_stat" = "Discharging" ]]; then
      play -q -n synth .05 sine 880 vol 0.02
      if [[ $bat_color = "+@fg=6;" ]]; then bat_color="+@fg=2;"; else bat_color="+@fg=6;"; fi;
    elif [[ "$bat_level" -ge 85 ]] && [[ "$bat_stat" = "Charging" || "$bat_stat" = "Not charging" ]]; then
      if [[ $bat_color = "+@fg=6;" ]]; then bat_color="+@fg=1;"; else bat_color="+@fg=6;"; fi;
    else bat_color="+@fg=6;";
    fi
    echo -e "+@fg=1;$(cpuicon) +@fg=4;$(cpu) +@fg=0;| \
+@fg=1;$(memicon) +@fg=4;$(mem) +@fg=0;| \
+@fg=1;$(pkgicon) +@fg=4;$(pkgs) +@fg=0;/ +@fg=4;$(removable) +@fg=0;| \
+@fg=1;$(hddicon) +@fg=4;$(hdd) +@fg=0;| \
+@fg=1;$(networkicon) +@fg=4;$(connection)@$(ipaddress) $(vpnconnection) +@fg=0;| \
+@fg=1;$(upicon) +@fg=4;$(up) +@fg=1;$(downicon) +@fg=4;$(down) +@fg=0;| \
+@fg=1;$(entropyicon) +@fg=4;$(entropy) +@fg=0;| \
+@fg=1;$(volicon) +@fg=4;$(vol) +@fg=0;| \
$bat_color$(baticon)  $bat_level% +@fg=0;| \
+@fg=1;$(kbicon) +@fg=4;$(kbinfo) +@fg=0;| \
+@fg=4;$(dateinfo) +@fg=1;$(clockicon) +@fg=4;$(clockinfo) +@fg=0;\
"
  sleep $DELAY
done

