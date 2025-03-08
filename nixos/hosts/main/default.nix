{
  pkgs,
  inputs,
  ...
}:
let
  dnsServers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
  hyprPackages = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  home-manager.backupFileExtension = "backup";
  nixpkgs.config.allowUnfree = true;

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

  console = {
    keyMap = "colemak";
  };

  networking = {
    hostName = "nixos-laptop";
    wireless.iwd.enable = true;
    useNetworkd = true;
    nameservers = dnsServers;
  };

  systemd.network = {
    enable = true;
    networks."40-wired" = {
      matchConfig.Name = "enp*";
      networkConfig = {
        DHCP = "yes";
      };
    };
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
    daemon.settings = {
      dns = dnsServers;
    };
  };

  systemd = {
    user.services.pipewire = {
      serviceConfig = {
        TimeoutStopSec = 5;
        Restart = "always";
        RestartSec = 2;
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };

  programs = {
    fish = {
      enable = true;
      package = pkgs.fish;
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
    nix-ld = {
      # fix unpatched dynamic libraries (ex., installed via neovim mason)
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
      ];
    };
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.caskaydia-cove
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "CaskaydiaCove Nerd Font" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    tmux
    git
    jq
    libnotify
    apfs-fuse

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

      wireplumber.extraConfig."10-bluez" = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.enable-aac" = true;
          "bluez5.enable-aptx" = true;
          "bluez5.enable-aptx-hd" = true;
          "bluez5.enable-ldac" = true;
          "bluez5.a2dp.assume-no-resampling" = true;
          "bluez5.default-profile" = "a2dp-sink";
          "bluez5.roles" = [
            "a2dp_sink"
            "a2dp_source"
            "hsp_hs"
            "hsp_ag"
            "hfp_hf"
            "hfp_ag"
          ];

          "bluez5.codecs" = [
            "ldac"
            "aptx_hd"
            "aptx"
            "aac"
            "sbc_xq"
            "sbc"
          ];
        };
      };
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
    };
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
        "network"
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
