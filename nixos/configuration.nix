{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    settings = {
      trusted-users = [
        "root"
        "muratoffalex"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  console = {
    #keyMap = "colemak";
    useXkbConfig = true;
  };

  programs = {
    fish = {
      enable = true;
      loginShellInit = ''
        				if test (tty) = "/dev/tty1"
        					exec Hyprland
        				end
        			'';
    };
    neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    };
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    nm-applet = {
      enable = true;
      indicator = true;
    };
    hyprlock = {
      enable = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "CaskaydiaCove Nerd Font" ];
        # sansSerif = [ "CaskaydiaCove Nerd Font" ];
        # serif = [ "CaskaydiaCove Nerd Font" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    zoxide
    starship
    vim
    tmux
    chezmoi
    jujutsu
    fzf
    eza
    colima
    docker
    ripgrep
    fd
    bitwarden-cli
    wakatime-cli
    lazygit
    lazydocker
    yazi
    git
    curl
    wget
    btop
    gnumake
    gcc
    pkg-config
    clang
    sesh
    bitwarden
    telegram-desktop
    inputs.zen-browser.packages."${system}".twilight
    acpi
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default

    maestral

    nodejs_23
    go_1_24
    cargo
    #nodePackages.kulala-ls

    apfs-fuse
    jq
    nixfmt-rfc-style

    # apps
    alacritty

    # hyprland packages
    networkmanagerapplet
    brightnessctl
    wlsunset # night shift
    pavucontrol
    dolphin
    # hyprland above
    waybar # Статус бар
    wofi # Лаунчер приложений
    swaynotificationcenter
    wl-clipboard # Менеджер буфера обмена
    hyprpaper # Обои
    hypridle
    hyprpicker
    hyprcursor
    hyprshot
  ];

  services.openssh.enable = true;
  services.logind = {
    lidSwitch = "suspend";
    extraConfig = ''
      			HandlePowerKey=suspend
      		'';
  };

  systemd.user.services.maestral = {
    description = "Maestral Dropbox Client";
    wantedBy = [ "default.target" ];
    after = [ "network-online.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.maestral}/bin/maestral start -f";
      ExecStop = "${pkgs.maestral}/bin/maestral stop";
      Restart = "on-failure";
      RestartSec = "10s";
    };

    environment = {
      "https_proxy" = "";
      "http_proxy" = "";
      "all_proxy" = "";
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Для PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  time.timeZone = "Asia/Yekaterinburg";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.root = {
    shell = pkgs.fish;
    hashedPassword = null;
  };

  users.users.muratoffalex = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    # mkpasswd --method=sha-512
    hashedPassword = "$6$6E4ccds90qX/D6P3$iMcNxicNyi5g5UAF9ykJzoooiykikLmzJ4Cq6.vv5HgNl2Ra8UDxJ/HczWBFznVhyMTY56VjctHeBu0Q9q/NZ1";
    shell = pkgs.fish;
  };

  security = {
    sudo.enable = true;
    sudo.wheelNeedsPassword = false;
    polkit.enable = true;
  };

  services = {
    displayManager.sddm.enable = false;
    xserver = {
      enable = true;
      displayManager.gdm.enable = false;
      displayManager.lightdm.enable = false;
      xkb = {
        layout = "us,ru,us";
        variant = "colemak,,";
        options = "grp:ctrl_space_toggle";
      };
    };
  };

  system.stateVersion = "24.11";
}
