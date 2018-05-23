#!/bin/bash

answer=$(echo -e "no\nyes" | dmenu -i -p "Really shutdown?" -fn 'inconsolata:pixelsize=26')
if [ "$answer" == yes ]
then
    sudo shutdown -h now
fi
