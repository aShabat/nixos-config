{den, lib, ...} : {
  den.quirks.caddy-configs = {};

  den.aspects.caddy = {
    includes = [ den.aspects.firewall ];

    nixos = {caddy-configs, ...} : let
      config-to-virtualHost = _: cfg: if (lib.isString cfg) then { listenAddresses = [ "127.0.0.1" ]; extraConfig = cfg; } else cfg;
      virtualHosts = lib.mapAttrs config-to-virtualHost (lib.mergeAttrsList caddy-configs);
    in {
      services.caddy = {
        enable = true;
        email = "anton.shabat@gmail.com";
	
	openFirewall = true;

	inherit virtualHosts;
      };
    };

    persist.directories = [ "/var/lib/caddy" "/var/log/caddy" ];
  };

}
