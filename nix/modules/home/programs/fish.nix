{ pkgs, inputs, ... }:
let
  platformSystem = pkgs.stdenv.hostPlatform.system;
in
{
  home.packages = with pkgs; [
    starship
    inputs.jj-starship.packages.${platformSystem}.default
  ];
  programs.fish.enable = true;
  xdg.configFile."fish/config.fish".enable = false;
}
