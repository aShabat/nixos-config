{den, ...} : {
  den.aspects.fish = {
    includes = [ den.aspects.aliases ];
   
    nixos = {
      programs.fish.enable = true;
    };

    user = {config, ...} : {
      shell = config.programs.fish.package;
    };

    homeManager = {
      programs.fish = {
        enable = true;
	preferAbbrs = true;
      };
    };

    persist.home.files = [ ".local/share/fish/fish_history" ];
  };
}
