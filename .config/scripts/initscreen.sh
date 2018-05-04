#!/bin/bash

ask_screen(){
    screen=$(tail -n 1 /tmp/screens)
    echo $screen
    sed -i "/$screen/d" /tmp/screens
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
    primary=$(ask_screen)
    fehcommand="feh --bg-fill $(select_wallpaper $primary)"
fi
if [ $connected -ge 2 ]
then
    primary=$(ask_screen)
    secondary=$(ask_screen)
    position="right-of"

    execute="xrandr --output $primary --auto --primary --output $secondary --auto --$position $primary"

    fehcommand="feh --bg-fill $(select_wallpaper $primary) $(select_wallpaper $secondary)"

fi
if [ $connected -ge 3 ]
then
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
    fehcommand="feh --bg-fill $(select_wallpaper $primary) $(select_wallpaper $secondary)"
fi
if [ $connected -ge 3 ]
then
    fehcommand="feh --randomize --bg-fill $HOME/.config/wallpapers/default"
fi

$fehcommand
$HOME/.config/scripts/.polybarlaunch.sh
