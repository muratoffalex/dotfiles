{ pkgs, ... }:

{
  environment.etcBackupExtension = ".bak";
  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  time.timeZone = "Asia/Yekaterinburg";

  environment.packages = with pkgs; [
    vim
    git
    curl
    wget
  ];

  programs.fish.enable = true;

  users.users = {
    nix-on-droid = {
      isNormalUser = true;
      extraGroups = [ "docker" ];
      # mkpasswd --method=sha-512
      hashedPassword = "$6$6E4ccds90qX/D6P3$iMcNxicNyi5g5UAF9ykJzoooiykikLmzJ4Cq6.vv5HgNl2Ra8UDxJ/HczWBFznVhyMTY56VjctHeBu0Q9q/NZ1";
      shell = pkgs.fish;
    };
  };

  home-manager = {
    backupFileExtension = "hm-bak";

    config = { config, lib, pkgs, inputs, ... }:
      {
        imports = [
          ../../modules/home/base.nix
          ../../modules/home/ai.nix
          ../../modules/home/dev.nix
          ../../modules/home/tui.nix
          ../../modules/home/programs/fish.nix
          ../../modules/home/programs/neovim.nix
          ../../modules/home/programs/direnv.nix
        ];
        home.stateVersion = "24.05";
      };
  };
}
