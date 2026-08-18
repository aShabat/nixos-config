{...}: {
  den.aspects.netbird = {
    server = {
      nixos = {
        services.netbird = {
          enable = true;
          domain = "https://netbird.antosha.xyz";
          management.oidcConfigEndpoint = "https://id.antosha.xyz";
        };
      };

      persist.directories = ["/var/lib/netbird"];
    };
  };
}
