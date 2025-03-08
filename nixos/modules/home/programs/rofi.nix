{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [
      rofi-emoji-wayland
      rofi-calc
    ];
  };

  home.packages = with pkgs; [
    rofi-power-menu
  ];

  xdg.configFile."rofi/config.rasi".enable = false;
}
