#!/bin/bash

# Configuration settings
settings_file="/etc/enigma2/settings"
package_name="ajpanel_menu.xml"
url="https://raw.githubusercontent.com/Ham-ahmed/Secript-Panel-v6/main/$package_name"

# --- Main Script ---

# 1. Get the backup path from the settings file
#    - Get the value after the '='
#    - Remove carriage return characters ('\r')
#    - Trim any leading/trailing whitespace
backup_path=$(grep 'config.plugins.AJPanel.backupPath' "$settings_file" | cut -d '=' -f 2 | tr -d '\r ' | sed 's/^[ \t]*//;s/[ \t]*$//')

# Check for existence of essential paths and permissions
if [ ! -f "$settings_file" ]; then
    echo "Error: Settings file not found at $settings_file."
    exit 1
fi

if [ -z "$backup_path" ]; then
    echo "Error: AJPanel backup path is not configured in settings."
    exit 1
fi

if [ ! -d "$backup_path" ]; then
    echo "Error: Destination directory does not exist: $backup_path."
    exit 1
fi

if [ ! -w "$backup_path" ]; then
    echo "Error: Write permission denied to directory: $backup_path."
    exit 1
fi

destination_file="${backup_path%/}/$package_name"

# 2. Download the update with improved error handling
echo "Attempting to download update from $url..."
wget -qO "$destination_file" --no-check-certificate "$url"

if [ $? -ne 0 ]; then
    echo "Error: Download failed. Please check your internet connection."
    exit 1
fi

# 3. Verify the downloaded file
if [ ! -s "$destination_file" ]; then
    echo "Error: Downloaded file is empty or missing. Update failed."
    rm -f "$destination_file" # Clean up the empty file
    exit 1
fi

# 4. Add success message and notification
echo "Download completed successfully."
echo "File saved to: $destination_file"

# Encode the success message for the Enigma2 web interface
# Note: %20 is for space, %2C is for comma, etc.
current_date=$(date +"%d-%m-%Y")
message_text="Update successful: AJPanel menu was updated on $current_date"
# Use 'sed' to URL-encode the message for safer transmission
encoded_message=$(echo "$message_text" | sed 's/ /%20/g;s/,/%2C/g;s/:/%3A/g')

# Send a success notification to the Enigma2 box
wget -qO /dev/null "http://127.0.0.1/web/message?text=${encoded_message}&type=5&timeout=5"

echo "Update process finished."
sleep 3
