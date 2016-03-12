#!/bin/bash

set -o xtrace

if [ "$1" == "mount" ]
then
  sshfs ward@aspire-laptop.local:/mnt/maxtor-300gb/books /mnt/aspire-laptop-books
fi

if [ "$1" == "unmount" ]
then
  fusermount -u /mnt/aspire-laptop-books
fi
