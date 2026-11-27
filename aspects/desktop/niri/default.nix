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

    environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
    systemd.user.services.niri.enableDefaultPath = false;
  };

  homeManager = {
    host,
    pkgs,
    config,
    ...
  }: {
    xdg.portal.configPackages = [pkgs.niri];
    home.file.".config/niri".source = config.lib.file.mkOutOfStoreSymlink ("/etc/nixos/aspects/desktop/niri/configs/" + host.hostName);

    home.packages = with pkgs; [noctalia xwayland-satellite playerctl];
    home.file.".config/noctalia".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/aspects/desktop/niri/noctalia/";
  };

  persist.home.directories = [".local/state/noctalia" ".local/state/wireplumber"];

  provides.to-users.includes = [aspect-utils.self];
}
