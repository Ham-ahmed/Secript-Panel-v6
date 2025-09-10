#!/bin/bash

#config
espp=$(cat /etc/enigma2/settings | grep config.plugins.AJPanel.backupPath | cut -d '=' -f 2)
pack="ajpanel_menu.xml"
package=$espp$pack
url=https://raw.githubusercontent.com/Ham-ahmed/Secript-Panel-v6/refs/heads/main/ajpanel_menu.xml

#download & install
echo "> installing latest update please wait ..."
sleep 3s
wget -O $package --no-check-certificate $url

wget "http://localhost/web/message?text=> $(date +%a.%d.%b.%Y),  ajpanel_menu_HA-v6 is updated successfully &type=5&timeout=5" >/dev/null 2>&1
sleep 5

