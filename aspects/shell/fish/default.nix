{
  nixos = {lib, ...}: {
    programs.fish = {
      enable = true;
    };

    environment.etc."fish/config.fish".text = lib.mkForce "";
  };

  user = {config, ...}: {
    shell = config.programs.fish.package;
  };

  homeManager = {config, ...}: {
    home.file.".config/fish".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/aspects/shell/fish";
  };

  persist.home.files = [".local/share/fish/fish_history"];
}
