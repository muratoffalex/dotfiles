{ pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

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
