daemon-examples
===============

Several small implementations of a unix daemon in various languages. They 
each follow the process of:

1. Forking to create a subprocess
2. Calling setsid to accomplish various items
   1. Create a new session
   2. Become leader of the new process group
   3. Remove any controlling tty
3. Forking again to avoid acquiring a tty again
4. Redirecting stdout, stderr to a log file
5. Setting stdin to /dev/null
6. Writing a pidfile
7. Closing all open non-std file descriptors (if necessary)
8. Running some "useful" code

Missing Pieces
==============

1. None of the implementations here cd to /, which is recommened to avoid
   daemon execution inside a mounted volume.
2. Setting umask appropriately
3. Changing to an appropriate user for the daemon to run as

