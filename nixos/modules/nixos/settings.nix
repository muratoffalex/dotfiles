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
    };
    # keep nix develop derivations
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
  };
}
