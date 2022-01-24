#!/usr/bin/env bash

# customize these
WGET=/usr/bin/wget
ICS2ORG=~/scripts/ical2org
ICSFILE=~/org/sup.gcal
ORGFILE=~/org/sup.org
# URL=<private_agenda_url>

# no customization needed below

$WGET -O $ICSFILE $URL
$ICS2ORG < $ICSFILE > $ORGFILE
