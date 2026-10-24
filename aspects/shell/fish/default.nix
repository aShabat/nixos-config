let
  set_soft_fish_var = name: value: "if not set -q ${name}; set -gx ${name} ${value}; end";
in {
  nixos = {
    lib,
    config,
    ...
  }: {
    programs.fish = {
      enable = true;
    };

    environment.etc."fish/config.fish".enable = lib.mkForce false;
    environment.etc."fish/conf.d/env.fish".text =
      lib.concatMapAttrsStringSep "\n"
      set_soft_fish_var
      config.environment.variables;
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
    home.file.".local/share/fish/env.fish".text = lib.concatMapAttrsStringSep "\n" set_soft_fish_var config.home.sessionVariables;
  };

  persist.home.files = [".local/share/fish/fish_history"];
}
