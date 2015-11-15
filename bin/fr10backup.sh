#!/bin/bash

cd /media/ward/GARMIN/GARMIN/ACTIVITY
# Shows how full/empty this filesystem is getting
# -h human readable
df -h .

# Backs up any new files to the Dropbox folder
# -v, --verbose               increase verbosity
# -u, --update                skip files that are newer on the receiver
# -t, --times                 preserve modification times
# -h, --human-readable        output numbers in a human-readable format
#     --progress              show progress during transfer
rsync -h -v -t --progress -u * ~/Dropbox/run/forerunner10
