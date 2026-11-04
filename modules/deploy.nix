{
  self,
  inputs,
  config,
  lib,
  ...
}: let
  inherit (inputs) deploy-rs nixpkgs;
  mkNode = system: host: let
    drv = deploy-rs.lib.${system};
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    hostname = host.hostName;
    profilesOrder = ["system" "config-sync"];

    profiles.system = {
      user = "root";
      path = drv.activate.nixos self.nixosConfigurations.${host.hostName};
    };

    profiles.config-sync = {
      user = "anton";
      path =
        drv.activate.custom (pkgs.buildEnv {
          name = "nixos-config-sync";
          paths = with pkgs; [git git-crypt];
        }) ''
          export PATH="$PROFILE/bin:$PATH"
          exec "$PROFILE/bin/git" -C /etc/nixos pull --ff-only
        '';
    };
  };
in {
  flake.deploy = {
    remoteBuild = true;
    nodes =
      lib.concatMapAttrs
      (system: hosts: lib.mapAttrs (_: host: mkNode system host) hosts)
      config.den.hosts;
  };
}
