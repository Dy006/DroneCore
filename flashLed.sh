#!/bin/sh

if [ -z $1 ]
then
 echo "not timeSleep"
 exit
fi

echo "starting led script"

./killAll.sh "led.pid"

echo $$ >> led.pid

echo "kill all led process"

/usr/local/bin/gpio mode 1 out

echo "sleepTime : $1"

while true
do
 /usr/local/bin/gpio write 1 1
 sleep $1
 /usr/local/bin/gpio write 1 0
 sleep $1
done
