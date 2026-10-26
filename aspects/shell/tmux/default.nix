{aspect-utils, ...}: {
  homeManager = {
    config,
    lib,
    ...
  }: {
    programs.tmux.enable = true;
    xdg.configFile."tmux/tmux.conf".enable = false;
    home.sessionVariables.TMUX_TMPDIR = lib.mkForce "/run/user/$(id -u)";

    home.file.".config/tmux".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/aspects/shell/tmux";
  };

  nixos.environment.enableAllTerminfo = true;

  provides.to-hosts.includes = [aspect-utils.self];
}
