{ pkgs, ... }:

{
  environment.etcBackupExtension = ".bak";
  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  time.timeZone = "Asia/Yekaterinburg";

  user.shell = "${pkgs.fish}/bin/fish";
  terminal = {
    font = "${pkgs.nerd-fonts.caskaydia-mono}/share/fonts/truetype/NerdFonts/CaskaydiaMono/CaskaydiaMonoNerdFont-Regular.ttf";
    colors = {
      background = "#1e1e2e";
      foreground = "#cdd6f4";
      cursor = "#f5e0dc";
      color0 = "#45475a";
      color1 = "#f38ba8";
      color2 = "#a6e3a1";
      color3 = "#f9e2af";
      color4 = "#89b4fa";
      color5 = "#f5c2e7";
      color6 = "#94e2d5";
      color7 = "#bac2de";
      color8 = "#585b70";
      color9 = "#f38ba8";
      color10 = "#a6e3a1";
      color11 = "#f9e2af";
      color12 = "#89b4fa";
      color13 = "#f5c2e7";
      color14 = "#94e2d5";
      color15 = "#a6adc8";
    };
  };

  environment.packages = with pkgs; [
    tmux
    vim
    git
    curl
    wget
    fish
    busybox
    openssh
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
