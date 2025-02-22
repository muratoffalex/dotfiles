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
      hiddify-app
      gnome-calculator
      swayosd
      maestral
      yandex-music
      kooha
      vlc
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

  programs.home-manager.enable = true;
  programs.yazi.enable = true;

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      nixfmt-rfc-style
    ];
  };

  gtk = {
    enable = true;

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

  systemd.user.services.swayosd = {
    Unit = {
      Description = "Sway On-Screen-Display";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services.maestral = {
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
}
