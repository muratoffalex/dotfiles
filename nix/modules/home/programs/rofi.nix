{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-calc
    ];
  };

  home.packages = with pkgs; [
    rofi-power-menu
  ];

  xdg.configFile."rofi/config.rasi".enable = false;
}
