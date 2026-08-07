{
  den.aspects.neovim = {pkgs, ...} : {
    homeManager = {
      home.packages = with pkgs; [
        neovim-unwrapped
      ];
    };
  };
}
