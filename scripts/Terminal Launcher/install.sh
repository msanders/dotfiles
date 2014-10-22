#!/usr/bin/env bash
set -eu

DIRNAME=$(dirname "$0")
USER=$(whoami)

TARGET="Terminal Launcher"
DOMAIN="com.msanders.TerminalLauncher"
SUPPORT_DIR="$HOME/Library/Application Support/$TARGET"
AGENT_DIR="$HOME/Library/LaunchAgents"
PLIST_OUTFILE="$AGENT_DIR/$DOMAIN.plist"

mkdir -p "$SUPPORT_DIR"
mkdir -p "$AGENT_DIR"

clang "$DIRNAME/Terminal Launcher.m" -o "$SUPPORT_DIR/$TARGET" -Os -Wall -framework Carbon -framework AppKit
sed -e "s/\${USER}/$USER/" "$DIRNAME/$DOMAIN.plist.template" > "$PLIST_OUTFILE"

if launchctl list | grep "$DOMAIN" &>/dev/null; then
    launchctl unload "$PLIST_OUTFILE"
fi

launchctl load "$PLIST_OUTFILE"
echo "Installed $TARGET."
