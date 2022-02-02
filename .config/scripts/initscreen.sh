#!/bin/bash

ask_screen(){
    screen=$(tail -n 1 /tmp/screens)
    echo "$screen"
    sed -i "/$screen/d" /tmp/screens
}

# Find connected screens
# if wallpaper res is not found

xrandr -q | grep " connected" | sed 's/ .*//' > /tmp/screens
connected=$(wc -l /tmp/screens | sed 's/ .*//')
if [ "$connected" -eq 1 ]; then
    execute="xrandr --auto"
    primary=$(ask_screen)
elif [ "$connected" -eq 2 ]; then
    primary=$(ask_screen)
    secondary=$(ask_screen)
    position="left-of"

    execute="xrandr --output $primary --auto --primary --output $secondary --auto --$position $primary"
elif [ "$connected" -ge 3 ]; then
    primary=$(ask_screen)
    secondary=$(ask_screen)
    tertiary=$(ask_screen)
    execute="xrandr --output $primary --primary --auto --output $secondary --auto --right-of $primary --output $tertiary --auto --right-of $secondary"
fi

eval "$execute"
"$HOME/.config/scripts/showwallpapers.sh" "$connected" "$primary" "$secondary" "$tertiary"
"$HOME/.config/scripts/.polybarlaunch.sh"
