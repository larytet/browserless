#!/bin/bash
set -e


# In case the container is restarted 
[ -f /tmp/.X99-lock ] && rm /tmp/.X99-lock


_kill_procs() {
  kill -TERM $node
  kill -TERM $xvfb
}

# Relay quit commands to processes
trap _kill_procs SIGTERM SIGINT

export DISPLAY=:0
Xvfb  $DISPLAY -screen 0 1024x768x16 -nolisten tcp -nolisten unix &
xvfb=$!

# https://linux.die.net/man/1/x11vnc
x11vnc -nopw -display $DISPLAY -N -forever &
x11vnc=$!

export NODE_PATH=$HOME/node_modules:$NODE_PATH
export PATH=$HOME/node_modules/bin:$PATH
echo NODE_PATH=$NODE_PATH

dumb-init -- node --inspect /tmp/app.js $@ &
node=$!

wait $node
wait $xvfb
wait $x11vnc