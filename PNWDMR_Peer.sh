#!/bin/bash
export PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
# This file is used by the PNW DMR System to scrape  the RadioID.Net database. It will etrapalate them to a new file, then
# sort them according to our desired format. There is no magic here! There is also no warranty, expressed or
# implied, so feel free to use at your own risk. Also, feel free to modify at your own desire to help create
# your own scraper for your own systems.
#
echo "==============================PNW-IDs==================================" >> /home/kc7aad/ids.log
dt=`date '+%D %T.%6N'`
echo $dt >> /home/kc7aad/ids.log
#
curl -o rpt.txt "https://www.radioid.net/api/dmr/repeater/?country=United%20States&format=csv"
sed -i '1d' rpt.txt
sed -i -e 's/\"//g' rpt.txt
z1=$(ls -l /home/kc7aad/rpt.txt | awk '{print $5}')
echo The download is $z1"k" >> /home/kc7aad/ids.log
awk 'BEGIN {FS=OFS=","} {sub(/ .*/, "", $9)} {gsub("United States", "USA")} {gsub("/","-")} {gsub("<br>","_")} {gsub("Alabama","AL",$9)} {gsub("Alaska","AK",$9)} {gsub("Arizona","AZ",$9)} {gsub("Arkansas","AR",$9)}{gsub("California","CA",$9)} {gsub("Colorado","CO",$9)} {gsub("Connecticut","CT",$9)} {gsub("Delaware","DE",$9)} {gsub("District of Columbia","DC",$9)} {gsub("Florida","FL",$9)} {gsub("Georgia","GA",$9)} {gsub("Hawaii","HI",$9)} {gsub("Idaho","ID",$9)} {gsub("Illinois","IL",$9)} {gsub("Indiana","IN",$9)} {gsub("Iowa","IA",$9)} {gsub("Kansas","KS",$9)} {gsub("Kentucky","KY",$9)} {gsub("Louisiana","LA",$9)} {gsub("Maine","ME",$9)} {gsub("Maryland","MD",$9)} {gsub("Massachusetts","MA",$9)} {gsub("Michigan","MI",$9)} {gsub("Minnesota","MN",$9)} {gsub("Mississippi","MS",$9)} {gsub("Missouri","MO",$9)} {gsub("Montana","MT",$9)} {gsub("Nebraska","NE",$9)} {gsub("Nevada","NV",$9)} {gsub("New Hampshire","NH",$9)} {gsub("New Jersey","NJ",$9)} {gsub("New Mexico","NM",$9)} {gsub("New York","NY",$9)} {gsub("North Carolina","NC",$9)} {gsub("North Dakota","ND",$9)} {gsub("Ohio","OH",$9)} {gsub("Oklahoma","OK",$9)} {gsub("Oregon","OR",$9)} {gsub("Pennsylvania","PA",$9)} {gsub("Rhode Island","RI",$9)} {gsub("South Carolina","SC",$9)} {gsub("South Dakota","SD",$9)} {gsub("Tennessee","TN",$9)} {gsub("Texas","TX",$9)} {gsub("Utah","UT",$9)} {gsub("Vermont","VT",$9)} {gsub("Virginia","VA",$9)} {gsub("Washington","WA",$9)} {gsub("West Virginia","WV",$9)} {gsub("Wisconsin","WI",$9)} {gsub("Wyoming","WY",$9)}{print $2" "$9" "$4" - "$1" "$6,
$6}' /home/kc7aad/rpt.txt > /home/kc7aad/rpt2.txt
z3=$(ls -l /home/kc7aad/rpt2.txt | awk '{print $5}')
echo The parsed and formatted data is $z3"k" >> /home/kc7aad/ids.log
sed "s/'/ /g" /home/kc7aad/rpt2.txt > /home/kc7aad/peers.txt
size=$(ls -l /home/kc7aad/peers.txt | awk '{print $5}')
if (( $size >= 100000 )); then sudo cp /home/kc7aad/peers.txt /var/www/html/peers.txt
 else  echo Too small - $size"k" >> /home/kc7aad/ids.log
fi
size=$(ls -l /home/kc7aad/peers.txt | awk '{print $5}')
if [[ $(find /home/kc7aad/peers.txt -type f -size +120000c 2>/dev/null) ]]; then
 echo 'Success!!' >> /home/kc7aad/ids.log #mail -s "PNW DMR Peers Update - $size k" kc7aad@gmail.com,no7rf@trbo.org -A /home/kc7aad/PNW_Contacts.txt < /home/kc7aad/PNW_Message.txt
 else
 echo 'FAIL!!' >> /home/kc7aad/ids.log #mail -s "**FAILED** -- PNW DMR Peers Update - $size k" kc7aad@gmail.com -A /home/kc7aad/PNW_Contacts.txt < /home/kc7aad/PNW_Message_Fail.txt
fi
echo "==============================PNW-IDs==================================" >> /home/kc7aad/ids.log


rm /home/kc7aad/rpt.txt
rm /home/kc7aad/rpt2.txt
#rm /home/kc7aad/peers.txt
