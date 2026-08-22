{
  den.aspects.prowlarr = {
    nixos = {
      services.prowlarr = {
        enable = true;
      };
    };

    caddy-configs."http://prowlarr.antosha.xyz" = ''
      reverse_proxy 127.0.0.1:9696
    '';

    persist.directories = ["/var/lib/private/prowlarr"];
  };
}
