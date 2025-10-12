{ config, pkgs, ... }: {
  services.transmission = {
    enable = true;
    settings = {
      download-dir = "/home/muratoffalex/switch-server/Nintendo/Switch";
      watch-dir = "/home/muratoffalex/Downloads/Telegram\\ Desktop";
      watch-dir-enabled = true;
      incomplete-dir-enabled = false;
    };
  };

  services.nginx = {
    enable = true;
    user = "muratoffalex";
    group = "users";
    config = ''
      events {}
      http {
        server {
          listen 8080;
          root /home/muratoffalex/switch-server;
          location /Nintendo/Switch/ {
            autoindex on;
            allow 192.168.0.0/16;
            deny all;
          }
        }
      }
    '';
  };

  system.activationScripts.setup-switch-dirs.text = ''
    mkdir -p /home/muratoffalex/switch-server/Nintendo/Switch
    chown -R muratoffalex:users /home/muratoffalex/switch-server
  '';
}
