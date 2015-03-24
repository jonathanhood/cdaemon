#!/bin/bash`

( 
    setsid echo "Hello World" > "out.log" 2>&1 < /dev/null & 
    echo $! > "out.pid"
)

