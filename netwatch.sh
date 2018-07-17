#!/bin/bash

echo Beginning...
#sudo cp /home/kc7aad/watcher /home/kc7aad/watcher.old
sudo wget -O /home/kc7aad/watcher http://44.12.9.10:42420/report?netwatch
sudo cat /home/kc7aad/watcher /home/kc7aad/watcher.old > /home/kc7aad/combine
sudo sort -r -t " " -k2.1,2.6 -k1.1,1.9 -u /home/kc7aad/combine > /home/kc7aad/diff
sudo cp diff /var/www/html/pnw.txt
echo Cleanup!!
#sudo rm diff
#sudo rm sort
#sudo rm pnw.txt
#sudo rm watcher.old

