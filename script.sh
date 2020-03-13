#!/bin/bash

if [ -n "$1" ]
then
  PATH_DIR="$1"
else
  PATH_DIR="./"
fi

if [ -n "$2" ]
then
  QUALITY=$2
else
  QUALITY=75
fi

echo "PATH_DIR = $PATH_DIR"
echo "QUALITY = $QUALITY"

COUNTER=0

IFS=$'\n'

for filename in `find $PATH_DIR -type f -regex ".*\.\(jpg\\|jpeg\)$" ` 
do	
   MIME_TYPE=`file -b --mime-type "$filename"`;
   
   if [ $MIME_TYPE = "image/jpeg" ]
   then
       ((COUNTER+=1))
       echo $MIME_TYPE;
       echo $filename;

       #указываем имя временного файла
       uuid=$(uuidgen)
       TMP="/tmp/${uuid}";

       #выполняем оптимизацию
       /opt/mozjpeg/bin/cjpeg -outfile $TMP -progressive -optimize -quality $QUALITY "$filename"
       mv $TMP "$filename"

       echo "good"
   fi       
done

echo "COUNT: $COUNTER"
