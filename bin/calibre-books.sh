#!/bin/bash

HOST=pi
REMOTESRC=/mnt/seagate-1tb/books/en
LOCALSRC=/mnt/pi-books

if [ "$1" == "mount" ]
then
  (set -x; sshfs $HOST:$REMOTESRC $LOCALSRC)
fi

if [ "$1" == "unmount" ]
then
  (set -x; fusermount -u $LOCALSRC)
fi
