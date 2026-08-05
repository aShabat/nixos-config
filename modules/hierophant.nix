{den, ...} : {
  den.aspects.hierophant = {
    includes = with den.aspects; [ network-manager impermanence ];

    nixos =
      { pkgs, ... }:
      {
        imports = [../old/configuration.nix];
      };
  };
}
