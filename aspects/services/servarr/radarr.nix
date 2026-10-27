{den, ...}: {
  includes = [den.aspects.services.caddy];

  nixos = {
    services.radarr = {
      enable = true;
      group = "media";
    };

    users.users.radarr.extraGroups = ["media"];
  };

  caddy-configs."http://radarr.antosha.xyz" = ''
    reverse_proxy 127.0.0.1:7878
  '';

  persist.directories = ["/var/lib/radarr"];
}
