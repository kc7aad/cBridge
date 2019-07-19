#!/bin/bash
dt=`date '+%D %T'`
echo =======================================Peers======================================= >> /var/log/ids.txt
echo $dt >> /var/log/ids.txt
curl http://script.kc7aad.com/Peers.txt > /script/tmp/peers.txt
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> /scr
ipt/tmp/peers.txt
curl http://www.pnwdigital.net/Admin/Peers-IDs-PNW-Custom-Load-Last.txt >> /script/tmp/peers.txt
while read cbridge
do python /home/kc7aad/upload_ids.py -c /script/peers.txt -p -u PNWScript -d PNWskrypt $cbridge >> /var/log/ids.txt
done < /script/cbridges.txt
wc -l /script/peers.txt >> /var/log/ids.txt
echo =======================================Peers======================================= >> /var/log/ids.txt
rm /script/tmp/*.txt
