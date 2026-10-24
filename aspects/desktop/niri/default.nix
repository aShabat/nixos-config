{
  den,
  aspect-utils,
  ...
}: {
  includes = with den.aspects; [keyring aspect-utils.self.noctalia];
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
  provides.to-users.includes = [aspect-utils.self];

  homeManager = {config, ...}: {
    home.file.".config/niri".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/aspects/desktop/niri";
  };
}
