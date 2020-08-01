
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

echo NODE_PATH=$NODE_PATH
dumb-init -- node --inspect ./build/index.js $@ &
node=$!

wait $node
wait $xvfb
