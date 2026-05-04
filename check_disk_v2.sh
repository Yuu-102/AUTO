#!/bin/bash

LOD_FILE="/home/ftp20/my_scripst/check.log"
echo "腳本已於$(date)執行" >> "$LOG_FILE"

THRESHOLD=70

USAGE=$(df / | tail -1 | awk '{print $5}' | tr -d '%')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
   echo "磁碟用量$(USAGE)，超過$(THRESHOLD)警戒線!" >> "$LOG_FILE"
else
   echo "正常$(USAGE)" >> "$LOG_FILE"	
fi
