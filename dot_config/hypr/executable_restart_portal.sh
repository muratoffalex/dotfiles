#!/usr/bin/env bash
sleep 1
systemctl --user stop xdg-desktop-portal-hyprland
systemctl --user stop xdg-desktop-portal
systemctl --user start xdg-desktop-portal-hyprland &
sleep 2
systemctl --user start xdg-desktop-portal &
