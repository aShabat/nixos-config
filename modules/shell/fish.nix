{den, ...}: {
  den.aspects.shell.fish = {
    includes = [den.aspects.shell.aliases];

    nixos = {
      programs.fish.enable = true;
    };

    user = {config, ...}: {
      shell = config.programs.fish.package;
    };

    homeManager = {
      programs.fish = {
        enable = true;
        preferAbbrs = true;
      };
    };

    persist.home.files = [".local/share/fish/fish_history"];
  };
}
