#!/usr/bin/env bash

qtile_current="$HOME/.config/qtile/theme.py"

tail -n1 $qtile_current | sed 's/# current: \(.*\).conf/\1/'
