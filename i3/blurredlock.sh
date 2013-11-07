#!/bin/bash

IMGPATH="/tmp/blurredlock.png"

scrot $IMGPATH
convert $IMGPATH -scale 10% -scale 1000% $IMGPATH
i3lock --image=$IMGPATH
