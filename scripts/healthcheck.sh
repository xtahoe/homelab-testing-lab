#!/bin/bash

LOGFILE="/mnt/user/scripts/healthcheck.log"

SERVER_IP="192.168.1.91"

DATE=$(date)

echo "=========================" >> $LOGFILE
echo "Health Check - $DATE" >> $LOGFILE

# SERVER PING TEST
ping -c 1 $SERVER_IP > /dev/null

if [ $? -eq 0 ]; then
    echo "Server ONLINE" >> $LOGFILE
else
    echo "Server OFFLINE" >> $LOGFILE
fi

# PLEX TEST
PLEX_STATUS=$(curl -o /dev/null -s -w "%{http_code}" http://$SERVER_IP:32400/web)

if [ "$PLEX_STATUS" == "200" ] || [ "$PLEX_STATUS" == "301" ] || [ "$PLEX_STATUS" == "302" ]; then
    echo "Plex ONLINE (HTTP $PLEX_STATUS)" >> $LOGFILE
else
    echo "Plex ERROR (HTTP $PLEX_STATUS)" >> $LOGFILE
fi

echo "" >> $LOGFILE
