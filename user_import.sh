#!/bin/bash -vv
dt=`date '+%D %T'`
echo =======================================Users======================================= >> /var/log/ids.txt
echo $dt >> /var/log/ids.txt
curl http://script.kc7aad.com/US_Contacts.txt > /script/tmp/users.txt
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ >> /scr
ipt/tmp/users.txt
curl http://www.pnwdigital.net/Admin/Radio-IDs-PNW-Custom-Load-Last.txt >> /script/tmp/users.txt
while read cbridge
do python /home/kc7aad/upload_ids.py -c /script/tmp/users.txt -r -u PNWScript -d PNWskrypt $cbridge >> /var/log/ids.txt
done < /script/cbridges.txt
wc -l /script/tmp/users.txt >> /var/log/ids.txt
echo =======================================Users======================================= >> /var/log/ids.txt
rm /script/tmp/*.txt
