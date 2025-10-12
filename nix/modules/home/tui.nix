{ pkgs, ... }:
{
  home.packages = with pkgs; [
    aerc
    yazi
    bluetui
    impala
    btop
    lazygit
    lazydocker
  ];
}
