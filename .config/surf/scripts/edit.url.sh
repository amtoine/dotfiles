#!/bin/sh

dir=~/.config/surf/tmpedit
name=`ls $dir | wc -l`
file=$dir/$name.html
sselp > $file && kitty vim $file
