{
  homeManager = {lib, ...}: {
    programs.tmux.enable = true;
    xdg.configFile."tmux/tmux.conf".enable = lib.mkForce false;
  };
}
