{ pkgs, ... }:

{
  environment.etcBackupExtension = ".bak";
  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  time.timeZone = "Asia/Yekaterinburg";

  user.shell = "${pkgs.fish}/bin/fish";
  terminal.font = "${pkgs.nerd-fonts.caskaydia-mono}/share/fonts/truetype/NerdFonts/CaskaydiaMono/CaskaydiaMonoNerdFont-Regular.ttf";

  environment.packages = with pkgs; [
    vim
    git
    curl
    wget
    fish
    busybox
    nerd-fonts.caskaydia-mono
  ];

  home-manager = {
    backupFileExtension = "hm-bak";

    config = { config, lib, pkgs, inputs, ... }:
      {
        imports = [
          ../../modules/home/base.nix
          ../../modules/home/ai.nix
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
