#!/bin/sh

/usr/local/bin/gpio write 1 0

echo "killing flash led"

./killAll.sh "led.pid"
