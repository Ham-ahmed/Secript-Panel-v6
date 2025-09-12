#!/bin/bash

# Config
settings_file="/etc/enigma2/settings"
espp=$(grep 'config.plugins.AJPanel.backupPath' "$settings_file" | cut -d '=' -f 2)
pack="ajpanel_menu.xml"
package="${espp}${pack}"
url="https://raw.githubusercontent.com/Ham-ahmed/Secript-Panel-v6/refs/heads/main/ajpanel_menu.xml"

# Check if settings file exists
if [ ! -f "$settings_file" ]; then
    echo "Error: Settings file not found: $settings_file"
    exit 1
fi

# Check if backup path is configured
if [ -z "$espp" ]; then
    echo "Error: Backup path not configured in settings"
    exit 1
fi

# Check if destination directory exists
if [ ! -d "$espp" ]; then
    echo "Error: Destination directory does not exist: $espp"
    exit 1
fi

# Download & install
echo "Downloading update from $url"
wget -qO "$package" --no-check-certificate "$url"

if [ $? -eq 0 ]; then
    echo "Download completed successfully"
    
    # Verify file was downloaded
    if [ -f "$package" ]; then
        echo "File saved to: $package"
        
        # Send success notification
        message_text="> $(date +%a.%d.%b.%Y), panel-v6_HA is updated successfully"
        wget -qO /dev/null "http://localhost/web/message?text=${message_text}&type=5&timeout=5"
        
        echo "Update completed successfully"
    else
        echo "Error: Downloaded file not found"
        exit 1
    fi
else
    echo "Error: Download failed"
    exit 1
fi

sleep 3

