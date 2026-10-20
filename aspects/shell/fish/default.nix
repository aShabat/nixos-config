{
  nixos = {lib, ...}: {
    programs.fish = {
      enable = true;
    };

    environment.etc."fish/config.fish".enable = lib.mkForce false;
  };

  user = {config, ...}: {
    shell = config.programs.fish.package;
  };

  homeManager = {
    lib,
    config,
    ...
  }: {
    programs.fish.enable = true;
    home.shell.enableFishIntegration = false;

    xdg.configFile."fish/config.fish".enable = lib.mkForce false;
    home.file.".config/fish".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/aspects/shell/fish";
  };

  persist.home.files = [".local/share/fish/fish_history"];
}
