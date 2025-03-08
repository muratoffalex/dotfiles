{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "CaskaydiaCove Nerd Font" ];
      };
    };
  };
}
