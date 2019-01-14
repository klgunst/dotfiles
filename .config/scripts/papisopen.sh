#!/bin/bash

papis open '*'
sleep 10

# the pdf will give the most recent pgrep normally
pgrep xdg-open > /tmp/test
PID=$(pgrep xdg-open | head -n 1)
echo $PID >> /tmp/test
wait $PID
exit 0
