wget -O /home/kc7aad/file1 "https://www.radioid.net/static/users.csv"
egrep 'Washington,United States|Oregon,United States|Idaho,United States|Montana,United States|British Columbia' /home/kc7aad/file1>/home/kc7aad/PNW1
awk 'BEGIN {FS=OFS=","} {sub(/ .*/, "", $3)} {gsub("Washington", "WA")} {gsub("Idaho", "ID")} {gsub("Montana", "MT")} {gsub("Oregon", "OR")} {gsub("British Columbia", "BC")} {print $2" - "$3" - "$4" "$5" "$1,$1}' /home/kc7aad/PNW1 > /home/kc7aad/PNW_Contact.txt
sed "s/'/ /g" /home/kc7aad/PNW_Contact.txt > /home/kc7aad/PNW_Contacts.txt
rm /home/kc7aad/PNW_Contact.txt
rm /home/kc7aad/file1
rm /home/kc7aad/PNW1
sudo cp /home/kc7aad/PNW_Contacts.txt /var/www/html/PNW_Contacts.txt
mail -s "PNW DMR Contacts Update" kc7aad@gmail.com,no7rf@trbo.org -A /home/kc7aad/PNW_Contacts.txt < /home/kc7aad/PNW_Message.txt
