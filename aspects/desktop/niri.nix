{den, ...}: {
  nixos = {config, ...}: {
    includes = with den.aspects; [keyring];

    programs.niri = {
      enable = true;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${config.programs.niri.package}/bin/niri-session";
        };
      };
    };
    systemd.user.services.niri.enableDefaultPath = false;
  };
}
