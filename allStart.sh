#!/bin/bash

./autoConnectWifi.sh > logs/autoConnectWifi.sh &
echo $! >> tools.pid