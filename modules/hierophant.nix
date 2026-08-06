{den, ...} : {
  den.aspects.hierophant = {
    includes = with den.aspects; [ network-manager impermanence ssh ];

    nixos =
      { pkgs, ... }:
      {
        imports = [../old/configuration.nix];
      };
  };
}
