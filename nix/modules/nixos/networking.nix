{ config, ... }:
{
  networking = {
    hostName = "nixos-laptop";
    wireless.iwd.enable = true;
    useNetworkd = true;
    nameservers = config.networking.dnsServers;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8085 9000 ];
    };
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
