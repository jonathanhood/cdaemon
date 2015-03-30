#!/bin/bash

DAEMON_NAME="test-daemon.sh"
DAEMON_RUN="$(pwd)/$DAEMON_NAME"
LOGFILE="$(pwd)/${DAEMON_NAME}.log"
PIDFILE="$(pwd)/${DAEMON_NAME}.pid"

case $1 in
    "start")
        start-stop-daemon --background --start --startas /bin/bash --pidfile $PIDFILE --make-pidfile -- -c "exec $DAEMON_RUN > $LOGFILE 2>&1 < /dev/null"
        ;;
    "stop")
        start-stop-daemon --stop --pidfile $PIDFILE
        ;;
    "status")
        start-stop-daemon --status --pidfile $PIDFILE
        if [[ $? -eq 0 ]]; then
            echo "Running"
        else
            echo "Not Running"
        fi
        ;;
esac
            

