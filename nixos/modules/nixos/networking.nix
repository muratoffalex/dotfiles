{ config, ... }:
{
  networking = {
    hostName = "nixos-laptop";
    wireless.iwd.enable = true;
    useNetworkd = true;
    nameservers = config.networking.dnsServers;
  };

  systemd.network = {
    enable = true;
    networks."40-wired" = {
      matchConfig.Name = "enp*";
      networkConfig = {
        DHCP = "yes";
      };
    };
  };
}
