{
  den.aspects.nh = {
    homeManager = {
      programs.nh = {
        enable = true;
        flake = "/etc/nixos";
        clean = {
          enable = true;
          dates = "weekly";
        };
      };
    };
  };
}
