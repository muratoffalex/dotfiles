{ pkgs, inputs, ... }:
let
  agsPkgs = inputs.ags.packages.${pkgs.system};
in
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs = {
    ags = {
      enable = true;
      configDir = null;
      extraPackages = [
        agsPkgs.bluetooth
        agsPkgs.wireplumber
        agsPkgs.hyprland
        agsPkgs.battery
        agsPkgs.network
        agsPkgs.tray
        agsPkgs.notifd
        agsPkgs.apps
      ];
    };
  };
}
