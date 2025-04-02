{ pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/config.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/gc.nix
    ../../modules/nixos/settings.nix
    ../../modules/nixos/security.nix
  ];

  home-manager.backupFileExtension = "backup";
  nixpkgs.config.allowUnfree = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  console = {
    keyMap = "colemak";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-termfilechooser
    ];
    config = {
      common.default = [ "gtk" ];
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" "gtk" ];
      };
    };
    xdgOpenUsePortal = true;
  };

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
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    nix-ld = {
      # fix unpatched dynamic libraries (ex., installed via neovim mason)
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    # change to stable when new version tmux is released > 3.5a
    inputs.tmux-nightly.packages.${pkgs.system}.default
    git
    jq
    libnotify
    apfs-fuse

    # nix specific
    nvd
    nix-search-cli

    # networking
    curl
    wget
    traceroute
    mtr

    gnumake
    gcc
    pkg-config
    unzip
  ];

  services = {
    xserver.enable = false;
    displayManager.sddm.enable = false;
    openssh.enable = true;
    upower = {
      enable = true;
      ignoreLid = true;
    };
    logind = {
      lidSwitch = "suspend";
      extraConfig = ''
        			HandlePowerKey=suspend
        		'';
    };
  };

  time.timeZone = "Asia/Yekaterinburg";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "24.11";
}
