{den, ...}: {
  den.aspects.jellyfin = {
    includes = [den.aspects.caddy];

    nixos = {
      services.jellyfin = {
        enable = true;
      };

      users.users.jellyfin.extraGroups = ["media"];
    };

    persist.directories = [
      "/var/cache/jellyfin"
      "/var/lib/jellyfin"
    ];

    caddy-configs."http://media.antosha.xyz" = ''
      reverse_proxy 127.0.0.1:8096
    '';
  };
}
