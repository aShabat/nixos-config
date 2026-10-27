{den, ...}: {
  includes = [den.aspects.services.caddy];

  nixos = {
    services.bazarr = {
      enable = true;
      group = "media";
    };

    users.users.bazarr.extraGroups = ["media"];
  };

  persist.directories = ["/var/lib/bazarr"];

  caddy-configs."http://bazarr.antosha.xyz" = ''
    reverse_proxy 127.0.0.1:6767
  '';
}
