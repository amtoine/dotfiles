#!/bin/bash
#                            __      _       ____  ___   __                             __  _
#      _________  ___  _____/ /_____| |     / /  |/  /  / /_  ____ ______   ____ ______/ /_(_)___  ____
#     / ___/ __ \/ _ \/ ___/ __/ ___/ | /| / / /|_/ /  / __ \/ __ `/ ___/  / __ `/ ___/ __/ / __ \/ __ \
#    (__  ) /_/ /  __/ /__/ /_/ /   | |/ |/ / /  / /  / /_/ / /_/ / /     / /_/ / /__/ /_/ / /_/ / / / /
#   /____/ .___/\___/\___/\__/_/    |__/|__/_/  /_/  /_.___/\__,_/_/      \__,_/\___/\__/_/\____/_/ /_/
#       /_/
#
# Example Bar Action Script for Linux.
# Requires: acpi, iostat, lm-sensors, aptitude, ...
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
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	echo "$cpu%"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#            VOLUME
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
volicon() {
	VOLONOFF="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $6}')"

	VOLON="ON"
	VOLOFF="OFF"

	if [ "$VOLONOFF" = "on" ]; then
	echo "$VOLON"
	else
	echo "$VOLOFF"
	fi
}
vol() {
	VOL="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $5}')"
	echo "$VOL"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#          PACKAGES
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
pkgicon() {
	echo "PKGs"
}
pkgs() {
	pkgs="$(dpkg -l | grep -c ^i)"
	echo "$pkgs"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#          UPGRADES
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
upgradeicon() {
	echo "UP"
}
upgrades(){
	upgrades="$(aptitude search '~U' | wc -l)"
	echo "$upgrades"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#           NETWORK
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
networkicon() {
	wire="$(ip a | grep "eth0\|enp" | grep inet | wc -l)"
	wifi="$(ip a | grep wlan | grep inet | wc -l)"

	if [ $wire = 1 ]; then
		echo "WIRE"
	elif [ $wifi = 1 ]; then
		echo "WIFI"
	else
		echo "OFF"
	fi
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

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#           WEATHER
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
weather=$(cat ~/.config/weather.txt | sed 25q | grep value | awk '{print $2 $3}' | sed 's/\"//g')
temp=$(cat ~/.config/weather.txt | grep temp_F | awk '{print $2}' | sed 's/\"//g' | sed 's/,//')

nocloud="NO CLOUD"
cloud="CLOUD"
lotempicon="LOTEMP"
midtempicon="MIDTEMP"
hitempicon="HITEMP"

#print weather info
TEMP() {
	echo "$temp °"
}
tempicon() {
	if [ "$temp" -gt 80 ]; then
		echo $hitempicon
	elif [ "$temp" -ge 50 ] && [ "$temp" -le 79 ]; then
		echo $midtempicon
	elif [ "$temp" -le 49]; then
		echo $lotempicon
	fi
}

weathericon() {
	if [[ "$weather" = "Clear" ]] || [[ "$weather" = "Sunny" ]]; then
		echo "$nocloud $weather"
	else
		echo "$cloud $weather"
	fi
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#           BATTERY
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
bat() {
	batstat="$(cat /sys/class/power_supply/BAT0/status)"
	battery="$(cat /sys/class/power_supply/BAT0/capacity)"
	if [ $batstat = 'Unknown' ]; then
		batstat=""
	elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
		batstat=""
	elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
		batstat=""
	elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
		batstat=""
	elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
		batstat=""
	elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
		batstat=""
	elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
		batstat=""
	fi
echo "$batstat  $battery %"
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#        DATE AND TIME
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
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
	echo "$(date "+%b %d %Y (%a)")"
}
clockinfo() {
	echo $(date "+%I:%M%p")
}

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>
#         BAR PRINT
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<
SLEEP_SEC=1
#loops forever outputting a line every SLEEP_SEC secs
while :; do
	echo -e "\
+@fg=1; $(cpuicon) +@fg=0; $(cpu) | \
+@fg=1; $(memicon) +@fg=0; $(mem) | \
+@fg=2; $(pkgicon) +@fg=0; $(pkgs) | \
+@fg=2; $(upgradeicon) +@fg=0; $(upgrades) | \
+@fg=3; $(hddicon) +@fg=0; $(hdd) | \
+@fg=4; $(networkicon) +@fg=0; $(ipaddress) +@fg=4; $(vpnconnection) | \
+@fg=5; $(volicon) +@fg=0; $(vol) | \
+@fg=6; $(weathericon) $(tempicon) $(TEMP) | \
+@fg=6; $(bat) | \
+@fg=1; $(dateinfo) +@fg=4; $(clockicon) +@fg=0; $(clockinfo) |\
"
	sleep $SLEEP_SEC
done
