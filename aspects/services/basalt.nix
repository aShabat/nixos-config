{
  den,
  inputs,
  ...
}: {
  flake-file.inputs.basalt = {
    url = "github:aShabat/basalt/main";
    flake = false;
  };

  includes = [den.aspects.services.caddy];

  nixos = {
    pkgs,
    lib,
    ...
  }: let
    basalt = pkgs.buildNpmPackage {
      pname = "basalt";
      version = "0-unstable";
      src = inputs.basalt;
      # Resolve dependencies from package-lock.json's integrity hashes so
      # updating Basalt never requires recomputing npmDepsHash.
      npmDeps = pkgs.importNpmLock {npmRoot = inputs.basalt;};
      npmConfigHook = pkgs.importNpmLock.npmConfigHook;
      nodejs = pkgs.nodejs_22;
      # Basalt's .gitignore excludes dist, and npm pack honours it.
      postInstall = ''
        cp -r dist $out/lib/node_modules/basalt/dist
      '';
    };
    appDir = "${basalt}/lib/node_modules/basalt";
    node = "${pkgs.nodejs_22}/bin/node";
    tsx = "${appDir}/node_modules/tsx/dist/cli.mjs";
    env = {
      NODE_ENV = "production";
      PORT = "3000";
      DATABASE_URL = "/run/postgresql";
      DATABASE_USER = "basalt";
      DATABASE_DB = "basalt";
      DATABASE_PORT = "5432";
    };
  in {
    # Direct public TLS: the caddy aspect binds to loopback for the tunnel setup.
    services.caddy.globalConfig = lib.mkForce "";

    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_18;
      ensureDatabases = ["basalt"];
      ensureUsers = [
        {
          name = "basalt";
          ensureDBOwnership = true;
        }
      ];
    };

    users.users.basalt = {
      isSystemUser = true;
      group = "basalt";
      home = "/var/lib/basalt";
    };
    users.groups.basalt = {};

    systemd.services.basalt-secret = {
      description = "Generate the basalt JWT key";
      wantedBy = ["multi-user.target"];
      before = ["basalt.service"];
      unitConfig.ConditionPathExists = "!/var/lib/basalt/jwt.env";
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        umask 077
        ${pkgs.coreutils}/bin/install -d -m 0750 -o basalt -g basalt /var/lib/basalt
        echo "JWT_KEY=$(${pkgs.openssl}/bin/openssl rand -hex 32)" > /var/lib/basalt/jwt.env
      '';
    };

    systemd.services.basalt = {
      description = "Basalt note app";
      wantedBy = ["multi-user.target"];
      after = ["network.target" "postgresql.service" "basalt-secret.service"];
      requires = ["postgresql.service" "basalt-secret.service"];
      environment = env;
      serviceConfig = {
        User = "basalt";
        Group = "basalt";
        WorkingDirectory = appDir;
        EnvironmentFile = "/var/lib/basalt/jwt.env";
        ExecStartPre = pkgs.writeShellScript "basalt-init-db" ''
          if [ ! -e /var/lib/basalt/.db-initialized ]; then
            ${node} ${tsx} src/extra/init_db.ts
            ${pkgs.coreutils}/bin/touch /var/lib/basalt/.db-initialized
          fi
        '';
        ExecStart = "${node} ${tsx} src/server/main.ts";
        Restart = "on-failure";
        RestartSec = 3;
      };
    };
  };

  caddy-configs."basalt.antosha.xyz" = ''
    reverse_proxy 127.0.0.1:3000
  '';

  persist.directories = [
    "/var/lib/basalt"
    "/var/lib/postgresql"
  ];
}
