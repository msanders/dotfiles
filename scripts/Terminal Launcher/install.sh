#!/usr/bin/env bash
set -eu

DIRNAME=$(dirname "$0")
USER=$(whoami)

SUPPORT_DIR="$HOME/Library/Application Support/Terminal Launcher"
AGENT_DIR="$HOME/Library/LaunchAgents"
PLIST_OUTFILE="$AGENT_DIR/com.msanders.TerminalLauncher.plist"

mkdir -p "$SUPPORT_DIR"
mkdir -p "$AGENT_DIR"

clang "$DIRNAME/Terminal Launcher.m" -o "$SUPPORT_DIR/Terminal Launcher" -Os -Wall -framework Carbon -framework ApplicationServices -framework AppKit
sed -e "s/\${USER}/$USER/" "$DIRNAME/com.msanders.TerminalLauncher.plist.template" > "$PLIST_OUTFILE"
launchctl load "$PLIST_OUTFILE"
