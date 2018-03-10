#!/bin/bash

set -o xtrace

HOST=pi
REMOTESRC=/mnt/seagate-1tb/books/en
LOCALSRC=/mnt/pi-books

if [ "$1" == "mount" ]
then
  sshfs $HOST:$REMOTESRC $LOCALSRC
fi

if [ "$1" == "unmount" ]
then
  fusermount -u $LOCALSRC
fi
