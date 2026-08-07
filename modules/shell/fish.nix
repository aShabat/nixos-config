{
  den.aspects.fish = {
    nixos = {
      programs.fish.enable = true;
    };

    user = {config, ...} : {
      shell = config.programs.fish.package;
    };
  };
}
