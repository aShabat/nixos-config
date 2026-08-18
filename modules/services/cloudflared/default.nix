{lib, ...}: {
  den.aspects.cloudflared = {
    nixos = {host, ...}: let
      match-host = hostName: host.hostName == hostName;
    in {
      services.cloudflared = {
        enable = true;
        certificateFile = ./cert.secret.pem;
        tunnels = {
          "ada01390-9695-4235-bce2-4317aff132c1" = lib.mkIf (match-host "scribe") {
            credentialsFile = ./ada01390-9695-4235-bce2-4317aff132c1.secret.json;
            default = "http://localhost:80";
          };
        };
      };
    };
  };
}
