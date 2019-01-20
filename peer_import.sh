#!/bin/bash
dt=`date '+%D %T'`
echo =======================================Peers======================================= >> /var/log/ids.txt
echo $dt >> /var/log/ids.txt
wget -O /script/cBridge_peers.txt http://script.kc7aad.com/cBridge_peers.txt
while read cbridge
do python /home/kc7aad/upload_ids.py -c /script/cBridge_peers.txt -p -u <USERNAME> -d <PASSWORD> $cbridge >> /var/log/ids.txt
done < /script/cbridges.txt
wc -l /script/cBridge_peers.txt >> /var/log/ids.txt
echo =======================================Peers======================================= >> /var/log/ids.txt
rm /script/cBridge_peers.txt
