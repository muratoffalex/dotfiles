{
  nix.settings = {
    trusted-users = [
      "root"
      "muratoffalex"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
