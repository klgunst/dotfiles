#!/bin/bash

papis open
sleep 2

# the pdf will give the most recent pgrep normally
pgrep xdg-open > /tmp/test
PID=$(pgrep xdg-open | head -n 1)
echo $PID >> /tmp/test
while [ -e /proc/$PID ]
do
    sleep 1
done
exit 0
