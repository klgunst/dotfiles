#!/bin/bash

cd ~/Downloads # location where to save attachments
# prompts you to ask for passphrase
gpg2 -dq ~/.config/offlineimap/ugent.gpg > /dev/null
offlineimap > /dev/null 2>&1&
neomutt
