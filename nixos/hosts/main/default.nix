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
      dates = "daily";
      options = "--delete-older-than 7d";
      randomizedDelaySec = "45min";
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_6_13;
  };

  networking.hostName = "nixos-laptop";
  networking.networkmanager.enable = true;

  console = {
    keyMap = "colemak";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common = {
        default = [
          "gtk"
        ];
      };
    };
  };

  virtualisation.docker.enable = true;

  programs = {
    fish = {
      enable = true;
      loginShellInit = ''
        if test (tty) = "/dev/tty1"
          if uwsm check may-start
            exec uwsm start hyprland-uwsm.desktop
          end
        end
      '';
    };
    neovim = {
      enable = true;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    };
    hyprland = {
      enable = true;
      withUWSM = true;
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
    # fix unpatched dynamic libraries (ex., installed via neovim mason)
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
      ];
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
    starship
    zoxide
    vim
    tmux
    chezmoi
    jujutsu
    fzf
    eza
    ripgrep
    fd
    bitwarden-cli
    wakatime-cli
    lazygit
    lazydocker
    git
    curl
    wget
    btop
    telegram-desktop
    inputs.zen-browser.packages."${system}".twilight
    acpi
    socat
    playerctl

    clang
    # clients for dadbod
    mysql-client

    gnumake
    gcc
    pkg-config

    unzip # need for install stylua with nvim MasonToolsInstall

    nodejs_23
    go_1_24
    cargo

    apfs-fuse
    jq

    # apps
    alacritty

    # hyprland packages
    networkmanagerapplet
    brightnessctl
    wlsunset # night shift
    pavucontrol
    nautilus
    # hyprland above
    waybar
    wofi
    swaynotificationcenter
    wl-clipboard
    hyprpaper
    hypridle
    hyprpicker
    hyprcursor
    hyprshot
  ];

  services = {
    xserver.enable = false;
    displayManager.sddm.enable = false;
    openssh.enable = true;
    blueman.enable = true;
    logind = {
      lidSwitch = "suspend";
      extraConfig = ''
        			HandlePowerKey=suspend
        		'';
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  time.timeZone = "Asia/Yekaterinburg";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users = {
    root = {
      shell = pkgs.fish;
      hashedPassword = null;
    };
    muratoffalex = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
        "networkmanager"
        "video"
      ];
      # mkpasswd --method=sha-512
      hashedPassword = "$6$6E4ccds90qX/D6P3$iMcNxicNyi5g5UAF9ykJzoooiykikLmzJ4Cq6.vv5HgNl2Ra8UDxJ/HczWBFznVhyMTY56VjctHeBu0Q9q/NZ1";
      shell = pkgs.fish;
    };
  };

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
    polkit.enable = true;
    # Для PipeWire
    rtkit.enable = true;
  };

  system.stateVersion = "24.11";
}
