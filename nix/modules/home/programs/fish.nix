{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    starship
    inputs.jj-starship.packages.${system}.default
  ];
  programs.fish.enable = true;
  xdg.configFile."fish/config.fish".enable = false;
}
