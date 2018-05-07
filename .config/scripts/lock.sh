#!/bin/bash
shot="/tmp/screen.png"
lock="$HOME/.config/scripts/.lock.png"
scrot -z $shot
#convert /tmp/screen.png -paint 1 /tmp/screen.png
convert $shot -blur 0x3 $shot
WIDTHOFF=$(( $(feh -l $shot | tail -n 1 | awk '{printf $3;}') / 2 ))
HEIGHTOFF=$(( $(feh -l $shot | tail -n 1 | awk '{printf $4;}') / 2 ))

xrandr -q | grep " connected" > /tmp/screeninfo
connected=$(cat /tmp/screeninfo | wc -l)
if [[ -f $lock ]]
then
    for (( i=1 ; i<=$connected; i++ ))
    do
	# select i'th line
	line=$(sed "${i}q;d" /tmp/screeninfo)
	woff=$(echo $line | grep -o '+[0-9]\++[0-9]\+' | sed -r 's/([^0-9]*([0-9]*)){1}.*/\2/')
	hoff=$(echo $line | grep -o '+[0-9]\++[0-9]\+' | sed -r 's/([^0-9]*([0-9]*)){2}.*/\2/')
	wscreen=$(echo $line | grep -o '[0-9]\+x[0-9]\+' | sed -r 's/([^0-9]*([0-9]*)){1}.*/\2/')
	hscreen=$(echo $line | grep -o '[0-9]\+x[0-9]\+' | sed -r 's/([^0-9]*([0-9]*)){2}.*/\2/')
	woff=$(( $WIDTHOFF - $woff - $wscreen / 2 ))
	hoff=$(( $HEIGHTOFF - $hoff - $hscreen / 2 ))
	convert $shot $lock  -geometry -$woff-$hoff -gravity center -composite -matte $shot
    done
fi

# pause spotify
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 \
    org.mpris.MediaPlayer2.Player.Pause

# muting all the rest
amixer sset Master toggle
i3lock -n -u -e -i /tmp/screen.png

# unmuting all the rest
amixer sset Master toggle
# play spotify
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 \
    org.mpris.MediaPlayer2.Player.Play
