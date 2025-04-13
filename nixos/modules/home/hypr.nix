{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    # ref: https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/#using-the-home-manager-module-with-nixos
    package = null;
    portalPackage = null;
  };

  services.swayosd.enable = true;

  home.packages = with pkgs; [
    # hyprland packages
    brightnessctl
    playerctl
    pavucontrol
    wlsunset
    waybar
    swaynotificationcenter
    wl-clipboard
    hyprpaper
    hypridle
    hyprpicker
    hyprcursor
    hyprshot
    hyprpolkitagent
    hyprlock

    # utils
    acpi # hypridle
    socat # hyprland monitors
    jq
    libnotify
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
