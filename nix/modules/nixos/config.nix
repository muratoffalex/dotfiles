{ lib, ... }:
{
  options.networking.dnsServers = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };
}
