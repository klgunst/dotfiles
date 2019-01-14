#!/bin/bash
shot="/tmp/screen.png"
lock="$HOME/.config/scripts/lock.png"
scrot -z $shot
convert $shot -scale 25% -blur 0x2 -scale 400% $shot
WIDTHOFF=$(( $(feh -l $shot | tail -n 1 | awk '{printf $3;}') / 2 ))
HEIGHTOFF=$(( $(feh -l $shot | tail -n 1 | awk '{printf $4;}') / 2 ))

screeninfo=$(xrandr -q | grep -w connected)
connected=$(echo "$screeninfo" | wc -l)
echo $connected
if [[ -f $lock ]]
then
    for (( i=1 ; i<=$connected; i++ ))
    do
	# select i'th line
	line=$(echo "$screeninfo" | sed "${i}q;d")
	info=$(echo $line | sed -n 's/.* \([0-9]*\)x\([0-9]*\)+\([0-9]*\)+\([0-9]\).*/\1 \2 \3 \4/p')
	[ "x$info" = "x" ] && continue
	# info not found
	wscreen=$(echo $info | awk '{print $1}')
	hscreen=$(echo $info | awk '{print $2}')
	woff=$(echo $info | awk '{print $3}')
	hoff=$(echo $info | awk '{print $4}')
	woff=$(( $WIDTHOFF - $woff - $wscreen / 2 ))
	hoff=$(( $HEIGHTOFF - $hoff - $hscreen / 2 ))
	convert $shot $lock  -geometry -$woff-$hoff -gravity center -composite -matte $shot
    done
fi

# Get Playing music
playingid=$($HOME/.config/scripts/music_dbus.py isplaying)
#Pause music
$HOME/.config/scripts/music_dbus.py Pause

# muting all the rest
$HOME/.config/scripts/volumecontrol.sh mute
i3lock -n -u -e -i /tmp/screen.png

# unmuting all the rest
$HOME/.config/scripts/volumecontrol.sh mute
# play spotify
if [ -n "$playingid" ]; then
    $HOME/.config/scripts/music_dbus.py Play $playingid
fi
