#!/bin/bash
IMAGE=/tmp/screen.png
TEXT=/tmp/locktext.png

grim -o $(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') $IMAGE

convert $IMAGE -scale 25% -blur 0x2 -scale 400% -fill black -colorize 50% $IMAGE
[[ -f $1 ]] && convert $IMAGE $1 -gravity center -composite -matte $IMAGE

[ -f $TEXT ] || {
    convert -size 2560x60 xc:black -font Roboto -pointsize 26 -fill white -gravity center -annotate +0+0 'Type password to unlock' $TEXT;
}

convert $IMAGE $TEXT -gravity center -geometry +0+200 -composite $IMAGE
swaylock -f -F -s fill -i $IMAGE
