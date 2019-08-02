#!/bin/bash
if [ "$(echo -e "no\nyes" | dmenu -i -p "Really shutdown?" -fn 'inconsolata:pixelsize=26')" == yes ]
then
    sudo shutdown -h now
fi
