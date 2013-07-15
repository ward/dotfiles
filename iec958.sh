#!/bin/bash

# Fixes sound not automatically being shared to my TV
# TV is connected through hdmi cable.
# Sounds always had to be "turned on" through the xfce panel applet.
# Now just add to startup scripts, with option 1 or empty option.

if [ -z "$1" ] || [ "$1" == "1" ]
then
	amixer -c 0 sset 'IEC958',0 'Playback' 'on'
elif [ "$1" == "0" ]
then
	amixer -c 0 sset 'IEC958',0 'Playback' 'off'
else
	echo "No such option, usage: $0 [10]"
fi
