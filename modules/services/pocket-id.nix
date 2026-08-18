{
  den.aspects.pocket-id = {
    nixos = {
      services.pocket-id = {
        enable = true;
        settings = {
          TRUST_PROXY = true;
          APP_URL = "https://id.antosha.xyz";
        };
      };
    };

    persist.directories = ["/var/lib/pocket-id"];

    caddy-configs."http://id.antosha.xyz" = ''
      reverse-proxy 127.0.0.1:1411
    '';
  };
}
