{ pkgs, ... }:
{
  users.users = {
    root = {
      shell = pkgs.fish;
      hashedPassword = null;
    };
    muratoffalex = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "docker"
        "network"
        "video"
      ];
      # mkpasswd --method=sha-512
      hashedPassword = "$6$6E4ccds90qX/D6P3$iMcNxicNyi5g5UAF9ykJzoooiykikLmzJ4Cq6.vv5HgNl2Ra8UDxJ/HczWBFznVhyMTY56VjctHeBu0Q9q/NZ1";
      shell = pkgs.fish;
    };
  };
}
