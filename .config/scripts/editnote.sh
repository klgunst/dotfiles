#!/bin/bash

NOTE="$HOME/.note.txt"
add_note(){
    wallpaper=$1
    ptsize=30
    message=$(sed '/^[ ]*%/d' $NOTE)
    convert -size 800x400 xc:none -gravity NorthWest \
	-stroke black -strokewidth 2 -pointsize $ptsize -annotate 0 "$message" \
	-background none -shadow 100x1+0+0 +repage \
	-stroke none -fill white -pointsize $ptsize -annotate 0 "$message" \
	$wallpaper +swap -gravity NorthWest -geometry +50+50 -composite $2 
}

st vim $NOTE
add_note /tmp/oldprimary.jpg /tmp/primary.jpg
feh --bg-fill /tmp/primary.jpg /tmp/secondary.jpg /tmp/tertiary.jpg 2> /dev/null
