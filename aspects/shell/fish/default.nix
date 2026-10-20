{den, ...}: {
  includes = [den.aspects.shell.aliases];

  nixos = {
    programs.fish.enable = true;
  };

  user = {config, ...}: {
    shell = config.programs.fish.package;
  };

  homeManager = {config, ...}: {
    home.file.".config/fish".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/aspects/shell/fish";
  };

  persist.home.files = [".local/share/fish/fish_history"];
}
