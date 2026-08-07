{den, ...} : {
  den.aspects.jellyfin = {
    includes = [ den.aspects.caddy ];
  
    nixos = {
      services.jellyfin = {
        enable = true;
      };
    };

    persist.directories = [
      "/var/cache/jellyfin"
      "/var/lib/jellyfin"
    ];

    caddy-configs."hierophant.antosha.xyz" = ''
    reverse_proxy 127.0.0.1:8096
    '';
  };
}
