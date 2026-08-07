{den, ...} : {
  den.aspects.hierophant = {
    includes = with den.aspects; [ network-manager impermanence ssh nix cloudflared caddy jellyfin close-lid ];

    nixos =
      { pkgs, ... }:
      {
        imports = [../old/configuration.nix];
      };
  };
}
