{
  den,
  lib,
  ...
}: {
  den.quirks.caddy-configs = {};

  den.aspects.caddy = {
    includes = with den.aspects; [firewall cloudflared];

    nixos = {caddy-configs, ...}: let
      config-to-virtualHost = _: cfg:
        if (lib.isString cfg)
        then {extraConfig = cfg;}
        else cfg;
      virtualHosts = lib.mapAttrs config-to-virtualHost (lib.mergeAttrsList caddy-configs);
    in {
      services.caddy = {
        enable = true;
        email = "anton.shabat@gmail.com";

        openFirewall = true;
        globalConfig = ''
          default_bind 127.0.0.1
        '';

        inherit virtualHosts;
      };
    };

    persist.directories = ["/var/lib/caddy" "/var/log/caddy"];

    caddy-configs = {
      ":80" = ''
        respond "Hello world!"
      '';
    };
  };
}
