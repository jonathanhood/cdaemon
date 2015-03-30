#!/bin/bash

DAEMON_NAME="test-daemon.sh"
DAEMON_RUN="./$DAEMON_NAME"
PIDFILE="out.pid"
PID=""


if [[ -e $PIDFILE ]]; then
    TEMP_PID=$(cat $PIDFILE)
    MATCHING_PROCESSES=$(pgrep $DAEMON_NAME)
    if [[ $MATCHING_PROCESSES =~ $TEMP_PID ]]; then
        PID=$TEMP_PID
    fi
fi

case $1 in
    "start")
        if [[ -z $PID ]]; then
            setsid $DAEMON_RUN > "out.log" 2>&1 < /dev/null & 
            echo $! > "out.pid"
            echo "Started"
        else
            echo "Already Running"
        fi
        ;;
    "stop")
        if [[ -n $PID ]]; then
            kill $PID
            echo "Stopped"
        else
            echo "Not Running"
        fi
        ;;
esac
            

