{ config, ... }:
{
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
    daemon.settings = {
      dns = config.networking.dnsServers;
    };
  };
}
