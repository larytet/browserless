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

Xvfb :99 -screen 0 1024x768x16 -nolisten tcp -nolisten unix &
xvfb=$!
export DISPLAY=:99

# Based on https://topaxi.codes/use-npm-without-root-or-sudo-rights/
export NODE_PATH="$HOME/node_modules/lib:$NODE_PATH"
echo NODE_PATH=$NODE_PATH
ls -al $HOME/node_modules

dumb-init -- node --inspect ./src/app.js $@ &
node=$!

wait $node
wait $xvfb
