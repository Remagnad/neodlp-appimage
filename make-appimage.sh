#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q neodlp | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export APPNAME=neodlp
export ICON=/usr/share/icons/hicolor/256x256@2/apps/neodlp.png
export DESKTOP=/usr/share/applications/NeoDLP.desktop

# Deploy dependencies
echo "=== TESTE SHARUN ==="

quick-sharun /usr/bin/neodlp /usr/bin/neodlp-msghost /usr/bin/neodlp-pot /usr/bin/deno /usr/bin/yt-dlp

echo "=== SHARUN TERMINOU ==="
    
# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
