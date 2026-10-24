{
  den,
  aspect-utils,
  ...
}: {
  includes = with den.aspects; [keyring];
  nixos = {config, ...}: {
    programs.niri = {
      enable = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${config.programs.niri.package}/bin/niri-session";
          user = "anton";
        };
      };
    };
    systemd.user.services.niri.enableDefaultPath = false;
  };

  homeManager = {
    pkgs,
    config,
    ...
  }: {
    home.file.".config/niri".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/aspects/desktop/niri/config";

    home.packages = [pkgs.noctalia];
    home.file.".config/noctalia".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/aspects/desktop/niri/noctalia/";
  };

  provides.to-users.includes = [aspect-utils.self];
}
