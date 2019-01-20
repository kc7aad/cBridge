#!/bin/bash -vv
dt=`date '+%D %T'`
echo =======================================Users======================================= >> /var/log/ids.txt
echo $dt >> /var/log/ids.txt
wget -O /script/PNW_Contacts.txt http://script.kc7aad.com/PNW_Contacts.txt
while read cbridge
do python /home/kc7aad/upload_ids.py -c /script/PNW_Contacts.txt -r -u <USERNAME> -d <PASSWORD> $cbridge >> /var/log/ids.txt
done < /script/cbridges.txt
wc -l /script/PNW_Contacts.txt >> /var/log/ids.txt
echo =======================================Users======================================= >> /var/log/ids.txt
rm /script/PNW_Contacts.txt
