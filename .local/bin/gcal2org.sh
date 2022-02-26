#!/usr/bin/env bash

# customize these
WGET=/usr/bin/wget
ICS2ORG=~/scripts/ical2org
ICSFILE=~/org/sup.gcal
ORGFILE=~/org/sup.org
URL="$(cat ~/scripts/.gcal2org.url)"

# no customization needed below

$WGET -O $ICSFILE $URL
$ICS2ORG < $ICSFILE > $ORGFILE
