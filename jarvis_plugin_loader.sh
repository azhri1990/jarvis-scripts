#!/data/data/com.termux/files/usr/bin/bash
PLUGIN_DIR="$HOME/.jarvis-plugins"
load_plugins() { [ -d "$PLUGIN_DIR" ] && for p in "$PLUGIN_DIR"/*.sh; do [ -f "$p" ] && source "$p"; done; }
list_plugins() { ls -la "$PLUGIN_DIR"/*.sh 2>/dev/null || echo "No plugins"; }
case "$1" in load) load_plugins ;; list) list_plugins ;; *) echo "Usage: $0 {load|list}" ;; esac
