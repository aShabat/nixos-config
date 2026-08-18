{
  den.aspects.pocket-id = {
    nixos = {
      services.pocket-id = {
        enable = true;
        settings = {
          TRUST_PROXY = true;
          APP_URL = "https://id.antosha.xyz";
          ENCRYPTION_KEY = builtins.readFile ./encryption-key.secret;
        };
      };
    };

    persist.directories = ["/var/lib/pocket-id"];

    caddy-configs."http://id.antosha.xyz" = ''
      reverse_proxy 127.0.0.1:1411
    '';
  };
}
