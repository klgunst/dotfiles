#!/bin/bash

ask_screen(){
    screen=$(cat /tmp/screens | dmenu -i -p "$1 screen?" -fn 'inconsolata-LGC:size=20')
    echo $screen
    sed -i "/$screen/d" /tmp/screens
}

ask_position(){
    echo -e "left-of\nright-of\nabove\nbelow" | dmenu -i -p "Position from primary?" -fn 'inconsolata-LGC:size=20'
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
if [ $connected -eq 2 ]
then
    primary=$(ask_screen "Primary")
    secondary=$(ask_screen "Secondary")
    position=$(ask_position)

    execute="xrandr --output $primary --primary --auto --output $secondary --auto --$position $primary"

fi
if [ $connected -ge 3 ]
then
    echo "OK" | dmenu -i -p "Script not specified for more than 2 screens. Going autopilot..." -fn 'inconsolata-LGC:size=20' > /dev/null
    execute="xrandr --auto"
fi

$execute
$HOME/.config/scripts/showwallpapers.sh $connected $primary $secondary $tertiary
$HOME/.config/scripts/.polybarlaunch.sh
