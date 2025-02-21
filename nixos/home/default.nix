{ config, pkgs, ... }:

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
      # flat-remix-gtk
      # kanagawa-gtk-theme
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

  programs.home-manager.enable = true;
  programs.yazi.enable = true;

  # Пример настройки программ
  # programs = {
  #   git = {
  #     enable = true;
  #     userName = "Alex Muratoff";
  #     userEmail = "muratoffalex@gmail.com";
  #   };
  #
  #   fish = {
  #     enable = true;
  #     shellAliases = {
  #       ll = "ls -l";
  #       update = "sudo nixos-rebuild switch";
  #     };
  #   };
  #
  #   starship = {
  #     enable = true;
  #     enableFishIntegration = true;
  #   };
  # };

  # Включаем управление файлами конфигурации
  # home.file = {
  #   ".config/alacritty/alacritty.yml".source = ./dotfiles/alacritty.yml;
  # };
}
