{den, ...} : {
  den.aspects.hierophant = {
    includes = with den.aspects; [ network-manager impermanence ssh nix cloudflared ];

    nixos =
      { pkgs, ... }:
      {
        imports = [../old/configuration.nix];
      };
  };
}
