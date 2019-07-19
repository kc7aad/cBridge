#!/bin/bash
export PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
# This file is used by the PNW DMR System to scrape  the RadioID.Net database. This pulls the user database,
# and stores the users from the United States and Canada. It will etrapalate them to a new file, then
# sort them according to our desired format. There is no magic here! There is also no warranty, expressed or
# implied, so feel free to use at your own risk. Also, feel free to modify at your own desire to help create
# your own scraper for your own area.
#
#
curl -o /script/tmp/us.txt "https://www.radioid.net/api/dmr/user/?country=United%20States"
curl -o /script/tmp/ca.txt "https://www.radioid.net/api/dmr/user/?country=Canada"
cat /script/tmp/us.txt /script/tmp/ca.txt > /script/tmp/all.txt
jq -r '(.results[] | [.callsign, .city, ."country", ."fname", .id, .remarks, .state, .surname]) | @csv' /script/tmp/all.
txt > /script/tmp/1.txt
sed 's/"//g' /script/tmp/1.txt > /script/tmp/2.txt
awk 'BEGIN {FS=OFS=","} {sub(/ .*/, "", $4)} {gsub("British Columbia","BC",$7)} {gsub("Alabama","AL",$7)} {gsub("Alaska","AK",$7)} {gsub("Arizona","AZ",$7)} {gsub("Arkansas","AR",$7)} {gsub("California","CA",$7)} {gsub("Colorado","CO",$7)}{gsub("Connecticut","CT",$7)} {gsub("Delaware","DE",$7)} {gsub("District of Columbia","DC",$7)} {gsub("Florida","FL",$7)} {gsub("Georgia","GA",$7)} {gsub("Hawaii","HI",$7)} {gsub("Idaho","ID",$7)} {gsub("Illinois","IL",$7)} {gsub("Indiana","IN",$7)} {gsub("Iowa","IA",$7)} {gsub("Kansas","KS",$7)} {gsub("Kentucky","KY",$7)} {gsub("Louisiana","LA",$7)} {gsub("Maine","ME",$7)} {gsub("Maryland","MD",$7)} {gsub("Massachusetts","MA",$7)} {gsub("Michigan","MI",$7)} {gsub("Minnesota","MN",$7)} {gsub("Mississippi","MS",$7)} {gsub("Missouri","MO",$7)} {gsub("Montana","MT",$7)} {gsub("Nebraska","NE",$7)} {gsub("Nevada","NV",$7)} {gsub("New Hampshire","NH",$7)} {gsub("New Jersey","NJ",$7)} {gsub("New Mexico","NM",$7)} {gsub("New York","NY",$7)} {gsub("North Carolina","NC",$7)} {gsub("North Dakota","ND",$7)} {gsub("Ohio","OH",$7)} {gsub("Oklahoma","OK",$7)} {gsub("Oregon","OR",$7)} {gsub("Pennsylvania","PA",$7)} {gsub("Rhode Island","RI",$7)} {gsub("South Carolina","SC",$7)} {gsub("South Dakota","SD",$7)} {gsub("Tennessee","TN",$7)} {gsub("Texas","TX",$7)} {gsub("Utah","UT",$7)} {gsub("Vermont","VT",$7)} {gsub("Virginia","VA",$7)} {gsub("Washington","WA",$7)} {gsub("West Virginia","WV",$7)} {gsub("Wisconsin","WI",$7)} {gsub("Wyoming","WY",$7)} {print $1" - "$4" - "$2" "$7" "$5,$5}' /script/tmp/2.txt > /script/tmp/Contacts.txt
sudo cp /script/tmp/Contacts.txt /var/www/html/US_Contacts.txt

rm /script/tmp/us.txt
rm /script/tmp/ca.txt
rm /script/tmp/all.txt
rm /script/tmp/1.txt
rm /script/tmp/2.txt
rm /script/tmp/Contacts.txt
