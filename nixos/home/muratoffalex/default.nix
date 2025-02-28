{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home = {
    username = "muratoffalex";
    homeDirectory = "/home/muratoffalex";
    stateVersion = "24.11";

    packages = with pkgs; [
      home-manager
      aerc
      sesh
      yazi
      gitmux
      direnv
      bluetui
      impala # wifi tui

      # services
      maestral
      swayosd
      sway-audio-idle-inhibit

      # apps
      kooha
      swappy
      gnome-calculator
      vlc
      alacritty
      inputs.zen-browser.packages."${system}".twilight
      hiddify-app
      telegram-desktop
      yandex-music
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

  services.lorri.enable = true;
  programs.home-manager.enable = true;
  # programs.gauntlet = {
  #   enable = true;
  #   package = inputs.gauntlet.packages.${pkgs.system}.default;
  #   service.enable = true;
  #   config = {};
  # };
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      nixfmt-rfc-style
      marksman
      lua-language-server
      intelephense
      gopls
      mysql-client # for dadbod
    ];
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
      name = "Sans";
      size = 11;
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
    bwapi = {
      Unit = {
        Description = "Bitwarden API";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.bitwarden-cli}/bin/bw serve --port 49186";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = pkgs.lib.mkForce []; # disable by default
        # WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
