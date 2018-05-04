#!/bin/bash

answer=$(echo -e "no\nyes" | dmenu -i -p "Really shutdown?" -fn 'inconsolata Mono:pixelsize=22')
if [ "$answer" == yes ]
then
    sudo shutdown -h now
fi
