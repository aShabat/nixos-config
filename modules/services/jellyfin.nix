{den, ...}: {
  den.aspects.jellyfin = {
    includes = [den.aspects.caddy];

    nixos = {
      services.jellyfin = {
        enable = true;
        hardwareAcceleration = {
          enable = true;
          device = "/dev/dri/renderD128";
          type = "qsv";
        };
      };

      hardware.graphics.enable = true;
      users.users.jellyfin.extraGroups = ["media" "render" "video"];
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
