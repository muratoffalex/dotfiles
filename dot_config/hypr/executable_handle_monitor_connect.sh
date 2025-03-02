#!/usr/bin/env bash
# https://wiki.hyprland.org/FAQ/#how-do-i-move-my-favorite-workspaces-to-a-new-monitor-when-i-plug-it-in
handle() {
  case $1 in monitoradded*)
    hyprctl dispatch moveworkspacetomonitor "1 1"
    hyprctl dispatch moveworkspacetomonitor "2 1"
    hyprctl dispatch moveworkspacetomonitor "3 1"
    hyprctl dispatch focusmonitor 1
  esac
}

handle $(hyprctl monitors | grep -v "eDP-1" | grep "Monitor" | awk '{print $2}' | xargs -I {} echo "monitoradded>>{}")

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" | while read -r line; do handle "$line"; done
