#!/bin/bash
#config
espp=$(cat /etc/enigma2/settings | grep config.plugins.AJPanel.backupPath | cut -d '=' -f 2)


pack="ajpanel_menu_HA-v6.xml"
package=$espp$pack
url=https://raw.githubusercontent.com/Ham-ahmed/Secript-Panel-v6/refs/heads/main/ajpanel_menu_HA-v6.xml
if [ "$espp" == "/media/hdd/AJPanel_Backup/" ]; then
pack="ajpanel_menu.xml"
package=$espp$pack
fi

#download & install
echo "> installing latest update please wait ..."
sleep 3s
wget -O $package --no-check-certificate $url


echo "> done"
sleep 3s
exit 0
