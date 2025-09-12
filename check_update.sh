#!/bin/sh

VERSION_FILE="/usr/lib/enigma2/python/Plugins/Extensions/AJPanel/version"

LATEST_VERSION_URL="https://raw.githubusercontent.com/Ham-ahmed/Secript-Panel-v6/refs/heads/main/version"

if [ -f "$VERSION_FILE" ]; then
    CURRENT_VERSION=$(cat "$VERSION_FILE")
else
    echo 
    exit 1
fi

LATEST_VERSION=$(wget -qO- "$LATEST_VERSION_URL")

if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
    echo "يتوفر تحديث جديد! الإصدار الحالي: $CURRENT_VERSION , الإصدار الجديد: $LATEST_VERSION"
    exit 0
else
    echo "أنت تستخدم أحدث إصدار: $CURRENT_VERSION"
    exit 1
fi