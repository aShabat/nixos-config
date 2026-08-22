{
  den.aspects.qbittorrent = {
    nixos = let
      torrentingPort = 45123;
    in {
      services.qbittorrent = {
        enable = true;
        inherit torrentingPort;
      };

      networking.firewall.allowedTCPPorts = torrentingPort;
    };

    caddy-configs."http://torrent.antosha.xyz" = ''
      reverse_proxy 127.0.0.1:8080
    '';

    persist.directories = ["/var/lib/qbittorrent"];
  };
}
