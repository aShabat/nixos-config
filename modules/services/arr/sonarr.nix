{
  den.aspects.sonarr = {
    nixos = {
      services.sonarr = {
        enable = true;

        settings = {
          update.automatically = true;
        };
      };
    };

    caddy-configs."http://sonarr.antosha.xyz" = ''
      reverse_proxy 127.0.0.1:8989
    '';

    persist.directories = ["/var/lib/sonarr"];
  };
}
