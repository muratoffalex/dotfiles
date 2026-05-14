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
    extraHosts = ''
      127.0.0.1    frontend-sl.local
      127.0.0.1    backend-sl.local
      127.0.0.1    apidoc.backend-sl.local
      127.0.0.1    apidoc.frontend-sl.local
      127.0.0.1    www.frontend-sl.local
    '';
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
