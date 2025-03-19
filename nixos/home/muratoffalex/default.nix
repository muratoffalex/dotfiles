{ pkgs, inputs, ... }:
{
  imports = [
    ../../modules/home/hypr.nix
    ../../modules/home/programs/fish.nix
    ../../modules/home/programs/neovim.nix
    ../../modules/home/programs/ags.nix
    ../../modules/home/programs/rofi.nix
    ../../modules/home/programs/direnv.nix
  ];
  home = {
    username = "muratoffalex";
    homeDirectory = "/home/muratoffalex";
    stateVersion = "24.11";

    packages = with pkgs; [
      home-manager

      # tui
      aerc
      yazi
      bluetui
      impala
      btop
      lazygit
      lazydocker

      # cli
      sesh
      gitmux
      gh
      zoxide
      fzf
      eza
      ripgrep
      fd
      bitwarden-cli
      wakatime-cli
      jujutsu
      chezmoi

      # services
      maestral
      swayosd
      sway-audio-idle-inhibit

      # apps
      alacritty
      kitty
      kooha
      swappy
      gnome-calculator
      vlc
      inputs.zen-browser.packages."${system}".twilight
      hiddify-app
      telegram-desktop
      nautilus
      libreoffice-fresh
      (yandex-music.overrideAttrs (oldAttrs: {
        version = "5.41.1";
        src = oldAttrs.src.override {
          hash = "sha256-nE4KgiMdKspDJXeaD88EvrAX7CrscsN8STKpmG9t5x4=";
        };
      }))

      # dev tools
      clang
      nodejs_23
      go_1_24
      cargo
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
    # theme = {
    #   package = pkgs.gruvbox-gtk-theme;
    #   name = "Gruvbox-Light";
    # };

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
    swayosd = {
      Unit = {
        Description = "Sway On-Screen-Display";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
        Restart = "always";
        RestartSec = "5s";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
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
