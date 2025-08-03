{ config, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = false;
    setSocketVariable = true;
    daemon.settings = {
      dns = config.networking.dnsServers;
    };
  };
}
