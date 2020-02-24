#!/bin/sh

# See https://source.unsplash.com/ for more information about this simple API

width=1680
height=1050
filename=unsplash

url="https://source.unsplash.com/random/${width}x${height}"

wget -nv -O "${filename}.jpg" -o "${filename}.log" $url
