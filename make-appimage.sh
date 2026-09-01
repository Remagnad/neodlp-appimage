#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q neodlp | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/256x256@2/apps/neodlp.png
export DESKTOP=/usr/share/applications/NeoDLP.desktop

# Deploy dependencies
quick-sharun \
    /usr/bin/deno           \
    /usr/bin/neodlp         \
    /usr/bin/neodlp-msghost \
    /usr/bin/neodlp-pot     \
    /usr/bin/yt-dlp         \

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
