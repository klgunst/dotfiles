#!/bin/bash

cd ~/Downloads # location where to save attachments
# prompts you to ask for passphrase

# get serialno first through gpg-connect-agent 'scd serialno' /bye
# This is a bit hacky
outp=$(gpg-connect-agent 'scd checkpin D2760001240102000006065148120000' /bye)
if [ $(echo "$outp" | grep "ERR 83886179 Operation cancelled" &> /dev/null; echo $?) -eq 0 ]; then
    exit 1
fi

while [ $(echo "$outp" | grep "ERR" &> /dev/null; echo $?) -eq 0 ]; do
    if [ $(echo "$outp" | grep "Card removed" &> /dev/null; echo $?) -eq 0 ]; then
	pass Work/UGent > /dev/null
	if [ $? -eq 2 ]; then
	    exit 1
	fi
    fi
    if [ $(echo "$outp" | grep "No such device" &> /dev/null; echo $?) -eq 0 ]; then
	pass Work/UGent > /dev/null
	if [ $? -eq 2 ]; then
	    exit 1
	fi
    fi
    outp=$(gpg-connect-agent 'scd checkpin D2760001240102000006065148120000' /bye)
    if [ $(echo "$outp" | grep "ERR 83886179 Operation cancelled" &> /dev/null; echo $?) -eq 0 ]; then
	exit 1
    fi
done

offlineimap -a UGent &> /dev/null&
offlineimap -a Hotmail &> /dev/null&
offlineimap -a Caltech &> /dev/null&
neomutt

exit 0
