{
  den,
  aspect-utils,
  ...
}: {
  includes = with den.aspects; [keyring];
  nixos = {
    programs.niri = {
      enable = true;
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

  persist.home.directories = [".local/state/noctalia"];

  provides.to-users.includes = [aspect-utils.self];
}
