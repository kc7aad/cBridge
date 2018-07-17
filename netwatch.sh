# This file is being tested to collect and archive netwatch traffic from the cBridge.
# This file is a work in progress, and may be removed due to being a waste of time! 
#
#
#

#!/bin/bash

echo Beginning...
#sudo cp ~/watcher ~/watcher.old
sudo wget -O ~/watcher http://44.12.9.10:42420/report?netwatch
sudo cat ~/watcher ~/watcher.old > ~/combine
sudo sort -r -t " " -k2.1,2.6 -k1.1,1.9 -u ~/combine > ~/diff
sudo cp diff /var/www/html/pnw.txt
echo Cleanup!!
#sudo rm diff
#sudo rm sort
#sudo rm pnw.txt
#sudo rm watcher.old

