#!/bin/bash
 
# launch browser
if [ -z "$(pgrep $BROWSER)" ]; then
    $BROWSER &> /dev/null&
fi

st -e $HOME/.config/scripts/duckys.sh

wait %1
exit 0
