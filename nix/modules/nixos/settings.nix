{
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
      auto-optimise-store = true;
    };
    # keep nix develop derivations
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
  };
}
