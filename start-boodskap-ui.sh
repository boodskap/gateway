#!/bin/bash

service nginx restart

cd /root/webapps/boodskap-ui

if [ -f "/root/node_modules/forever/bin/forever" ]; then
    /root/node_modules/forever/bin/forever --minUptime 1000 --spinSleepTime 1000 start boodskap-platform-node.js
else
    pm2 start boodskap-platform-node.js
fi

/bin/bash -c "trap : TERM INT; sleep infinity & wait"
