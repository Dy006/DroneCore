#!/bin/bash

stty -F /dev/ttyUSB0 cs8 9600 ignbrk -brkint -icrnl -imaxbel -opost -onlcr -isig -icanon -iexten -echo -echoe -echok -echoctl -echoke noflsh -ixon -crtscts

#tail -f /dev/ttyACM0

cat /dev/ttyUSB0 > output.txt &
echo $! >> tools.pid

while true
do
 #echo -n $(tail -2 output.txt | head -1) > /dev/tcp/192.168.95.27/5005
#cat /dev/ttyUSB0|head -n 2|tail -n 1
 echo -n $(tail -2 output.txt | head -1) > lastProperties.txt

 sleep 0.3
done
