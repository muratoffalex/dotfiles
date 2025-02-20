{ config, pkgs, ... }:

{
  home = {
    username = "muratoffalex";
    homeDirectory = "/home/muratoffalex";
    stateVersion = "24.11";

    packages = with pkgs; [
      home-manager
      aerc
    ];
  };

  programs.home-manager.enable = true;
  programs.yazi.enable = true;
}
