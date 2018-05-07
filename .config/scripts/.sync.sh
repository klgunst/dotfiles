#!/bin/bash

# This is needed so that the gpg-agent calls pinentry in the current terminal
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye &>/dev/null
# open tunnel
ssh -f molgate -N

#sync
rsync --progress -avz moldyn58:archive/backup.0/kgunst /home

# close tunnel
kill $(ps aux | grep "[s]sh -f molgate -N" | awk '{print $2}')

# time of sync
date +"%d %b @ %R" > $HOME/.lastbackup
