#!/bin/sh

if [ -z $1 ]
then
 echo "file not exist"
else
 file=$1

 if [ -f $file ]
 then
  while read line
  do
   if ps -p $line > /dev/null
   then
    kill -9 $line
   fi
  done < $file

  rm $file
 else
  echo "not already started"
 fi
fi
