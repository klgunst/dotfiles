#!/bin/bash

tempfil="/tmp/hpcqueue"

if [ "x$1" != "x" ]; then
    bla=$(cat $tempfil)
    DISPLAY=:0 notify-send "Queue" "$bla"
fi

# set tty to to terminal where script is run. ssh will prompt then for passphrase in correct terminal.
# if script is not called from a terminal, it will point to something invalid and if passphrase is not cached
# ssh will exit with error code 255
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye &>/dev/null

outp=$(ssh hpc qstat 2> /dev/null)
if [ $? -eq 255 ]; then
    echo "Not connected"
    echo "" > tmpfil
    exit 0
fi

outpform=$(echo "$outp" | sed '/Username\|--------/d' | awk '{print $5, $4, $2}' | column -t)
echo "$outpform" > $tempfil
nmbrQ=$(echo "$outpform" | awk '{print $1}' | grep Q | wc -l)
nmbrR=$(echo "$outpform" | awk '{print $1}' | grep R | wc -l)

echo "R:$nmbrR Q:$nmbrQ"
