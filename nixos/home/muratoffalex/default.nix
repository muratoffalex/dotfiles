{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.ags.homeManagerModules.default
    ../../modules/home/hypr.nix
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
      fish
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
      direnv
      rofi-power-menu

      # services
      maestral
      swayosd
      sway-audio-idle-inhibit

      # apps
      alacritty
      kooha
      swappy
      gnome-calculator
      vlc
      inputs.zen-browser.packages."${system}".twilight
      hiddify-app
      telegram-desktop
      nautilus
      libreoffice-fresh

      # themes
      starship

      # build tools
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

  programs = {
    home-manager.enable = true;
    ags = {
      enable = true;
      configDir = null;
      extraPackages = [
        inputs.ags.packages.${pkgs.system}.bluetooth
        inputs.ags.packages.${pkgs.system}.wireplumber
        inputs.ags.packages.${pkgs.system}.hyprland
        inputs.ags.packages.${pkgs.system}.battery
        inputs.ags.packages.${pkgs.system}.network
        inputs.ags.packages.${pkgs.system}.tray
        inputs.ags.packages.${pkgs.system}.notifd
        inputs.ags.packages.${pkgs.system}.apps
      ];
    };
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = with pkgs; [
        rofi-emoji-wayland
        rofi-calc
      ];
    };
    neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      extraPackages = with pkgs; [
        # lsp
        marksman
        lua-language-server
        intelephense
        gopls
        nil
        clang-tools
        typescript-language-server
        vue-language-server
        tailwindcss-language-server
        vscode-langservers-extracted # css,html,json,eslint
        pyright
        rust-analyzer
        # TODO: uncomment when accepted -- https://nixpkgs-tracker.ocfox.me/?pr=385105
        # kulala-ls

        # linters
        markdownlint-cli
        golangci-lint
        php.packages.php-codesniffer

        # formatters
        gotools # goimports inside
        stylua
        prettierd
        nodePackages.prettier
        nixfmt-rfc-style
        kulala-fmt

        # other
        mysql-client # for dadbod
      ];
    };
  };

  # use existing config created by chezmoi instead hm
  xdg.configFile."rofi/config.rasi".enable = false;
  xdg.configFile."fish/config.fish".enable = false;

  services.lorri.enable = true;

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
  };
}
