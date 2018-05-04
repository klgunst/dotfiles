#!/bin/bash

ask_screen(){
    screen=$(cat /tmp/screens | dmenu -i -p "$1 screen?" -fn 'inconsolata Mono:pixelsize=22')
    echo $screen
    sed -i "/$screen/d" /tmp/screens
}

ask_position(){
    echo -e "left-of\nright-of\nabove\nbelow" | dmenu -i -p "Position from primary?" -fn 'inconsolata Mono:pixelsize=22'
}

select_wallpaper(){
    WALLPAPERPATH="$HOME/Wallpapers"
    DEFAULT="default"

    # selects resolution, awk selects third word, sed removes the offset in xrandr
    res=$(cat /tmp/screeninfo | grep $1 | grep -o '[0-9]\+x[0-9]\+')
    #or no directory with that resolution is found or the directory is empty
    if [ $(ls "$WALLPAPERPATH/$res" 2> /dev/null | wc -l | sed 's/ .*//') -eq 0 ]
    then
	res=$DEFAULT
    fi

    # select a randomized wallpaper
    echo "$WALLPAPERPATH/$res/$(ls "$WALLPAPERPATH/$res" | shuf -n 1)"
}

# Find connected screens
# if wallpaper res is not found

xrandr -q | grep " connected" | sed 's/ .*//' > /tmp/screens
connected=$(wc -l /tmp/screens | sed 's/ .*//')

if [ $connected -eq 1 ]
then
    execute="xrandr --auto"
    primary=$(cat /tmp/screens)
fi
if [ $connected -ge 2 ]
then
    primary=$(ask_screen "Primary")
    secondary=$(ask_screen "Secondary")
    position=$(ask_position)

    execute="xrandr --output $primary --primary --auto --output $secondary --auto --$position $primary"

fi
if [ $connected -ge 3 ]
then
    echo "OK" | dmenu -i -p "Script not specified for more than 2 screens. Going autopilot..." -fn 'inconsolata Mono:pixelsize=22' > /dev/null
    execute="xrandr --auto"
fi

$execute

#now for the wallpapers
xrandr -q | grep " connected" > /tmp/screeninfo
if [ $connected -eq 1 ]
then
    fehcommand="feh --bg-fill $(select_wallpaper $primary)"
fi
if [ $connected -ge 2 ]
then
    echo $primary
    echo $secondary
    fehcommand="feh --bg-fill $(select_wallpaper $primary) $(select_wallpaper $secondary)"
fi
if [ $connected -ge 3 ]
then
    fehcommand="feh --randomize --bg-fill $HOME/.config/wallpapers/default"
fi

$fehcommand
$HOME/.config/polybar/launch.sh
