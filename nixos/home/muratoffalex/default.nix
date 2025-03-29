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

    sessionVariables = {
      # HACK: for nvim snacks.picker for frecency and history
      SQLITE_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath (with pkgs; [ sqlite ])}";
    };

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
      just

      # services
      maestral
      swayosd
      sway-audio-idle-inhibit

      # apps
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

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Rubik";
      size = 12;
    };
  };

  xdg = {
    enable = true;
    desktopEntries = {
      yandex-music = {
        name = "Yandex Music";
        genericName = "Music Player";
        exec = "zen -no-remote -new-window \"https://music.yandex.ru/\"";
        terminal = false;
        categories = [ "AudioVideo" "Audio" "Music" "Player" ];
        comment = "Yandex Music web player";
      };
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
