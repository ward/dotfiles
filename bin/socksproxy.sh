#!/bin/sh

SSH_SERVER=home
#SSH_SERVER=vps
PORT=8123

ssh -D $PORT -f -C -q -N $SSH_SERVER

echo "Connected to $SSH_SERVER."
echo "Set up SOCKS v5 proxy to point at localhost:$PORT."
