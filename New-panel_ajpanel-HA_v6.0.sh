#!/bin/sh
#
cd /tmp
set -e
 wget "https://raw.githubusercontent.com/Ham-ahmed/Secript-Panel-v6/refs/heads/main/New-panel_ajpanel-HA_v6.0.tar.gz"
wait
tar -xzf New-panel_ajpanel-HA_v6.0.tar.gz  -C /
wait
cd ..
set +e
rm -f /tmp/New-panel_ajpanel-HA_v6.0.tar.gz
sleep 2;
echo "" 
echo "" 
echo "*********************************************************"
echo "*                   INSTALLED SUCCESSFULLY              *"
echo "*                       ON - Panel                      *"
echo "*                Enigma2 restart is required            *"
echo "*********************************************************"
echo "               UPLOADED BY  >>>>   HAMDY_AHMED           "
sleep 4;
	echo '================================================='
################################################################                                                                                                                  
echo ". >>>>         your Device will RESTART Now          <<<<"
echo "*********************************************************"
wait
killall -9 enigma2
exit 0





























