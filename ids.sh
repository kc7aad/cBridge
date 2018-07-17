# This file is used by the PNW DMR System to scrape  the RadioID.Net database. This pulls the user database,
# then only stores the users from WA, OR, ID, MT and BC (Canada). It will etrapalate them to a new file, then
# sort them according to our desired format. There is no magic here! There is also no warranty, expressed or
# implied, so feel free to use at your own risk. Also, feel free to modify at your own desire to help create
# Your own scraper for your own area. 
#
#
wget -O ~/file1 "https://www.radioid.net/static/users.csv"
egrep 'Washington,United States|Oregon,United States|Idaho,United States|Montana,United States|British Columbia' ~/file1>~/PNW1
awk 'BEGIN {FS=OFS=","} {sub(/ .*/, "", $3)} {gsub("Washington", "WA")} {gsub("Idaho", "ID")} {gsub("Montana", "MT")} {gsub("Oregon", "OR")} {gsub("British Columbia", "BC")} {print $2" - "$3" - "$4" "$5" "$1,$1}' ~/PNW1 > ~/PNW_Contact.txt
sed "s/'/ /g" ~/PNW_Contact.txt > ~/PNW_Contacts.txt
rm ~/PNW_Contact.txt
rm ~/file1
rm ~/PNW1
sudo cp ~/PNW_Contacts.txt /var/www/html/PNW_Contacts.txt
mail -s "PNW DMR Contacts Update" kc7aad@gmail.com,no7rf@trbo.org -A ~/PNW_Contacts.txt < ~/PNW_Message.txt
