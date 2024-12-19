#!/usr/bin/env bash

echo "**** Installing/upgrading ProtonUp-Qt from local AppImage ****"

PROTONUP_VERSION="2.8.2"
APPIMAGE_PATH="/usr/local/src/ProtonUp-Qt-${PROTONUP_VERSION}-x86_64.AppImage"

# Make AppImage executable
chmod +x "${APPIMAGE_PATH}"

# Create symbolic link in /usr/local/bin
ln -sf "${APPIMAGE_PATH}" /usr/local/bin/protonup-qt

echo "DONE"
