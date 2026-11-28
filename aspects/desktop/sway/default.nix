{
  den,
  aspect-utils,
  ...
}: {
  includes = with den.aspects; [keyring];
  nixos = {
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
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
    xdg.portal.configPackages = [pkgs.sway];
    home.file.".config/sway".source = config.lib.file.mkOutOfStoreSymlink ("/etc/nixos/aspects/desktop/sway/configs/" + host.hostName);

    home.packages = with pkgs; [noctalia playerctl];
  };

  provides.to-users.includes = [aspect-utils.self];
}
