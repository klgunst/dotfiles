#!/bin/bash

select_wallpaper(){
    # selects resolution, awk selects third word, sed removes the offset in xrandr
    res=$(cat /tmp/screeninfo | grep $1 | grep -o '[0-9]\+x[0-9]\+')
    #or no directory with that resolution is found or the directory is empty
    if [ $(ls "$WALLPAPERPATH/$res" 2> /dev/null | wc -l | sed 's/ .*//') -eq 0 ]
    then
	res=$DEFAULT
    fi

    # select a randomized wallpaper and resize it to the correct resolution
    convert $(find -L $WALLPAPERPATH/$res -type f | shuf -n 1) -gravity center -resize $res^ -crop $res+0+0 +repage $2
    echo $2
}

add_note(){
    wallpaper=$1
    ptsize=30
    message=$(cat $NOTE)
    convert -size 800x400 xc:none -gravity NorthWest \
	-stroke black -strokewidth 2 -pointsize $ptsize -annotate 0 "$message" \
	-background none -shadow 100x1+0+0 +repage \
	-stroke none -fill white -pointsize $ptsize -annotate 0 "$message" \
	$wallpaper +swap -gravity NorthWest -geometry +50+50 -composite $2 
}

WALLPAPERPATH="$HOME/Wallpapers"
DEFAULT="default"
NOTE="$HOME/.note.txt"
connected=$1

#now for the wallpapers
xrandr -q | grep " connected" > /tmp/screeninfo
if [ $connected -eq 1 ]
then
    select_wallpaper $2 /tmp/oldprimary.jpg
    add_note /tmp/oldprimary.jpg /tmp/primary.jpg
    fehcommand="feh --bg-fill /tmp/primary.jpg"
fi
if [ $connected -eq 2 ]
then
    select_wallpaper $2 /tmp/oldprimary.jpg
    add_note /tmp/oldprimary.jpg /tmp/primary.jpg
    fehcommand="feh --bg-fill /tmp/primary.jpg $(select_wallpaper $3 /tmp/secondary.jpg)"
fi
if [ $connected -ge 3 ]
then
    select_wallpaper $2 /tmp/oldprimary.jpg
    add_note /tmp/oldprimary.jpg /tmp/primary.jpg
    fehcommand="feh --bg-fill /tmp/primary.jpg $(select_wallpaper $3 /tmp/secondary.jpg) $(select_wallpaper $4 /tmp/tertiary.jpg)"
fi
$fehcommand
