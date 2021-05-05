#!/bin/bash

service nginx restart

cd /root/webapps/boodskap-ui

node boodskap-platform-node.js
