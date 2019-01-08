#!/bin/bash

# script needs fzf and ddgr and a browser ofc
# $BROWSER should be specified
# Ctrl-a for accepting suggestion of fzf
# Ctrl-d for deleting suggestion of fzf 
# (and if the suggestion is to clear the history it will do that instead)
# Enter to accept your own input
# ctrl-C or escape to abort
# removing of bangs doesnt work yet

histo_file=$HOME/.ducky_history
acceptkey='ctrl-a'
deletekey='ctrl-d'
clearstring="ddgr:Clear history"

#initializing history entry
if [ ! -f $histo_file ] || [ "$(cat $histo_file | wc -l)" -eq 0 ]; then
    echo $clearstring > $histo_file
fi

query=$(cat $histo_file | fzf --exact --tac --reverse --no-sort --bind \
    "Enter:print-query,$acceptkey:accept,$deletekey:execute[sed -i '/^{}$/d' $histo_file]") 
exitstatus=$?

#huh this fixes problems
query=$(echo $query)
if [ -z "$query" ]; then
    exit 0
elif [ "$query" == "$clearstring" ]; then
    rm $histo_file
    exit 0
elif [ $exitstatus -eq 130 ]; then
    exit 0
elif [ $exitstatus -eq 2 ]; then
    exit 1
fi

# query is new
if [ -z "$(grep "^$query$" $histo_file)" ]; then
    echo $query >> $histo_file
fi

# What do with input?
if [ "${query::1}" == "!" ]; then
    ddgr --np $query
elif [ "${query::4}" == "www." ]; then
    if [ -z "$(pgrep firefox)" ]; then
	nohup $BROWSER &> /dev/null&
	sleep 6
    fi
    $BROWSER $query
else
    ddgr --gb $query
fi
