#!/bin/bash

if [ "x$2" == "x" ]
then
    sink=$(pactl list short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1)
else
    sink=$2
fi

if [ "x$sink" == "x" ]
then
    exit 0
fi

if [ $1 == "mute" ]
then
    echo $sink
    pactl set-sink-mute $sink toggle
else
    pactl set-sink-volume $sink $1
fi
echo $sink
