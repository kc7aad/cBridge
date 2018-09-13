#!/bin/bash -x
#
export PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
# This file is used by the PNW DMR System to scrape  the RadioID.Net database. This pulls the user database,
# then only stores the users from WA, OR, ID, MT and BC (Canada). It will etrapalate them to a new file, then
# sort them according to our desired format. There is no magic here! There is also no warranty, expressed or
# implied, so feel free to use at your own risk. Also, feel free to modify at your own desire to help create
# your own scraper for your own area.
# Run this process as a cron job at any interval OTHER THAN at the top of the hour!! You will have conflict with
# the master database if you try. (experience!!)
echo "========================================================================" >> /home/kc7aad/ids.log
dt=`date '+%D %T.%6N'`
echo $dt >> /home/kc7aad/ids.log
#
wget -O /home/kc7aad/file1 "https://www.radioid.net/static/users.csv"
z1=$(ls -l /home/kc7aad/file1 | awk '{print $5}')
echo File1 is $z1"k" >> /home/kc7aad/ids.log
egrep 'Washington,United States|Oregon,United States|Idaho,United States|Montana,United States|British Columbia' /home/kc7aad/file1 > /home/kc7aad/PNW1
z2=$(ls -l /home/kc7aad/PNW1 | awk '{print $5}')
echo PNW1 is $z2"k" >> /home/kc7aad/ids.log
awk 'BEGIN {FS=OFS=","} {sub(/ .*/, "", $3)} {gsub("Washington", "WA",$5)} {gsub("Idaho", "ID",$5)} {gsub("Montana", "MT",$5)} {gsub("Oregon", "OR",$5)} {gsub("British Columbia", "BC",$5)} {print $2" - "$3" - "$4" "$5" "$1,$1}' /home/kc7aad/PNW1 > /home/kc7aad/PNW_Contact.txt
z3=$(ls -l /home/kc7aad/PNW_Contact.txt | awk '{print $5}')
echo PNW_Contact.txt is $z3"k" >> /home/kc7aad/ids.log
sed "s/'/ /g" /home/kc7aad/PNW_Contact.txt > /home/kc7aad/PNW_Contacts.txt
z4=$(ls -l /home/kc7aad/PNW_Contacts.txt | awk '{print $5}')
echo PNW_Contacts.txt is $z4"k" >> /home/kc7aad/ids.log
size=$(ls -l /home/kc7aad/PNW_Contacts.txt | awk '{print $5}')
if (( $size >= 96000 )); then echo The final file is  $size"k" >> /home/kc7aad/ids.log
 else  echo Too small - $dt - $size"k" >> /home/kc7aad/ids.log
fi
sudo cp /home/kc7aad/PNW_Contacts.txt /var/www/html/PNW_Contacts.txt
size=$(ls -l /home/kc7aad/PNW_Contacts.txt | awk '{print $5}')
if [[ $(find /home/kc7aad/PNW_Contacts.txt -type f -size +96000c 2>/dev/null) ]]; then
 echo 'Success!!' - File Size is $size"k" >> /home/kc7aad/ids.log;mail -s 'PNW DMR Contacts Update' kc7aad@gmail.com,no7
rf@trbo.org -A /home/kc7aad/PNW_Contacts.txt < /home/kc7aad/PNW_Message.txt
 else
 echo 'FAIL!!' - File Size is $size"k" >> /home/kc7aad/ids.log;mail -s '**FAILED** -- PNW DMR Contacts Update' kc7aad@gm
ail.com -A /home/kc7aad/PNW_Contacts.txt < /home/kc7aad/PNW_Message_Fail.txt
fi

#rm /home/kc7aad/file1
#rm /home/kc7aad/PNW1
#rm /home/kc7aad/PNW_Contact.txt
#rm /home/kc7aad/PNW_Contacts.txt

echo "========================================================================" >> /home/kc7aad/ids.log

