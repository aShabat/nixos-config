{den, ...} : {
  den.aspects.nix = {
    includes = [ den.aspects.home-manager ];

    nixos = {
      nix.extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };
  };
}
