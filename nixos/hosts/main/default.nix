{ pkgs, inputs, ... }:
let
  hyprPackages = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
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
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common.default = [ "gtk" ];
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
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
      package = hyprPackages.hyprland;
      portalPackage = hyprPackages.xdg-desktop-portal-hyprland;
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    tmux
    git
    jq
    libnotify
    apfs-fuse
    nvd

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
