#!/bin/bash

cd ~/Downloads # location where to save attachments
# prompts you to ask for passphrase
pass BigGuys/Windows > /dev/null
offlineimap -a UGent &> /dev/null&
offlineimap -a Hotmail &> /dev/null&
offlineimap -a Caltech &> /dev/null&
neomutt
