{ pkgs, inputs, ... }:
{
  imports = [
    ../../modules/home/base.nix
    ../../modules/home/ai.nix
    ../../modules/home/apps.nix
    ../../modules/home/dev.nix
    ../../modules/home/tui.nix
    ../../modules/home/programs/hypr.nix
    ../../modules/home/programs/fish.nix
    ../../modules/home/programs/neovim.nix
    ../../modules/home/programs/rofi.nix
    ../../modules/home/programs/direnv.nix
    ../../modules/home/programs/zen.nix
  ];
  home = {
    username = "muratoffalex";
    homeDirectory = "/home/muratoffalex";
    stateVersion = "24.11";

    packages = with pkgs; [
      home-manager

      # cli
      gh
      bitwarden-cli
      wakatime-cli
      clipse

      # services
      maestral
      sway-audio-idle-inhibit
    ];

    pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };
  };

  gtk = {
    enable = true;

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = "false";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Rubik";
      size = 12;
    };
  };

  systemd.user.services = {
    maestral = {
      Unit = {
        Description = "Maestral Dropbox Client";
        PartOf = [ "graphical-session.target" ];
        After = [ "network-online.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.maestral}/bin/maestral start -f";
        ExecStop = "${pkgs.maestral}/bin/maestral stop";
        Restart = "on-failure";
        RestartSec = "10s";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };

  programs.home-manager.enable = true;
}
