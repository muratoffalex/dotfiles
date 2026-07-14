{
  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
    enableFishIntegration = true;

    config = {
      global.hide_env_diff = true;
      whitelist.prefix = [ "~/dev/" ];
    };
  };
}
