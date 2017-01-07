#!/bin/sh

./killAll.sh "tools.pid"

./shellArduino.sh >> logs/shellArduino.log &
echo $! >> tools.pid

node serverNode.js >> logs/serverNode.log &
echo $! >> tools.pid
