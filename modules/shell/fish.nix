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

        binds = {
          ctrl-s = {
            command = "fish_commandline_prepend sudo";
            repaint = true;
          };
        };
      };

      home.shell.enableFishIntegration = false;
    };

    persist.home.files = [".local/share/fish/fish_history"];
  };
}
