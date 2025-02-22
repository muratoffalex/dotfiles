{ config, pkgs, inputs, ... }:

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
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
      Restart = "always";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  programs.home-manager.enable = true;
  programs.yazi.enable = true;
}
