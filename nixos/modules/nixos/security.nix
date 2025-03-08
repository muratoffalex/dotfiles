{ ... }:
{
  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
    polkit.enable = true;
  };
}
