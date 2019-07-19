#!/bin/bash
export PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
# This file is used by the PNW DMR System to scrape  the RadioID.Net database. This pulls the user database,
# then stores the users the US. It will etrapalate them to a new file, then
# sort them according to our desired format. There is no magic here! There is also no warranty, expressed or
# implied, so feel free to use at your own risk. Also, feel free to modify at your own desire to help create
# your own scraper for your own area.
#
#
curl -o /script/tmp/peers.txt "https://www.radioid.net/api/dmr/repeater/?country=United%20States&country=Canada"
jq -r '(.results[] | [.callsign, .city, .color_code, ."country", ."frequency", .id, .ipsc_network, .offset, .state, .tru
stee, .ts_linked]) | @csv' /script/tmp/peers.txt > /script/tmp/peers1.txt
sed 's/"//g' /script/tmp/peers1.txt > /script/tmp/peers2.txt
awk 'BEGIN {FS=OFS=","} {sub(/ .*/, "", $4)} {gsub("British Columbia","BC",$9)} {gsub("Alabama","AL",$9)} {gsub("Alaska"
,"AK",$9)} {gsub("Arizona","AZ",$9)} {gsub("Arkansas","AR",$9)} {gsub("California","CA",$9)} {gsub("Colorado","CO",$9)}
{gsub("Connecticut","CT",$9)} {gsub("Delaware","DE",$9)} {gsub("District of Columbia","DC",$9)} {gsub("Florida","FL",$9)
} {gsub("Georgia","GA",$9)} {gsub("Hawaii","HI",$9)} {gsub("Idaho","ID",$9)} {gsub("Illinois","IL",$9)} {gsub("Indiana",
"IN",$9)} {gsub("Iowa","IA",$9)} {gsub("Kansas","KS",$9)} {gsub("Kentucky","KY",$9)} {gsub("Louisiana","LA",$9)} {gsub("
Maine","ME",$9)} {gsub("Maryland","MD",$9)} {gsub("Massachusetts","MA",$9)} {gsub("Michigan","MI",$9)} {gsub("Minnesota"
,"MN",$9)} {gsub("Mississippi","MS",$9)} {gsub("Missouri","MO",$9)} {gsub("Montana","MT",$9)} {gsub("Nebraska","NE",$9)}
 {gsub("Nevada","NV",$9)} {gsub("New Hampshire","NH",$9)} {gsub("New Jersey","NJ",$9)} {gsub("New Mexico","NM",$9)} {gsu
b("New York","NY",$9)} {gsub("North Carolina","NC",$9)} {gsub("North Dakota","ND",$9)} {gsub("Ohio","OH",$9)} {gsub("Okl
ahoma","OK",$9)} {gsub("Oregon","OR",$9)} {gsub("Pennsylvania","PA",$9)} {gsub("Rhode Island","RI",$9)} {gsub("South Car
olina","SC",$9)} {gsub("South Dakota","SD",$9)} {gsub("Tennessee","TN",$9)} {gsub("Texas","TX",$9)} {gsub("Utah","UT",$9
)} {gsub("Vermont","VT",$9)} {gsub("Virginia","VA",$9)} {gsub("Washington","WA",$9)} {gsub("West Virginia","WV",$9)} {gs
ub("Wisconsin","WI",$9)} {gsub("Wyoming","WY",$9)} {print $2"  "$9" - "$1" "$6,$6}' /script/tmp/peers2.txt > /script/tmp
/peers_all.txt
sudo cp /script/tmp/peers_all.txt /var/www/html/Peers.txt

rm /script/tmp/*.txt
