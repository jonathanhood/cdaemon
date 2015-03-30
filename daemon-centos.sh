#!/bin/bash

DAEMON_NAME="test-daemon.sh"
DAEMON_RUN="$(pwd)/$DAEMON_NAME"
LOGFILE="$(pwd)/${DAEMON_NAME}.log"
PIDFILE="$(pwd)/${DAEMON_NAME}.pid"

case $1 in
    "start")
        daemon --name=$DAEMON_NAME --pidfiles=$(pwd) -- /bin/bash -c "exec $DAEMON_RUN > $LOGFILE 2>&1 < /dev/null"
        ;;
    "stop")
        daemon --stop --name=$DAEMON_NAME --pidfiles=$(pwd)
        ;;
    "status")
        daemon --running --name=$DAEMON_NAME --pidfiles=$(pwd)
        if [[ $? -eq 0 ]]; then
            echo "Running"
        else
            echo "Not Running"
        fi
        ;;
esac
            

