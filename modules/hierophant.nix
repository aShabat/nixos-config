{den, ...} : {
  den.aspects.hierophant = {
    includes = with den.aspects; [ network-manager impermanence ssh nix cloudflared caddy ];

    nixos =
      { pkgs, ... }:
      {
        imports = [../old/configuration.nix];
      };
  };
}
