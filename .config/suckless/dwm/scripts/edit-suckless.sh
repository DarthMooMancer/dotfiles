#!/bin/bash

set -e

REBUILD=false

# Parse flags
while getopts ":f" opt; do
  case $opt in
    f)
      REBUILD=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))
APP="$1"
APP_DIR="/home/andrew/dotfiles/.config/suckless/$APP"
CONFIG_FILE="$APP_DIR/config.def.h"

if [[ -z "$APP" ]]; then
    echo "Usage: 
    edit-suckless.sh [ option ] < suckless-app >"
    echo "Options:
    -f [ force rebuild even if no changes were made ]"
    exit 1
fi

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Config file not found: $CONFIG_FILE"
    exit 1
fi

OLD_DIR="$(pwd)"
cd "$APP_DIR" || {
    echo "Failed to cd into $APP_DIR"
    exit 1
}

# Hash before edit
BEFORE_HASH=$(sha256sum config.def.h | cut -d ' ' -f1)

# Edit file
nvim config.def.h

# Hash after edit
AFTER_HASH=$(sha256sum config.def.h | cut -d ' ' -f1)

if [[ "$BEFORE_HASH" != "$AFTER_HASH" || "$REBUILD" == true ]]; then
    echo "Rebuilding $APP..."
    doas rm -f config.h
    make
    doas make install
    pkill dwm
else
    echo "No changes detected. Skipping rebuild."
fi

cd "$OLD_DIR"
