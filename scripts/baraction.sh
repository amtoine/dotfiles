#!/bin/bash
# baraction.sh script for spectrwm status bar

SLEEP_SEC=5  # set bar_delay = 5 in /etc/spectrwm.conf
#loops forever outputting a line every SLEEP_SEC secs
while :; do
	echo -e "    $(date +"%H:%M:%S")      $(acpi)"
        sleep $SLEEP_SEC
done   

