#!/usr/bin/env bash
set -eu

DIRNAME=$(dirname "$0")
USER=$(whoami)

TARGET="Terminal Launcher"
SUPPORT_DIR="$HOME/Library/Application Support/$TARGET"
AGENT_DIR="$HOME/Library/LaunchAgents"
PLIST_OUTFILE="$AGENT_DIR/com.msanders.TerminalLauncher.plist"

mkdir -p "$SUPPORT_DIR"
mkdir -p "$AGENT_DIR"

clang "$DIRNAME/Terminal Launcher.m" -o "$SUPPORT_DIR/$TARGET" -Os -Wall -framework Carbon -framework AppKit
sed -e "s/\${USER}/$USER/" "$DIRNAME/com.msanders.TerminalLauncher.plist.template" > "$PLIST_OUTFILE"

launchctl unload "$PLIST_OUTFILE"
launchctl load "$PLIST_OUTFILE"
echo "Installed $TARGET"
