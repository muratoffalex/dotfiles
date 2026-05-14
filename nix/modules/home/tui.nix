{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jjui
    aerc
    yazi
    bluetui
    impala
    btop
    lazygit
    lazydocker
  ];
}
