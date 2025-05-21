{ pkgs, inputs, ... }:
{
  imports = [
    ../../modules/home/hypr.nix
    ../../modules/home/programs/fish.nix
    ../../modules/home/programs/neovim.nix
    ../../modules/home/programs/ags.nix
    ../../modules/home/programs/rofi.nix
    ../../modules/home/programs/direnv.nix
    inputs.zen-browser.homeModules.twilight
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
      clipse

      # ai
      vectorcode
      python312Full
      python312Packages.python-dotenv # for vectorcode
      python312Packages.socksio # for vectorcode
      aider-chat-with-browser
      inputs.mcp-hub.packages."${system}".default

      # services
      maestral
      sway-audio-idle-inhibit

      # apps
      kitty
      kooha
      swappy
      oculante
      gnome-calculator
      vlc
      hiddify-app
      telegram-desktop
      nautilus
      libreoffice-fresh

      # dev tools
      clang
      nodejs_latest
      go_1_24
      cargo
      uv
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

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.tridactyl-native ];
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
