#!/bin/bash

echo $1 | grep "kgunst@github.ugent.be" > /dev/null
if [ $? -eq 0 ]; then
    pass Work/UGent | head -n1
    exit 0
fi

echo $1 | grep "klgunst@github.com" > /dev/null
if [ $? -eq 0 ]; then
    pass github | head -n1
    exit 0
fi

exit 1
