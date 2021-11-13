#!/bin/bash
#                            __      _       ____  ___   __                             __  _
#      _________  ___  _____/ /_____| |     / /  |/  /  / /_  ____ ______   ____ ______/ /_(_)___  ____
#     / ___/ __ \/ _ \/ ___/ __/ ___/ | /| / / /|_/ /  / __ \/ __ `/ ___/  / __ `/ ___/ __/ / __ \/ __ \
#    (__  ) /_/ /  __/ /__/ /_/ /   | |/ |/ / /  / /  / /_/ / /_/ / /     / /_/ / /__/ /_/ / /_/ / / / /
#   /____/ .___/\___/\___/\__/_/    |__/|__/_/  /_/  /_.___/\__,_/_/      \__,_/\___/\__/_/\____/_/ /_/
#       /_/
#
# Example Bar Action Script for Linux.
# Requires: acpi, iostat, ...
# Tested on: (with newest spectrwm built from source), ...
# This config can be found on github.com/a2n-s

hostname="${HOSTNAME:-${hostname:-$(hostname)}}"

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#              DISK
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<

hddicon() {
  echo "HDD"
}
hdd() {
  free="$(df -h /home | grep /dev | awk '{print $3}' | sed 's/G/Gb/')"
  perc="$(df -h /home | grep /dev/ | awk '{print $5}')"
  echo "$perc  ($free)"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#              RAM
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
memicon() {
  echo "MEM"
}

mem() {
  used="$(free | grep Mem: | awk '{print $3}')"
  total="$(free | grep Mem: | awk '{print $2}')"
  human="$(free -h | grep Mem: | awk '{print $3}' | sed s/i//g)"
  ram="$(( 200 * $used/$total - 100 * $used/$total ))% ($human) "
  echo "$ram"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#              CPU
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
cpuicon() {
  echo "CPU"
}
cpu() {
  echo "$(mpstat | tail -n 1 | awk '{print $3}')%"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#            VOLUME
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
volicon() {
  echo "VOL"
}
vol() {
  echo ""
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#          PACKAGES
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
pkgicon() {
  echo "PKGs"
}
pkgs() {
  pkgs=$(pacman -Qq | wc -l)
  echo "$pkgs"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#          REMOVABLE
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
remicon() {
  echo "REM"
}
rem() {
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
  	echo "WIRE"
  elif [ $wifi = 1 ]; then
  	echo "WIFI"
  else
  	echo "OFF"
  fi
}
connection() {
  echo "$(nmcli d | grep "\<connected\>" | awk '{ print substr($0, index($0,$4)) }')"
}
ipaddress() {
  address="$(ip a | grep .255 | grep -v wlp | cut -d ' ' -f6 | sed 's/\/24//')"
  echo "$address"
}
vpnconnection() {
  state="$(ip a | grep tun0 | grep inet | wc -l)"

  if [ $state = 1 ]; then
  	echo "VPN"
  else
  	echo "NO VPN"
  fi
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

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#           ENTROPY
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
entropyicon() {
  echo "ENT"
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
battery() {
  battery="$(cat /sys/class/power_supply/BAT0/capacity)"
  echo "$battery"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#        DATE AND TIME
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
clockicon() {
  echo "CLK"
}
dateinfo() {
  echo "$(date "+%b %d %Y (%a)")"
}
clockinfo() {
  echo $(date +"%H %M %S")
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#         BAR PRINT
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
DELAY=0.5
#loops forever outputting a line every SLEEP_SEC secs
while :; do
  bat_level=$(battery)
  bat_stat=$(batstat)
  if [[ "$bat_level" -le 15  && "$bat_stat" = "Discharging" ]]; then 
      play -q -n synth .05 sine 880 vol 0.02
      if [[ $bat_color = "+@fg=6;" ]]; then bat_color="+@fg=2;"; else bat_color="+@fg=6;"; fi;
  elif [[ "$bat_level" -ge 85  && "$bat_stat" = "Charging" ]]; then 
      if [[ $bat_color = "+@fg=6;" ]]; then bat_color="+@fg=1;"; else bat_color="+@fg=6;"; fi;
  else bat_color="+@fg=6;"; fi
  echo -e "+@fg=1; $(cpuicon) +@fg=0; $(cpu) | 
+@fg=1; $(memicon) +@fg=0; $(mem) | \
+@fg=1; $(pkgicon) +@fg=0; $(pkgs) | \
+@fg=1; $(remicon) +@fg=0; $(rem) | \
+@fg=3; $(hddicon) +@fg=0; $(hdd) | \
+@fg=4; $(networkicon) $(connection) +@fg=0; $(ipaddress) +@fg=4; $(vpnconnection) | \
+@fg=4; $(upicon) $(up) +@fg=0; $(downicon) +@fg=4; $(down) | \
+@fg=3; $(entropyicon) +@fg=0; $(entropy) | \
+@fg=5; $(volicon) +@fg=0; $(vol) | \
$bat_color $bat_stat $bat_level % +@fg=0; | \
+@fg=1; $(dateinfo) +@fg=4; $(clockicon) +@fg=0; $(clockinfo) |\
"
  sleep $DELAY
done

