#!/usr/bin/env bash

choice=$(printf "▸ Change Theme\n▸ Power\n" | wofi --show dmenu --cache-file /dev/null)

choice=${choice#"▸ "}

case "$choice" in
    "Change Theme")
        theme_choice=$(printf "Light Theme\nDark Theme\n" | wofi --show dmenu --cache-file /dev/null)
        case "$theme_choice" in
            "Light Theme") ~/scripts/change_theme light ;;
            "Dark Theme") ~/scripts/change_theme dark ;;
        esac
        ;;
    "Power")
        power_choice=$(printf "Shutdown\nReboot\nSuspend\n" | wofi --show dmenu --cache-file /dev/null)
        case "$power_choice" in
            "Shutdown") shutdown now ;;
            "Reboot") reboot ;;
            "Suspend") systemctl suspend ;;
        esac
        ;;
esac
