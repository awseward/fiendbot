#!/bin/bash

ruby fiendbot.rb &
FIEND_PID=$!
ruby fakefriendbot.rb &
FAKEFRIEND_PID=$!

function finish {
    echo " *** killing fiendbot (pid: ${FIEND_PID})*** "
    kill $FIEND_PID
    echo " *** killing fakefriendbot (pid: ${FAKEFRIEND_PID}) *** "
    kill $FAKEFRIEND_PID
}

while read line; do
    if [ "$line" = "exit" -o "$line" = "quit" ]; then
        finish
        exit 0
    fi
done
