{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    sesh
    gitmux
    zoxide
    fzf
    eza
    ripgrep
    fd
    jujutsu
    chezmoi
  ];
}
