{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clang
    nodejs_latest
    go_1_26
    delve
    cargo
    uv
    python3
    python3Packages.pysocks # for aider
    tokei
    postgresql
    golangci-lint
    go-mockery
    tree
    insomnia
  ];
}
