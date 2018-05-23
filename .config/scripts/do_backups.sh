#!/bin/bash

answer=$(echo -e "Backup\nSync\nCancel" | dmenu -i -p "What do you want to do?" -fn 'inconsolata:pixelsize=26')
if [ "$answer" == Cancel ]
then
    exit
fi
answer2=$(echo -e "No\nYes" | dmenu -i -p "Are you sure?" -fn 'inconsolata:pixelsize=26')
if [ "$answer2" == No ]
then
    exit
fi
if [ "$answer" == Backup ]
then
    /usr/local/bin/st -g 60x10+1400+40 ~/.config/scripts/.backups.sh
fi
if [ "$answer" == Sync ]
then
    /usr/local/bin/st -g 60x10+1400+40 ~/.config/scripts/.sync.sh
fi
