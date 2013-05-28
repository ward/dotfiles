#!/bin/sh

# Despite turning off all power saving and screensaver settings,
# the screen still goes to black after X minutes of idling.
# The following series of commands seems to fix this.

xset -dpms
xset s noblank
xset s off

# Another suggestion from the internet was this one
# xset s noblank
# xset s off
# xset s noexpose
# xset s 0 0
