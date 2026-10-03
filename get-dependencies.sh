#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
 pacman -Syu --noconfirm \
     ffmpeg              \
     aria2               \
     libappindicator \
     webkit2gtk-4.1 \
     

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
PRE_BUILD_CMDS='sed -i "/^check() {/,/^}/d" PKGBUILD' \
make-aur-package libsoup

make-aur-package neodlp

echo "Downloading latest yt-dlp release..."
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/bin/yt-dlp
chmod +x /usr/bin/yt-dlp
 

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
