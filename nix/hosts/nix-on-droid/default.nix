{ config, lib, pkgs, ... }:

{
  environment.etcBackupExtension = ".bak";
  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  time.timeZone = "Asia/Yekaterinburg";

  environment.packages = with pkgs; [
    vim
    git
    curl
    wget
  ];

  home-manager = {
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;

    config =
      { config, lib, pkgs, ... }:
      {
        imports = [
          ../../modules/home/base.nix
          ../../modules/home/ai.nix
          ../../modules/home/apps.nix
          ../../modules/home/dev.nix
          ../../modules/home/tui.nix
          ../../modules/home/programs/fish.nix
          ../../modules/home/programs/neovim.nix
          ../../modules/home/programs/direnv.nix
        ];
        home.stateVersion = "24.05";
      };
  };
}
