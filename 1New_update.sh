#!/bin/bash

#config
config_file="/etc/enigma2/settings"
espp=$(grep "config.plugins.AJPanel.backupPath" "$config_file" | cut -d '=' -f 2)
pack="ajpanel_menu.xml"
package="${espp}/${pack}"  # إضافة / لفصل المسار عن اسم الملف
url="https://raw.githubusercontent.com/Ham-ahmed/Secript-Panel-v6/refs/heads/main/ajpanel_menu.xml"

# التحقق من وجود المسار
if [ ! -d "$espp" ]; then
    echo "Error: Backup path does not exist: $espp"
    exit 1
fi

#download & install
if wget -qO "$package" --no-check-certificate "$url"; then
    echo "Download successful: $package"
    sleep 3
    
    # إرسال رسالة نجاح
    message="> $(date +%a.%d.%b.%Y), panel H-Ahmed v6 is updated successfully"
    wget -qO /dev/null "http://localhost/web/message?text=${message}&type=5&timeout=5" 2>/dev/null
    sleep 5
else
    echo "Error: Download failed"
    exit 1
fi

