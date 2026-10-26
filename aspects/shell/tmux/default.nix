{
  homeManager = {config, ...}: {
    programs.tmux.enable = true;
    xdg.configFile."tmux/tmux.conf".enable = false;

    home.file.".config/tmux".source =
      config.lib.file.mkOutOfStoreSymlink "/etc/nixos/aspects/shell/tmux";
  };
}
