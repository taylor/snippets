#!/bin/sh

if [ $# -lt 2 ] ; then
  echo "usage: $0 <file to watch> <cmd to run w/options>"
fi

thefile="$1"
shift

while inotifywait -e MOVE_SELF "$thefile" ; do echo "[Running]" ; $@ $thefile ; done
