{ pkgs, ... }:
{
  home.packages = with pkgs; [ starship ];
  programs.fish.enable = true;
  xdg.configFile."fish/config.fish".enable = false;
}
