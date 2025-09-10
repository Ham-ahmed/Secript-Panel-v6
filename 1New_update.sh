#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import time
import requests
import xml.etree.ElementTree as ET
from pathlib import Path

def main():
    # Config
    try:
        with open('/etc/enigma2/settings', 'r') as f:
            settings = f.readlines()
        
        espp = None
        for line in settings:
            if 'config.plugins.AJPanel.backupPath' in line:
                espp = line.split('=')[1].strip()
                break
        
        if not espp:
            print("Error: Could not find backup path in settings")
            sys.exit(1)
            
    except FileNotFoundError:
        print("Error: /etc/enigma2/settings not found")
        sys.exit(1)
    except Exception as e:
        print(f"Error reading settings: {e}")
        sys.exit(1)

    pack = "ajpanel_menu.xml"
    package = os.path.join(espp, pack)
    url = "https://raw.githubusercontent.com/Ham-ahmed/Secript-Panel-v6/refs/heads/main/ajpanel_menu.xml"

    # Download & install
    try:
        print(f"Downloading from {url}")
        response = requests.get(url, verify=False, timeout=30)
        response.raise_for_status()
        
        # Ensure directory exists
        os.makedirs(os.path.dirname(package), exist_ok=True)
        
        with open(package, 'wb') as f:
            f.write(response.content)
        
        print(f"File saved to: {package}")
        
        # Verify XML is valid
        try:
            ET.parse(package)
            print("XML validation: OK")
        except ET.ParseError as e:
            print(f"Warning: Downloaded XML may be invalid: {e}")
        
    except requests.exceptions.RequestException as e:
        print(f"Download error: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"Error saving file: {e}")
        sys.exit(1)

    # Send success message
    try:
        current_date = time.strftime("%a.%d.%b.%Y")
        message_url = f"http://localhost/web/message?text=> {current_date}, ajpanel_menu_HA-v6 is updated successfully &type=5&timeout=5"
        requests.get(message_url, timeout=10)
        print("Success message sent")
    except Exception as e:
        print(f"Warning: Could not send success message: {e}")

if __name__ == "__main__":
    main()