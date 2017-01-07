#!/bin/bash
 
/usr/local/bin/gpio mode 0 in
/usr/local/bin/gpio mode 4 out

isPressed=false
timeStart=0

#cd /root/DGIPyDrOnePY/new/

./flashLed.sh 1 >> logs/flashLed.log &
./autoWifi.sh >> logs/autoWifi.log

while true; do
 value=$(/usr/local/bin/gpio read 0)

 if [ $value = 1 ]
 then
  if [ $isPressed = false ]
  then
   #echo "pressed"
   isPressed=true
   timeStart=$(cat /proc/uptime | cut -d'.' -f1)
   ./flashLed.sh 0.2 >> logs/flashLed.log &
  fi

  gapTime=$(($(cat /proc/uptime | cut -d'.' -f1)-timeStart))
  #echo $gapTime

  if [ $gapTime -lt 5 ]
  then
   /usr/local/bin/gpio write 4 1
  elif [ $gapTime -ge 10 -a $gapTime -lt 15 ]
  then
   /usr/local/bin/gpio write 4 1
  else
   /usr/local/bin/gpio write 4 0
  fi
 fi

 if [ $value = 0 ]
 then
  if [ $isPressed = true ]
  then
   #echo "do something"
   #gapTime=$(($(cat /proc/uptime | cut -d'.' -f1)-timeStart))
   #echo $gapTime

   if [ $gapTime -lt 5 ]
   then
    echo "reboot scripts"
    ./startTools.sh
   elif [ $gapTime -lt 10 ]
   then
    echo "reboot drone"
    ./killTools.sh >> logs/killTools.log
    reboot
   elif [ $gapTime -lt 15 ]
   then
    echo "reboot network"
    ./autoWifi.sh >> logs/autoWifi.log
   else
    echo "halt drone"
    ./killTools.sh >> logs/killTools.log
    halt
   fi

   /usr/local/bin/gpio write 4 0 
   ./flashLed.sh 1 >> logs/flashLed.log &
  fi

  #echo "not pressed"
  isPressed=false
 fi
done
