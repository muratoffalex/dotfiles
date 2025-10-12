{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    kitty
    kooha
    swappy
    oculante
    gnome-calculator
    vlc
    telegram-desktop
    nautilus
    libreoffice-fresh
    qbittorrent
  ];
}
